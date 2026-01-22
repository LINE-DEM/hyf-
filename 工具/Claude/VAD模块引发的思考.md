# 如何提升 Claude Code 的代码质量和避免逻辑错误

## 问题分析：为什么 Sonnet 4.5 还会出现逻辑错误？

### 本次案例的错误根源

**错误代码**：
```csharp
// 先检查连接状态
if (!XunFeiManager.Instance.isConnectted)
{
    continue;  // 未连接就跳过
}

// 发送首包（永远执行不到）
if (!firstPacketSent && state == 0)
{
    SpeechToTextNew(firstFrame);  // 这里才建立连接
}
```

**为什么会出错**：
1. **因果关系倒置**：连接状态检查在首包发送之前，但连接建立在首包发送时
2. **隐式知识缺失**：`SpeechToTextNew()` 内部才建立连接，这个信息在实现计划时未明确
3. **上下文分散**：XunFeiManager 的连接逻辑在另一个文件，未在当前实现中考虑
4. **Plan 模式专注执行**：进入 Plan 模式后，专注于实现步骤，对边界条件的推理减弱

---

## 🎯 提升 Claude Code 质量的最佳实践

### 1️⃣ **提供完整的因果关系图**

#### ❌ 不好的做法：
```
"实现统一音频缓冲区，解决音频丢失问题"
```

#### ✅ 好的做法：
```markdown
## 关键因果关系

**连接建立时机**：
- 首包（state=0）：调用 SpeechToTextNew() → 内部建立 WebSocket 连接
- 中间包（state=1）：依赖已建立的连接，需检查 isConnectted
- 尾包（state=2）：依赖已建立的连接

**状态转换链**：
state=0 → SpeechToTextNew() → 等待返回 → state=1 → 发送中间包

**关键约束**：
- 首包必须等待返回（阻塞）
- 中间包可以异步发送
- 连接断开后不能发送中间包
```

---

### 2️⃣ **使用测试驱动描述（Test-Driven Prompt）**

#### ❌ 不好的做法：
```
"添加 StartByVADWithPreBuffer() 方法"
```

#### ✅ 好的做法：
```markdown
## 实现 StartByVADWithPreBuffer()

### 预期行为：
1. ✅ VAD 触发时，应捕获到触发前 500ms 的音频
2. ✅ 首包应包含预缓冲的第一帧（640 样本）
3. ✅ 首包发送应等待返回（阻塞），确保连接建立
4. ✅ 预缓冲剩余部分应在连接建立后立即发送
5. ✅ 实时音频应在连接建立后持续发送

### 边界情况：
- ❌ 如果在连接建立前发送中间包 → 应该等待或缓存
- ❌ 如果预缓冲为空 → 应该等待实时数据作为首包
- ❌ 如果连接失败 → 应该重试或报错，不应死锁

### 错误场景：
- 🚫 不应该：在首包发送前检查连接状态（因为连接是首包建立的）
- 🚫 不应该：在未连接时发送中间包（会导致错误）
- 🚫 不应该：跳过首包发送（会导致永远不连接）
```

---

### 3️⃣ **分阶段实现 + 验证**

#### ❌ 不好的做法：
```
"一次性实现完整的统一音频缓冲方案"
```

#### ✅ 好的做法：
```markdown
## 分阶段实现

### 阶段 1：基础缓冲区（10 分钟）
- 实现 UnifiedAudioBuffer 环形缓冲
- 验证：音频写入和读取正确

### 阶段 2：预缓冲捕获（10 分钟）
- 实现 CapturePreBuffer()
- 验证：能捕获到正确时长的历史音频

### 阶段 3：帧打包（10 分钟）
- 实现 640 样本帧的自动打包
- 验证：帧大小和队列正确

### 阶段 4：首包发送逻辑（20 分钟）⚠️ 关键
- 实现首包（state=0）发送
- **验证**：
  - [ ] 首包不检查连接状态
  - [ ] 首包阻塞等待返回
  - [ ] 返回后 state=1
  - [ ] 连接已建立（isConnectted=true）

### 阶段 5：中间包发送（10 分钟）
- 实现中间包（state=1）循环发送
- **验证**：
  - [ ] 检查连接状态
  - [ ] 只在已连接时发送

### 阶段 6：集成测试
- 验证整个流程
```

---

### 4️⃣ **使用 Code Review Prompt**

#### 实现完成后，使用以下 Prompt 让 Claude 检查自己的代码：

```markdown
## Code Review 请求

我刚刚实现了 UnifiedBufferRecordingCoroutine()，请帮我检查以下方面：

### 1. 逻辑顺序检查
- [ ] 连接状态检查是否在正确的位置？
- [ ] 是否存在"先检查后建立"的死锁？
- [ ] 状态转换顺序是否正确？

### 2. 边界情况
- [ ] 如果预缓冲为空会怎样？
- [ ] 如果连接失败会怎样？
- [ ] 如果网络断开会怎样？

### 3. 异步问题
- [ ] 是否存在竞态条件？
- [ ] 是否有未等待的异步操作？
- [ ] 线程安全是否正确？

### 4. 特定于本项目的问题
- [ ] XunFeiManager 的连接建立时机是否正确处理？
- [ ] state=0 和 state=1 的发送逻辑是否匹配讯飞协议？
- [ ] 是否正确使用了 SessionManager vs XunFeiManager？

请指出所有潜在问题。
```

