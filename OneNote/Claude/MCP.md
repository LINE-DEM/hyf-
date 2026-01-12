1.Mcp Host
 ![Exported image](Exported%20image%2020260109132336-0.png)  

mcp的启动程序 uvx或者npx  
uv：是py的一个包管理器 类似pip  
uvx：可以直接来启动py程序  
比如：$ uvx ruff 这个指令 安装并且启动ruff uvx会帮你配置好ruff的依赖包和运行环境  
Uvx = uv tool run的缩写 ： 运行UV领域的一个Tool（不是mcp的tool）

![Exported image](Exported%20image%2020260109132338-1.png)

2025-10-23 18:03:45.500] [LOG] [Thread:1] HYF.Guide.Send 让小车开始全局导览  
[2025-10-23 18:03:45.501] [LOG] [Thread:1] HYF SpeekUIForm SetAlphaZero  
[2025-10-23 18:03:45.517] [LOG] [Thread:1] AutoExit | 停止计时器  
[2025-10-23 18:03:45.517] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPaoBack  
[2025-10-23 18:03:45.518] [LOG] [Thread:1] 现在沉默了  
[2025-10-23 18:03:45.519] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_skfkcg-01 targetAnimationName = YT_dj过渡时长：0.5\</color\>  
[2025-10-23 18:03:45.522] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 ： event = 7  
[2025-10-23 18:03:45.526] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 方向结果：1  
[2025-10-23 18:03:45.526] [LOG] [Thread:1] HYF QiPaoUIForm HideQiPao  
[2025-10-23 18:03:45.526] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_skfkcg-01 targetAnimationName = YT_yddh-02(1-57)过渡时长：0.5\</color\>  
[2025-10-23 18:03:45.527] [LOG] [Thread:1] HYF.Guide.Send 让小车开始Move  
[2025-10-23 18:03:45.527] [ERROR] [Thread:1] HYF.Guide.Send 让小车开始Move Error  
[2025-10-23 18:03:45.529] [ERROR] [Thread:1] at NetWorkGuide.Move () [0x00000] in \<fb49795d51f2448aa5a6f3d50985430f\>:0  
at GuideMgr.OnGuideResponse (GuideResponse data) [0x00000] in \<fb49795d51f2448aa5a6f3d50985430f\>:0  
at NetWorkGuide.DispachMessage (GuideResponse data) [0x00000] in \<fb49795d51f2448aa5a6f3d50985430f\>:0  
at NetWorkGuide.StartReceiveLoop () [0x00000] in \<fb49795d51f2448aa5a6f3d50985430f\>:0  
at System.Runtime.CompilerServices.AsyncMethodBuilderCore+MoveNextRunner.InvokeMoveNext (System.Object stateMachine) [0x00000] in \<31687ccd371e4dc6b0c23a1317cf9474\>:0  
at System.Threading.ExecutionContext.RunInternal (System.Threading.ExecutionContext executionContext, System.Threading.ContextCallback callback, System.Object state, System.Boolean preserveSyncCtx) [0x00000] in \<31687ccd371e4dc6b0c23a1317cf9474\>:0  
at System.Threading.ExecutionContext.Run (System.Threading.ExecutionContext executionContext, System.Threading.ContextCallback callback, System.Object state, System.Boolean preserveSyncCtx) [0x00000] in \<31687ccd371e4dc6b0c23a1317cf9474\>:0  
at System.Runtime.CompilerServices.AsyncMethodBuilderCore+MoveNextRunner.Run () [0x00000] in \<31687ccd371e4dc6b0c23a1317cf9474\>:0  
at System.Threading.Tasks.SynchronizationContextAwaitTaskContinuation+\<\>c.\<.cctor\>b__7_0 (System.Object state) [0x00000] in \<31687ccd371e4dc6b0c23a1317cf9474\>:0  
at UnityEngine.UnitySynchronizationContext+WorkRequest.Invoke () [0x00000] in \<1021f49b50624ef58b569d2da7ccfcfe\>:0  
at UnityEngine.UnitySynchronizationContext.Exec () [0x00000] in \<1021f49b50624ef58b569d2da7ccfcfe\>:0  
at UnityEngine.UnitySynchronizationContext.ExecuteTasks () [0x00000] in \<1021f49b50624ef58b569d2da7ccfcfe\>:0  
[2025-10-23 18:03:45.536] [LOG] [Thread:1] HYF.Guide.isMoving Set: True  
[2025-10-23 18:03:45.536] [LOG] [Thread:1] HYF.Guide._isTrueMoving Set: True  
[2025-10-23 18:03:46.000] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_skfkcg-01动画播放结束 过度到targetAnimationName:YT_yddh-02(1-57)此时过渡完毕 过渡时间：0.5045109过渡时长：0.5\</color\>  
[2025-10-23 18:03:46.085] [ERROR] [Thread:1] 类型转换失败：当前 UI 不是 SpeekUIForm 类型  
[2025-10-23 18:03:47.378] [LOG] [Thread:1] 向右介绍播放完成！  
[2025-10-23 18:03:47.378] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(1-57) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.5\</color\>  
[2025-10-23 18:03:47.882] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(1-57)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.5043524过渡时长：0.5\</color\>  
[2025-10-23 18:03:47.907] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPaoBack 播放完毕开启回调 此时开启Yoyo  
[2025-10-23 18:03:48.360] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:03:48.562] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.201397过渡时长：0.2\</color\>  
[2025-10-23 18:03:49.647] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9717，录音块数=22677  
[2025-10-23 18:03:49.647] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:03:51.541] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:03:51.743] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.201683过渡时长：0.2\</color\>  
[2025-10-23 18:03:51.928] [LOG] [Thread:8] 音频缓冲区状态 #22700：长度=64000，是否静音=False  
[2025-10-23 18:03:52.518] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:03:52.720] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2012576过渡时长：0.2\</color\>  
[2025-10-23 18:03:55.695] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:03:55.897] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2023287过渡时长：0.2\</color\>  
[2025-10-23 18:03:56.673] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:03:56.878] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2061091过渡时长：0.2\</color\>  
[2025-10-23 18:03:59.651] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9756，录音块数=22777  
[2025-10-23 18:03:59.651] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:03:59.852] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:00.055] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2022742过渡时长：0.2\</color\>  
[2025-10-23 18:04:00.830] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:01.033] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2020504过渡时长：0.2\</color\>  
[2025-10-23 18:04:01.928] [LOG] [Thread:8] 音频缓冲区状态 #22800：长度=64000，是否静音=False  
[2025-10-23 18:04:04.007] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:04.210] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2031239过渡时长：0.2\</color\>  
[2025-10-23 18:04:04.985] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:05.188] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2023216过渡时长：0.2\</color\>  
[2025-10-23 18:04:08.165] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:08.383] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2151194过渡时长：0.2\</color\>  
[2025-10-23 18:04:09.147] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:09.351] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2040874过渡时长：0.2\</color\>  
[2025-10-23 18:04:09.653] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9796，录音块数=22877  
[2025-10-23 18:04:09.653] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:04:11.929] [LOG] [Thread:8] 音频缓冲区状态 #22900：长度=64000，是否静音=False  
[2025-10-23 18:04:12.323] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:12.525] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2021148过渡时长：0.2\</color\>  
[2025-10-23 18:04:13.299] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:13.501] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2024145过渡时长：0.2\</color\>  
[2025-10-23 18:04:16.476] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:16.682] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2061683过渡时长：0.2\</color\>  
[2025-10-23 18:04:17.457] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:17.658] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2006948过渡时长：0.2\</color\>  
[2025-10-23 18:04:19.660] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9836，录音块数=22977  
[2025-10-23 18:04:19.660] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:04:20.635] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:20.837] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2011053过渡时长：0.2\</color\>  
[2025-10-23 18:04:21.612] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:21.813] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2019433过渡时长：0.2\</color\>  
[2025-10-23 18:04:21.929] [LOG] [Thread:8] 音频缓冲区状态 #23000：长度=64000，是否静音=False  
[2025-10-23 18:04:24.788] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:24.988] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2012063过渡时长：0.2\</color\>  
[2025-10-23 18:04:25.770] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:25.972] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.202583过渡时长：0.2\</color\>  
[2025-10-23 18:04:28.946] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:29.154] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2076021过渡时长：0.2\</color\>  
[2025-10-23 18:04:29.667] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9876，录音块数=23077  
[2025-10-23 18:04:29.668] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:04:29.929] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:30.133] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2034044过渡时长：0.2\</color\>  
[2025-10-23 18:04:31.928] [LOG] [Thread:8] 音频缓冲区状态 #23100：长度=64000，是否静音=False  
[2025-10-23 18:04:33.109] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:33.311] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2028941过渡时长：0.2\</color\>  
[2025-10-23 18:04:34.091] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:34.295] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2041255过渡时长：0.2\</color\>  
[2025-10-23 18:04:37.267] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:37.467] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2009817过渡时长：0.2\</color\>  
[2025-10-23 18:04:38.242] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:38.444] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2011872过渡时长：0.2\</color\>  
[2025-10-23 18:04:39.676] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9916，录音块数=23177  
[2025-10-23 18:04:39.676] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:04:41.421] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:41.623] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2019941过渡时长：0.2\</color\>  
[2025-10-23 18:04:41.928] [LOG] [Thread:8] 音频缓冲区状态 #23200：长度=64000，是否静音=False  
[2025-10-23 18:04:42.401] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:42.602] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2012592过渡时长：0.2\</color\>  
[2025-10-23 18:04:45.578] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:45.779] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2008419过渡时长：0.2\</color\>  
[2025-10-23 18:04:46.555] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:46.759] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2042214过渡时长：0.2\</color\>  
[2025-10-23 18:04:49.681] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9956，录音块数=23277  
[2025-10-23 18:04:49.681] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:04:49.731] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:49.935] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2039627过渡时长：0.2\</color\>  
[2025-10-23 18:04:50.711] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:50.917] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2054283过渡时长：0.2\</color\>  
[2025-10-23 18:04:51.929] [LOG] [Thread:8] 音频缓冲区状态 #23300：长度=64000，是否静音=False  
[2025-10-23 18:04:53.890] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:54.092] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2026361过渡时长：0.2\</color\>  
[2025-10-23 18:04:54.868] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:55.071] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2031709过渡时长：0.2\</color\>  
[2025-10-23 18:04:58.045] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:04:58.246] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2014145过渡时长：0.2\</color\>  
[2025-10-23 18:04:59.025] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:04:59.228] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.202916过渡时长：0.2\</color\>  
[2025-10-23 18:04:59.683] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=9998，录音块数=23377  
[2025-10-23 18:04:59.683] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:01.929] [LOG] [Thread:8] 音频缓冲区状态 #23400：长度=64000，是否静音=False  
[2025-10-23 18:05:02.204] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:02.405] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2017857过渡时长：0.2\</color\>  
[2025-10-23 18:05:03.181] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:03.382] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2012738过渡时长：0.2\</color\>  
[2025-10-23 18:05:06.357] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:06.560] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2027142过渡时长：0.2\</color\>  
[2025-10-23 18:05:07.335] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:07.537] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2025713过渡时长：0.2\</color\>  
[2025-10-23 18:05:09.687] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10039，录音块数=23477  
[2025-10-23 18:05:09.687] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:10.516] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:10.718] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2021836过渡时长：0.2\</color\>  
[2025-10-23 18:05:11.492] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:11.695] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2018276过渡时长：0.2\</color\>  
[2025-10-23 18:05:11.929] [LOG] [Thread:8] 音频缓冲区状态 #23500：长度=64000，是否静音=False  
[2025-10-23 18:05:14.672] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:14.874] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2016902过渡时长：0.2\</color\>  
[2025-10-23 18:05:15.649] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:15.852] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2025544过渡时长：0.2\</color\>  
[2025-10-23 18:05:18.827] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:19.029] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2019842过渡时长：0.2\</color\>  
[2025-10-23 18:05:19.690] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10081，录音块数=23577  
[2025-10-23 18:05:19.691] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:19.807] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:20.011] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2030448过渡时长：0.2\</color\>  
[2025-10-23 18:05:21.928] [LOG] [Thread:8] 音频缓冲区状态 #23600：长度=64000，是否静音=False  
[2025-10-23 18:05:22.985] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:23.187] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2020822过渡时长：0.2\</color\>  
[2025-10-23 18:05:23.963] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:24.166] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2030951过渡时长：0.2\</color\>  
[2025-10-23 18:05:27.143] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:27.344] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2012989过渡时长：0.2\</color\>  
[2025-10-23 18:05:28.124] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:28.325] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2016732过渡时长：0.2\</color\>  
[2025-10-23 18:05:29.693] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10123，录音块数=23677  
[2025-10-23 18:05:29.695] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:31.304] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:31.507] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2025186过渡时长：0.2\</color\>  
[2025-10-23 18:05:31.929] [LOG] [Thread:8] 音频缓冲区状态 #23700：长度=64000，是否静音=False  
[2025-10-23 18:05:32.282] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:32.483] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.201754过渡时长：0.2\</color\>  
[2025-10-23 18:05:35.465] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:35.667] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2020407过渡时长：0.2\</color\>  
[2025-10-23 18:05:36.444] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:36.646] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2025036过渡时长：0.2\</color\>  
[2025-10-23 18:05:39.624] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:39.700] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10165，录音块数=23777  
[2025-10-23 18:05:39.700] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:39.826] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2017739过渡时长：0.2\</color\>  
[2025-10-23 18:05:40.604] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:40.808] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2035648过渡时长：0.2\</color\>  
[2025-10-23 18:05:41.928] [LOG] [Thread:8] 音频缓冲区状态 #23800：长度=64000，是否静音=False  
[2025-10-23 18:05:43.786] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:43.987] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.201383过渡时长：0.2\</color\>  
[2025-10-23 18:05:44.762] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:44.964] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2024783过渡时长：0.2\</color\>  
[2025-10-23 18:05:47.943] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:48.145] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2015287过渡时长：0.2\</color\>  
[2025-10-23 18:05:48.923] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:49.126] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2028956过渡时长：0.2\</color\>  
[2025-10-23 18:05:49.708] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10206，录音块数=23877  
[2025-10-23 18:05:49.708] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:05:51.928] [LOG] [Thread:8] 音频缓冲区状态 #23900：长度=64000，是否静音=False  
[2025-10-23 18:05:52.104] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:52.308] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2031836过渡时长：0.2\</color\>  
[2025-10-23 18:05:53.085] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:53.288] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2027032过渡时长：0.2\</color\>  
[2025-10-23 18:05:56.266] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:05:56.468] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.202131过渡时长：0.2\</color\>  
[2025-10-23 18:05:57.251] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:05:57.459] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2077828过渡时长：0.2\</color\>  
[2025-10-23 18:05:59.711] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10248，录音块数=23977  
[2025-10-23 18:05:59.711] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:06:00.428] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:06:00.630] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2021147过渡时长：0.2\</color\>  
[2025-10-23 18:06:01.409] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:06:01.612] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2027466过渡时长：0.2\</color\>  
[2025-10-23 18:06:01.928] [LOG] [Thread:8] 音频缓冲区状态 #24000：长度=64000，是否静音=False  
[2025-10-23 18:06:04.588] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:06:04.790] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2021396过渡时长：0.2\</color\>  
[2025-10-23 18:06:05.566] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:06:05.768] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2025944过渡时长：0.2\</color\>  
[2025-10-23 18:06:08.740] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:06:08.943] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2024796过渡时长：0.2\</color\>  
[2025-10-23 18:06:09.711] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10290，录音块数=24077  
[2025-10-23 18:06:09.712] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:06:09.720] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:06:09.927] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2072734过渡时长：0.2\</color\>  
[2025-10-23 18:06:11.928] [LOG] [Thread:8] 音频缓冲区状态 #24100：长度=64000，是否静音=False  
[2025-10-23 18:06:12.902] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:06:13.106] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2035478过渡时长：0.2\</color\>  
[2025-10-23 18:06:13.881] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:06:14.085] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2043879过渡时长：0.2\</color\>  
[2025-10-23 18:06:17.058] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(86-181) targetAnimationName = YT_yddh-02(57-86)过渡时长：0.2\</color\>  
[2025-10-23 18:06:17.265] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(86-181)动画播放结束 过度到targetAnimationName:YT_yddh-02(57-86)此时过渡完毕 过渡时间：0.2065932过渡时长：0.2\</color\>  
[2025-10-23 18:06:18.042] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_yddh-02(57-86) targetAnimationName = YT_yddh-02(86-181)过渡时长：0.2\</color\>  
[2025-10-23 18:06:18.247] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_yddh-02(57-86)动画播放结束 过度到targetAnimationName:YT_yddh-02(86-181)此时过渡完毕 过渡时间：0.2047207过渡时长：0.2\</color\>  
[2025-10-23 18:06:19.713] [LOG] [Thread:1] 唤醒状态：音频长度=64000，MSC次数=10332，录音块数=24177  
[2025-10-23 18:06:19.714] [LOG] [Thread:1] 录音设备状态：可用  
[2025-10-23 18:06:21.220] [LOG] [Thread:1] \<color=red\>动画系统开始过