---

### 5️⃣ **提供关键代码的运行时序图**

#### ✅ 好的做法：
```markdown
## 运行时序图

时刻 T=0: VAD 检测到人声
         ↓
T=10ms:  HandleLongDialogVoiceStart()
         ↓
T=20ms:  StartByVADWithPreBuffer()
         ├─ UnifiedAudioBuffer.StartASRStreaming()
         └─ StartCoroutine(UnifiedBufferRecordingCoroutine)
         ↓
T=30ms:  协程第一次执行
         ├─ state=0, firstPacketSent=false
         ├─ 跳过连接检查（关键！）
         ├─ CapturePreBuffer() → 获取 500ms 历史音频
         ├─ 提取首帧 1280 字节
         ├─ SpeechToTextNew(首帧) ← 开始建立连接
         └─ yield WaitUntil(返回)
         ↓
T=150ms: XunFei 返回首包响应
         ├─ isConnectted = true
         ├─ state = 1
         ├─ 发送预缓冲剩余部分
         └─ 进入中间包循环
         ↓
T=200ms: 协程第二次执行
         ├─ state=1, isConnectted=true
         ├─ 检查连接状态 ✅ 通过
         ├─ 从队列获取实时帧
         └─ STTSendMessageNew(frame, 1)
         ↓
T=240ms: 协程第三次执行
         └─ 持续发送中间包...
```

---

### 6️⃣ **使用 /remember 保存关键知识**

```markdown
## 关键设计决策（使用 /remember 保存）

### XunFei WebSocket 连接机制
- 连接建立：只能通过发送首包（state=0）触发
- 首包方法：XunFeiManager.SpeechToTextNew(pcmData)
- 首包特点：阻塞等待返回，成功后 isConnectted=true
- 中间包方法：XunFeiManager.STTSendMessageNew(pcmData, 1)
- 中间包前提：必须 isConnectted=true

### 状态机关键约束
- state=0: 未连接，需要发送首包
- state=1: 已连接，可以发送中间包
- state=2: 尾包，结束会话

### 反模式警告
- 🚫 永远不要在首包发送前检查 isConnectted
- 🚫 永远不要在未连接时发送中间包（state=1）
- 🚫 永远不要跳过首包发送
```

---

### 7️⃣ **使用断言和前置条件**

#### ✅ 好的做法：在实现中添加显式检查
```csharp
// 发送首包（state=0）
if (!firstPacketSent && state == 0)
{
    // 前置条件：首包不应该检查连接状态
    Debug.Assert(!XunFeiManager.Instance.isConnectted,
        "首包发送时不应该已连接");

    // 获取预缓冲
    byte[] preBuffer = audioBuffer.CapturePreBuffer();

    // 前置条件：预缓冲不应为空
    Debug.Assert(preBuffer != null && preBuffer.Length > 0,
        "预缓冲不应为空");

    // 发送首包
    Task<string> result = SpeechToTextNew(firstFrame);
    yield return new WaitUntil(() => result.IsCompleted);

    // 后置条件：连接应该已建立
    Debug.Assert(XunFeiManager.Instance.isConnectted,
        "首包返回后应该已连接");

    state = 1;
}

// 发送中间包（state=1）
if (state == 1)
{
    // 前置条件：必须已连接
    Debug.Assert(XunFeiManager.Instance.isConnectted,
        "发送中间包时必须已连接");

    if (XunFeiManager.Instance.isConnectted)
    {
        // 发送中间包
    }
}
```

---

### 8️⃣ **明确指出容易出错的地方**

```markdown
## ⚠️ 特别注意事项

### 本项目中容易出错的模式

#### 反模式 1：检查顺序错误
```csharp
// ❌ 错误：先检查连接，后建立连接
if (!isConnected) continue;
if (state == 0) Connect();  // 永远执行不到
```

```csharp
// ✅ 正确：先建立连接，后检查连接
if (state == 0) Connect();  // 首包建立连接
if (state == 1 && isConnected) SendData();  // 中间包检查连接
```

#### 反模式 2：混淆首包和中间包的发送方式
```csharp
// ❌ 错误：所有包都用 SessionManager.SendAudioFrame()
if (state == 0) _sessionManager.SendAudioFrame(data);  // 不会建立连接！
```

```csharp
// ✅ 正确：区分首包和中间包
if (state == 0) XunFeiManager.SpeechToTextNew(data);  // 建立连接
if (state == 1) XunFeiManager.STTSendMessageNew(data, 1);  // 发送数据
```

#### 反模式 3：异步操作未等待
```csharp
// ❌ 错误：首包未等待返回
SpeechToTextNew(data);
state = 1;  // 立即设置，但连接可能未建立
```

```csharp
// ✅ 正确：首包阻塞等待
Task<string> result = SpeechToTextNew(data);
yield return new WaitUntil(() => result.IsCompleted);
state = 1;  // 确保连接已建立
```
```

---

### 9️⃣ **使用渐进式提问**

#### ❌ 不好的做法：
```
"实现预缓冲功能"
```

#### ✅ 好的做法：
```markdown
## 分步提问

### 第 1 步：理解现有流程
Q: "请分析 Record.cs 中 GetAudoiDataFirst() 的连接建立流程，
    特别是 state=0 和 XunFeiManager.SpeechToTextNew() 的关系"

### 第 2 步：设计验证
Q: "基于你的分析，如果我在发送首包前检查 isConnectted，
    会发生什么？请画出时序图"

### 第 3 步：实现
Q: "现在实现 UnifiedBufferRecordingCoroutine()，
    确保避免刚才分析的问题"

### 第 4 步：Review
Q: "检查你刚才实现的代码，是否存在'先检查连接后建立连接'的死锁？"
```

---

### 🔟 **提供负面案例（Negative Examples）**

```markdown
## 实现预缓冲发送逻辑

### ❌ 错误实现示例（不要这样做）：

```csharp
// 错误案例 1：先检查连接
while (recording)
{
    if (!isConnected) continue;  // ❌ 死锁
    if (state == 0) Connect();   // 永远执行不到
}

// 错误案例 2：不等待首包返回
if (state == 0)
{
    SpeechToTextNew(data);  // 异步操作
    state = 1;              // ❌ 立即设置，连接可能未建立
}

// 错误案例 3：混淆发送方法
if (state == 0)
{
    _sessionManager.SendAudioFrame(data);  // ❌ 不会建立连接
}
```

### ✅ 正确实现要点：
1. 首包（state=0）不检查连接，直接发送
2. 首包阻塞等待返回
3. 首包使用 XunFeiManager.SpeechToTextNew()
4. 中间包检查连接状态
5. 中间包使用 XunFeiManager.STTSendMessageNew(data, 1)
```

---

## 🎓 总结：Claude Code 使用方法论

### 核心原则

1. **明确因果关系** > 功能描述
2. **提供负面案例** > 只提供正面示例
3. **分阶段验证** > 一次性实现
4. **显式约束** > 隐式假设
5. **时序图** > 文字描述
6. **Code Review** > 直接使用

### 具体操作流程

```
第 1 步：提供完整上下文
       ├─ 关键代码片段
       ├─ 因果关系图
       ├─ 状态转换图
       └─ 运行时序图

第 2 步：明确约束和边界
       ├─ 前置条件
       ├─ 后置条件
       ├─ 不变量
       └─ 反模式

第 3 步：分阶段实现
       ├─ 第一阶段：基础功能
       ├─ 第二阶段：边界处理
       └─ 第三阶段：集成测试

第 4 步：Code Review
       ├─ 逻辑顺序检查
       ├─ 边界情况检查
       ├─ 异步问题检查
       └─ 项目特定检查

第 5 步：持续改进
       ├─ /remember 保存关键知识
       ├─ 更新设计文档
       └─ 记录踩坑经验
```

---

## 💡 本次案例的最佳实践应用

### 如果当时这样做：

```markdown
## 实现预缓冲发送逻辑

### 关键因果关系
⚠️ **XunFei 连接建立时机**：
- 连接建立：只能通过 SpeechToTextNew(首包) 触发
- 首包特点：阻塞等待返回，返回后 isConnectted=true
- 中间包前提：必须 isConnectted=true

### ❌ 反模式警告
```csharp
// 永远不要这样做！
if (!isConnected) continue;  // ← 死锁：连接尚未建立
if (state == 0) Connect();   // ← 永远执行不到
```

### ✅ 正确流程
```
state=0 → 不检查连接 → SpeechToTextNew(首帧) → 等待返回 → state=1
state=1 → 检查连接 → STTSendMessageNew(中间包)
```

### 实现要求
1. [ ] 首包（state=0）不检查连接状态
2. [ ] 首包阻塞等待返回
3. [ ] 中间包（state=1）必须检查连接状态
4. [ ] 使用正确的发送方法（首包 vs 中间包）

请实现 UnifiedBufferRecordingCoroutine()，避免上述反模式。
```

**结果**：很可能就不会出现这个错误。

---

## 🚀 立即行动清单

- [ ] 使用 `/remember` 保存"XunFei 连接建立机制"
- [ ] 创建 `CONTRIBUTING.md` 文档，记录本项目的反模式
- [ ] 下次实现复杂功能时，先画时序图
- [ ] 实现完成后，主动要求 Code Review
- [ ] 使用断言验证关键前置/后置条件
- [ ] 记录每次踩坑经验，形成项目特定的最佳实践

---

**记住**：Claude Code 是强大的工具，但需要高质量的输入才能产生高质量的输出。
**关键**：明确因果关系、提供反模式、分阶段验证、主动 Code Review。