我使用的是UnityEngine.Windows.Speech底层走的是 Windows 自带的语音识别堆栈（SAPI/WinRT）  
但是在unity中使用unity封装后的这个语音唤醒 在一体机上 长时间运行3小时左右 它就无法唤醒了 也没有任何报错信息  
这个问题只有在一体机上才出现 尝试了很多台式机和笔记本都没有出现一体机上这个问题  
后续换成讯飞的语音唤醒 一体机上才正常

[2025-10-27 18:08:09.065] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_dj targetAnimationName = YT_lt过渡时长：0.5\</color\>  
[2025-10-27 18:08:09.065] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPao  
[2025-10-27 18:08:09.091] [LOG] [Thread:1] AutoExit | 停止计时器  
[2025-10-27 18:08:09.091] [LOG] [Thread:1] AutoExit | 启动25s计时器  
[2025-10-27 18:08:09.091] [LOG] [Thread:1] HYF SpeekUIForm HideAnim  
[2025-10-27 18:08:09.092] [LOG] [Thread:1] HYF.GuideUIForm.语音导致暂停  
[2025-10-27 18:08:09.092] [LOG] [Thread:1] HYF.Guide.Send 让小车暂停  
[2025-10-27 18:08:09.139] [LOG] [Thread:1] HYF XunFeiManager Connect -- Start  
[2025-10-27 18:08:09.374] [LOG] [Thread:1] HYF XunFeiManager Connect -- OK  
[2025-10-27 18:08:09.375] [LOG] [Thread:1] 分段发送开始remainLength1280  
[2025-10-27 18:08:09.410] [LOG] [Thread:1] 第一次发送彻底结束  
[2025-10-27 18:08:09.410] [LOG] [Thread:1] HYF 开始语音识别  
[2025-10-27 18:08:09.529] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_dj动画播放结束 过度到targetAnimationName:YT_lt此时过渡完毕 过渡时间：0.501214过渡时长：0.5\</color\>  
[2025-10-27 18:08:11.433] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPao 播放完毕开启回调  
[2025-10-27 18:08:12.117] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_lt targetAnimationName = YT_dj过渡时长：0.2\</color\>  
[2025-10-27 18:08:12.321] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_lt动画播放结束 过度到targetAnimationName:YT_dj此时过渡完毕 过渡时间：0.2034982过渡时长：0.2\</color\>  
[2025-10-27 18:08:12.621] [LOG] [Thread:1] 动画系统Log(CrossFadeToAnimation)：当前动画与目标动画相同，不进行过渡 animationName:YT_dj  
[2025-10-27 18:08:12.828] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_dj动画播放结束 过度到targetAnimationName:YT_ddjh-02此时过渡完毕 过渡时间：0.2074854过渡时长：0.2\</color\>  
[2025-10-27 18:08:14.146] [LOG] [Thread:6] ? 音频数据状态 #28000: 长度=64000, 静音=False  
[2025-10-27 18:08:14.251] [LOG] [Thread:1] 现在沉默了  
[2025-10-27 18:08:14.251] [LOG] [Thread:1] HYF.Guide.Send 让小车开始自动导览  
[2025-10-27 18:08:14.251] [LOG] [Thread:1] HYF 匹配成功切换自动导览  
[2025-10-27 18:08:14.252] [LOG] [Thread:1] 动画系统Log：调用PlaySiKaoAnim方法--YT_skdh-02_LaoYangTuo  
[2025-10-27 18:08:14.252] [WARN] [Thread:1] The AnimationClip 'YT_skdh-02_Book' used by the Animation component 'YT_skdh-02_Book' must be marked as Legacy.  
[2025-10-27 18:08:14.252] [LOG] [Thread:1] Default clip could not be found in attached animations list.  
[2025-10-27 18:08:14.252] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-02 targetAnimationName = YT_skdh-02_LaoYangTuo过渡时长：0.2\</color\>  
[2025-10-27 18:08:14.276] [LOG] [Thread:1] AutoExit | 停止计时器  
[2025-10-27 18:08:14.276] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPaoBack  
[2025-10-27 18:08:14.277] [LOG] [Thread:1] 现在沉默了  
[2025-10-27 18:08:14.278] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-02 targetAnimationName = YT_dj过渡时长：0.5\</color\>  
[2025-10-27 18:08:14.315] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 方向结果：1  
[2025-10-27 18:08:14.315] [LOG] [Thread:1] HYF.Guide.Send 让小车开始Move  
[2025-10-27 18:08:14.490] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 到达点位：3  
[2025-10-27 18:08:14.491] [LOG] [Thread:1] 动画系统Log：调用PlayHuiFUingAnim方法  
[2025-10-27 18:08:14.491] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-02 targetAnimationName = YT_js-02过渡时长：0.2\</color\>  
[2025-10-27 18:08:14.491] [LOG] [Thread:1] HYF MainCoroutine = 文本  
[2025-10-27 18:08:14.491] [WARN] [Thread:1] The character used for Underline is not available in font asset [DROID SANS FALLBACK SDF].  
[2025-10-27 18:08:14.502] [LOG] [Thread:1] HYF.GuideUIForm.播放音频 = 1.1output.wav id = 0  
[2025-10-27 18:08:14.696] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_ddjh-02动画播放结束 过度到targetAnimationName:YT_js-02此时过渡完毕 过渡时间：0.2081279过渡时长：0.2\</color\>  
[2025-10-27 18:08:15.701] [LOG] [Thread:7] ? MSC回调: msg=1, param1=0, param2=92  
[2025-10-27 18:08:15.701] [LOG] [Thread:7] ? 唤醒成功！检测到唤醒词  
[2025-10-27 18:08:15.725] [LOG] [Thread:1] 识别器捕捉到关键词：你好老白  
[2025-10-27 18:08:15.744] [LOG] [Thread:1] 开始录音了GetAudoiDataNext  
[2025-10-27 18:08:15.744] [LOG] [Thread:1] RecordBtnDown 进入  
[2025-10-27 18:08:15.744] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_js-02 targetAnimationName = YT_lt过渡时长：0.5\</color\>  
[2025-10-27 18:08:15.744] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPao  
[2025-10-27 18:08:15.769] [LOG] [Thread:1] AutoExit | 停止计时器  
[2025-10-27 18:08:15.769] [LOG] [Thread:1] AutoExit | 启动25s计时器  
[2025-10-27 18:08:15.769] [LOG] [Thread:1] HYF SpeekUIForm HideAnim  
[2025-10-27 18:08:15.769] [LOG] [Thread:1] HYF.GuideUIForm.语音导致暂停  
[2025-10-27 18:08:15.770] [LOG] [Thread:1] HYF.GuideUIForm.语音导致暂停  
[2025-10-27 18:08:15.771] [LOG] [Thread:1] HYF.Guide.Send 让小车暂停  
[2025-10-27 18:08:15.846] [LOG] [Thread:1] HYF XunFeiManager Connect -- Start  
[2025-10-27 18:08:16.076] [LOG] [Thread:1] HYF XunFeiManager Connect -- OK  
[2025-10-27 18:08:16.076] [LOG] [Thread:1] 分段发送开始remainLength1280  
[2025-10-27 18:08:16.114] [LOG] [Thread:1] 第一次发送彻底结束  
[2025-10-27 18:08:16.115] [LOG] [Thread:1] HYF 开始语音识别  
[2025-10-27 18:08:16.195] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_js-02动画播放结束 过度到targetAnimationName:YT_lt此时过渡完毕 过渡时间：0.5021222过渡时长：0.5\</color\>  
[2025-10-27 18:08:17.906] [LOG] [Thread:1] ? 唤醒状态检查: 音频长度=64000, MSC处理次数=11436, 音频接收次数=28037  
[2025-10-27 18:08:17.906] [LOG] [Thread:1] ? 音频录制状态: 正常  
[2025-10-27 18:08:18.188] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPao 播放完毕开启回调  
[2025-10-27 18:08:18.817] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_lt targetAnimationName = YT_dj过渡时长：0.2\</color\>  
[2025-10-27 18:08:19.026] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_lt动画播放结束 过度到targetAnimationName:YT_dj此时过渡完毕 过渡时间：0.2096703过渡时长：0.2\</color\>  
[2025-10-27 18:08:21.255] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_dj targetAnimationName = YT_ddjh-03过渡时长：0.2\</color\>  
[2025-10-27 18:08:21.458] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_dj动画播放结束 过度到targetAnimationName:YT_ddjh-03此时过渡完毕 过渡时间：0.2022787过渡时长：0.2\</color\>  
[2025-10-27 18:08:23.110] [LOG] [Thread:1] 现在沉默了  
[2025-10-27 18:08:23.110] [LOG] [Thread:1] HYF.Guide.Send 让小车去点位2  
[2025-10-27 18:08:23.110] [LOG] [Thread:1] HYF.Guide.Send 让小车获取方向  
[2025-10-27 18:08:23.111] [LOG] [Thread:1] HYF 匹配成功介绍模型的卓越性能  
[2025-10-27 18:08:23.111] [LOG] [Thread:1] 动画系统Log：调用PlaySiKaoAnim方法--YT_skdh-02_LaoYangTuo  
[2025-10-27 18:08:23.111] [WARN] [Thread:1] The AnimationClip 'YT_skdh-02_Book' used by the Animation component 'YT_skdh-02_Book' must be marked as Legacy.  
[2025-10-27 18:08:23.111] [LOG] [Thread:1] Default clip could not be found in attached animations list.  
[2025-10-27 18:08:23.111] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-03 targetAnimationName = YT_skdh-02_LaoYangTuo过渡时长：0.2\</color\>  
[2025-10-27 18:08:23.146] [LOG] [Thread:1] AutoExit | 停止计时器  
[2025-10-27 18:08:23.146] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPaoBack  
[2025-10-27 18:08:23.150] [LOG] [Thread:1] 现在沉默了  
[2025-10-27 18:08:23.151] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-03 targetAnimationName = YT_dj过渡时长：0.5\</color\>  
[2025-10-27 18:08:23.190] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 方向结果：1  
[2025-10-27 18:08:23.190] [LOG] [Thread:1] HYF.Guide.Send 让小车开始Move  
[2025-10-27 18:08:23.197] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 方向结果：0  
[2025-10-27 18:08:23.197] [LOG] [Thread:1] HYF.Guide.Send 让小车开始Move  
[2025-10-27 18:08:23.337] [LOG] [Thread:1] HYF.Guide.Receive 收到消息 到达点位：2  
[2025-10-27 18:08:23.337] [LOG] [Thread:1] 动画系统Log：调用PlayHuiFUingAnim方法  
[2025-10-27 18:08:23.337] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_ddjh-03 targetAnimationName = YT_js-01过渡时长：0.2\</color\>  
[2025-10-27 18:08:23.338] [LOG] [Thread:1] HYF MainCoroutine = 文本  
[2025-10-27 18:08:23.338] [WARN] [Thread:1] The character used for Underline is not available in font asset [DROID SANS FALLBACK SDF].  
[2025-10-27 18:08:23.350] [EXCEPTION] [Thread:1] InvalidOperationException: Collection was modified; enumeration operation may not execute.  
Stack Trace: System.Collections.Generic.List`1+Enumerator[T].MoveNextRare () (at \<31687ccd371e4dc6b0c23a1317cf9474\>:0)  
System.Collections.Generic.List`1+Enumerator[T].MoveNext () (at \<31687ccd371e4dc6b0c23a1317cf9474\>:0)  
GuideUIForm.MainCoroutine () (at \<50c37d8e0e314782a11b87db39c8f166\>:0)  
UnityEngine.Debug:LogException(Exception)  
Cysharp.Threading.Tasks.UniTaskScheduler:PublishUnobservedTaskException(Exception)  
\<MainCoroutine\>d__33:MoveNext()  
Cysharp.Threading.Tasks.CompilerServices.AsyncUniTaskVoid`1:Run()  
Cysharp.Threading.Tasks.AwaiterActions:Continuation(Object)  
Cysharp.Threading.Tasks.UniTaskCompletionSourceCore`1:TrySetResult(AsyncUnit)  
Cysharp.Threading.Tasks.CompilerServices.AsyncUniTask`1:SetResult()  
\<WalkAsync\>d__22:MoveNext()  
Cysharp.Threading.Tasks.CompilerServices.AsyncUniTask`1:Run()  
Cysharp.Threading.Tasks.AwaiterActions:Continuation(Object)  
Cysharp.Threading.Tasks.UniTaskCompletionSourceCore`1:TrySetResult(AsyncUnit)  
Cysharp.Threading.Tasks.CompilerServices.AsyncUniTask`1:SetResult()  
\<WaitIfPaused\>d__5:MoveNext()  
Cysharp.Threading.Tasks.CompilerServices.AsyncUniTask`1:Run()  
Cysharp.Threading.Tasks.Internal.ContinuationQueue:RunCore()  
Cysharp.Threading.Tasks.Internal.ContinuationQueue:Run()
 
[2025-10-27 18:08:23.359] [LOG] [Thread:1] HYF.GuideUIForm.播放音频 = 2.1output.wav id = 0  
[2025-10-27 18:08:23.537] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_ddjh-03动画播放结束 过度到targetAnimationName:YT_js-01此时过渡完毕 过渡时间：0.2031896过渡时长：0.2\</color\>  
[2025-10-27 18:08:24.146] [LOG] [Thread:6] ? 音频数据状态 #28100: 长度=64000, 静音=False  
[2025-10-27 18:08:25.269] [LOG] [Thread:1] HYF QiPaoUIForm DoMoveQiPaoBack 播放完毕开启回调 此时开启Yoyo  
[2025-10-27 18:08:27.909] [LOG] [Thread:1] ? 唤醒状态检查: 音频长度=64000, MSC处理次数=11475, 音频接收次数=28137  
[2025-10-27 18:08:27.909] [LOG] [Thread:1] ? 音频录制状态: 正常  
[2025-10-27 18:08:28.516] [LOG] [Thread:1] 动画系统Log：调用PlayHuiFUingAnim方法  
[2025-10-27 18:08:28.516] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_js-01 targetAnimationName = YT_js-02过渡时长：0.2\</color\>  
[2025-10-27 18:08:28.719] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_js-01动画播放结束 过度到targetAnimationName:YT_js-02此时过渡完毕 过渡时间：0.2028854过渡时长：0.2\</color\>  
[2025-10-27 18:08:33.493] [LOG] [Thread:1] \<color=red\>动画系统开始过渡动画 currentAnimationName = YT_js-02 targetAnimationName = YT_js-01过渡时长：0.2\</color\>  
[2025-10-27 18:08:33.698] [LOG] [Thread:1] \<color=green\>动画系统Log(Update)：currentAnimationName:YT_js-02动画播放结束 过度到targetAnimationName:YT_js-01此时过渡完毕 过渡时间：0.2051027过渡时长：0.2\</color\>  
[2025-10-27 18:08:34.146] [LOG] [Thread:6] ? 音频数据状态 #28200: 长度=64000, 静音=False  
[2025-10-27 18:08:37.916] [LOG] [Thread:1] ? 唤醒状态检查: 音频长度=64000, MSC处理次数=11514, 音频接收次