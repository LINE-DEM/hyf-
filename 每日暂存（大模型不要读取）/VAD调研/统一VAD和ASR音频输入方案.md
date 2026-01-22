
 ▐▛███▜▌   Claude Code v2.1.12
▝▜█████▛▘  Opus 4.5 · Claude API
  ▘▘ ▝▝    C:\1UnityProjects\YiTiJi_Move

❯ Implement the following plan:                                             
                                                                            
  # 统一VAD和ASR音频输入方案                                                
                                                                            
  ## 问题描述                                                               
                                                                            
  当前系统存在两个独立的音频输入源：                                        
  - **VAD (SileroVADManager)**: 使用 NAudio WaveInEvent，持续运行           
  - **ASR (Record.cs)**: 使用 Unity Microphone API，仅在VAD检测到人声后启动 
                                                                            
  **结果**: 当VAD在时间T检测到人声时，ASR麦克风在T+delay才启动。时间T-150ms 
  到T之间的音频（触发VAD的那部分）丢失了。                                  
                                                                            
  ## 解决方案：统一音频缓冲区 + 预缓冲                                      
                                                                            
  使用NAudio作为唯一音频源（因为它已经在持续运行），添加预缓冲机制捕获VAD触 
  发前的音频。                                                              
                                                                            
  ---                                                                       
                                                                            
  ## 实现步骤                                                               
                                                                            
  ### 步骤1: 创建统一音频缓冲区类                                           
                                                                            
  **新建文件**: `Assets/c#/System/VAD/UnifiedAudioBuffer.cs`                
                                                                            
  ```csharp                                                                 
  using System;                                                             
  using System.Collections.Concurrent;                                      
  using UnityEngine;                                                        
                                                                            
  public class UnifiedAudioBuffer : MonoSingleton<UnifiedAudioBuffer>       
  {                                                                         
  [Header("预缓冲配置")]                                                    
  [SerializeField] private int preBufferDurationMs = 500;  //               
  VAD触发前捕获500ms音频                                                    
  [SerializeField] private int sampleRate = 16000;                          
                                                                            
  // 环形缓冲区                                                             
  private byte[] ringBuffer;                                                
  private int writePosition = 0;                                            
  private int ringBufferSize;                                               
  private readonly object bufferLock = new object();                        
                                                                            
  // ASR帧队列 (640样本/帧)                                                 
  private ConcurrentQueue<byte[]> asrFrameQueue = new                       
  ConcurrentQueue<byte[]>();                                                
  private bool isStreamingToASR = false;                                    
                                                                            
  private const int BYTES_PER_SAMPLE = 2;                                   
  private const int ASR_FRAME_SAMPLES = 640;                                
                                                                            
  // 帧累积器                                                               
  private byte[] frameAccumulator;                                          
  private int accumulatorPosition = 0;                                      
                                                                            
  protected override void Awake()                                           
  {                                                                         
  base.Awake();                                                             
  // 环形缓冲区: 2秒音频                                                    
  ringBufferSize = sampleRate * 2 * BYTES_PER_SAMPLE;                       
  ringBuffer = new byte[ringBufferSize];                                    
  frameAccumulator = new byte[ASR_FRAME_SAMPLES *                           
  BYTES_PER_SAMPLE];                                                        
  }                                                                         
                                                                            
  /// <summary>                                                             
  /// NAudio回调写入音频数据（线程安全）                                    
  /// </summary>                                                            
  public void WriteAudio(byte[] pcmData, int offset, int count)             
  {                                                                         
  lock (bufferLock)                                                         
  {                                                                         
  // 写入环形缓冲区                                                         
  for (int i = 0; i < count; i++)                                           
  {                                                                         
  ringBuffer[writePosition] = pcmData[offset + i];                          
  writePosition = (writePosition + 1) % ringBufferSize;                     
  }                                                                         
                                                                            
  // 如果正在向ASR流式传输，则入队帧                                        
  if (isStreamingToASR)                                                     
  {                                                                         
  QueueASRFrames(pcmData, offset, count);                                   
  }                                                                         
  }                                                                         
  }                                                                         
                                                                            
  /// <summary>                                                             
  /// VAD触发时捕获预缓冲音频                                               
  /// </summary>                                                            
  public byte[] CapturePreBuffer()                                          
  {                                                                         
  lock (bufferLock)                                                         
  {                                                                         
  int preBufferSamples = (preBufferDurationMs * sampleRate) /               
  1000;                                                                     
  int preBufferBytes = preBufferSamples * BYTES_PER_SAMPLE;                 
  byte[] result = new byte[preBufferBytes];                                 
                                                                            
  int startPos = (writePosition - preBufferBytes +                          
  ringBufferSize) % ringBufferSize;                                         
  for (int i = 0; i < preBufferBytes; i++)                                  
  {                                                                         
  result[i] = ringBuffer[(startPos + i) % ringBufferSize];                  
  }                                                                         
                                                                            
  Debug.Log($"[UnifiedAudioBuffer] 预缓冲捕获: {preBufferBytes}             
  字节 ({preBufferDurationMs}ms)");                                         
  return result;                                                            
  }                                                                         
  }                                                                         
                                                                            
  public void StartASRStreaming()                                           
  {                                                                         
  lock (bufferLock)                                                         
  {                                                                         
  isStreamingToASR = true;                                                  
  accumulatorPosition = 0;                                                  
  while (asrFrameQueue.TryDequeue(out _)) { }                               
  }                                                                         
  }                                                                         
                                                                            
  public void StopASRStreaming()                                            
  {                                                                         
  lock (bufferLock)                                                         
  {                                                                         
  isStreamingToASR = false;                                                 
  }                                                                         
  }                                                                         
                                                                            
  public byte[] GetNextASRFrame()                                           
  {                                                                         
  return asrFrameQueue.TryDequeue(out byte[] frame) ? frame : null;         
  }                                                                         
                                                                            
  public bool HasASRFrames() => !asrFrameQueue.IsEmpty;                     
                                                                            
  private void QueueASRFrames(byte[] pcmData, int offset, int count)        
  {                                                                         
  for (int i = 0; i < count; i++)                                           
  {                                                                         
  frameAccumulator[accumulatorPosition++] = pcmData[offset +                
  i];                                                                       
                                                                            
  if (accumulatorPosition >= frameAccumulator.Length)                       
  {                                                                         
  byte[] frame = new byte[frameAccumulator.Length];                         
  Array.Copy(frameAccumulator, frame,                                       
  frameAccumulator.Length);                                                 
  asrFrameQueue.Enqueue(frame);                                             
  accumulatorPosition = 0;                                                  
  }                                                                         
  }                                                                         
  }                                                                         
                                                                            
  public void Reset()                                                       
  {                                                                         
  lock (bufferLock)                                                         
  {                                                                         
  isStreamingToASR = false;                                                 
  accumulatorPosition = 0;                                                  
  while (asrFrameQueue.TryDequeue(out _)) { }                               
  }                                                                         
  }                                                                         
  }                                                                         
  ```                                                                       
                                                                            
  ---                                                                       
                                                                            
  ### 步骤2: 修改 SileroVADManager.cs                                       
                                                                            
  **文件**: `Assets/c#/System/VAD/SileroVADManager.cs`                      
                                                                            
  在 `OnNAudioDataAvailable` 方法中添加一行：                               
                                                                            
  ```csharp                                                                 
  private void OnNAudioDataAvailable(object sender, WaveInEventArgs e)      
  {                                                                         
  try                                                                       
  {                                                                         
  if (e == null || e.Buffer == null || e.BytesRecorded <= 0)                
  return;                                                                   
                                                                            
  // ===== 新增: 写入统一音频缓冲区 =====                                   
  if (UnifiedAudioBuffer.Instance != null)                                  
  {                                                                         
  UnifiedAudioBuffer.Instance.WriteAudio(e.Buffer, 0,                       
  e.BytesRecorded);                                                         
  }                                                                         
  // ===================================                                    
                                                                            
  // ... 现有代码保持不变 ...                                               
  }                                                                         
  // ...                                                                    
  }                                                                         
  ```                                                                       
                                                                            
  ---                                                                       
                                                                            
  ### 步骤3: 修改 Record.cs                                                 
                                                                            
  **文件**: `Assets/AIChatTookit/Speech/Record.cs`                          
                                                                            
  添加两个新方法用于带预缓冲的VAD录音：                                     
                                                                            
  ```csharp                                                                 
  private Coroutine _unifiedBufferCoroutine;                                
                                                                            
  /// <summary>                                                             
  /// 使用统一音频缓冲区启动VAD录音（包含预缓冲）                           
  /// </summary>                                                            
  public void StartByVADWithPreBuffer()                                     
  {                                                                         
  if (_isRecording)                                                         
  {                                                                         
  Debug.LogWarning("[Record] 已在录音中");                                  
  return;                                                                   
  }                                                                         
                                                                            
  Debug.Log("[Record] 启动VAD录音（带预缓冲）");                            
                                                                            
  _isVADControlled = true;                                                  
  _isRecording = true;                                                      
                                                                            
  var audioBuffer = UnifiedAudioBuffer.Instance;                            
  if (audioBuffer == null)                                                  
  {                                                                         
  Debug.LogError("[Record] UnifiedAudioBuffer 未找到!");                    
  return;                                                                   
  }                                                                         
                                                                            
  audioBuffer.StartASRStreaming();                                          
                                                                            
  if (_unifiedBufferCoroutine != null)                                      
  StopCoroutine(_unifiedBufferCoroutine);                                   
                                                                            
  _unifiedBufferCoroutine =                                                 
  StartCoroutine(UnifiedBufferRecordingCoroutine());                        
  }                                                                         
                                                                            
  private IEnumerator UnifiedBufferRecordingCoroutine()                     
  {                                                                         
  var audioBuffer = UnifiedAudioBuffer.Instance;                            
  bool firstPacketSent = false;                                             
                                                                            
  while (_isRecording && _isVADControlled)                                  
  {                                                                         
  yield return null;                                                        
                                                                            
  if (_sessionManager == null)                                              
  {                                                                         
  Debug.LogError("[Record] SessionManager 为空");                           
  break;                                                                    
  }                                                                         
                                                                            
  // 发送预缓冲作为首包                                                     
  if (!firstPacketSent)                                                     
  {                                                                         
  byte[] preBuffer = audioBuffer.CapturePreBuffer();                        
  if (preBuffer != null && preBuffer.Length > 0)                            
  {                                                                         
  int chunkSize = 640 * 2;  // 640样本 * 2字节                              
  for (int offset = 0; offset < preBuffer.Length; offset +=                 
  chunkSize)                                                                
  {                                                                         
  int remaining = Math.Min(chunkSize, preBuffer.Length                      
  - offset);                                                                
  byte[] chunk = new byte[remaining];                                       
  Array.Copy(preBuffer, offset, chunk, 0, remaining);                       
  _ = _sessionManager.SendAudioFrame(chunk);                                
  }                                                                         
  Debug.Log($"[Record] 预缓冲已发送: {preBuffer.Length}                     
  字节");                                                                   
  }                                                                         
  firstPacketSent = true;                                                   
  }                                                                         
                                                                            
  // 发送队列中的ASR帧                                                      
  while (audioBuffer.HasASRFrames())                                        
  {                                                                         
  byte[] frame = audioBuffer.GetNextASRFrame();                             
  if (frame != null)                                                        
  {                                                                         
  _ = _sessionManager.SendAudioFrame(frame);                                
  }                                                                         
  }                                                                         
  }                                                                         
  }                                                                         
                                                                            
  /// <summary>                                                             
  /// 停止VAD录音（带预缓冲版本）                                           
  /// </summary>                                                            
  public void StopByVADWithPreBuffer()                                      
  {                                                                         
  if (!_isRecording || !_isVADControlled)                                   
  return;                                                                   
                                                                            
  Debug.Log("[Record] 停止VAD录音");                                        
                                                                            
  if (_unifiedBufferCoroutine != null)                                      
  {                                                                         
  StopCoroutine(_unifiedBufferCoroutine);                                   
  _unifiedBufferCoroutine = null;                                           
  }                                                                         
                                                                            
  var audioBuffer = UnifiedAudioBuffer.Instance;                            
  if (audioBuffer != null)                                                  
  {                                                                         
  audioBuffer.StopASRStreaming();                                           
  }                                                                         
                                                                            
  _isRecording = false;                                                     
  _isVADControlled = false;                                                 
  state = 0;                                                                
  }                                                                         
  ```                                                                       
                                                                            
  ---                                                                       
                                                                            
  ### 步骤4: 修改 VADASRController.cs                                       
                                                                            
  **文件**: `Assets/c#/System/VAD/VADASRController.cs`                      
                                                                            
  1. 在 `StartRecordingSession()` 方法中，将 `_record.StartByVAD()` 改为：  
  ```csharp                                                                 
  _record.StartByVADWithPreBuffer();                                        
  ```                                                                       
                                                                            
  2. 在 `LongDialogTailSilenceCoroutine()` 方法中，将                       
  `_record.StopRecordingByVAD()` 改为：                                     
  ```csharp                                                                 
  _record.StopByVADWithPreBuffer();                                         
  ```                                                                       
                                                                            
  3. 其他调用 `StopByVAD()` 的地方也需要相应修改。                          
                                                                            
  ---                                                                       
                                                                            
  ### 步骤5: 场景配置                                                       
                                                                            
  4. 在 Unity 编辑器中，向场景添加带有 `UnifiedAudioBuffer` 组件的          
  GameObject                                                                
  5. 配置 `preBufferDurationMs` 参数（推荐值：300-500ms）                   
                                                                            
  ---                                                                       
                                                                            
  ## 关键文件列表                                                           
                                                                            
  | 文件 | 操作 |                                                           
  |------|------|                                                           
  | `Assets/c#/System/VAD/UnifiedAudioBuffer.cs` | 新建 |                   
  | `Assets/c#/System/VAD/SileroVADManager.cs` | 修改                       
  `OnNAudioDataAvailable` |                                                 
  | `Assets/AIChatTookit/Speech/Record.cs` | 添加                           
  `StartByVADWithPreBuffer`, `StopByVADWithPreBuffer` |                     
  | `Assets/c#/System/VAD/VADASRController.cs` | 修改调用方法 |             
                                                                            
  ---                                                                       
                                                                            
  ## 验证测试                                                               
                                                                            
  6. **预缓冲测试**: 说"你好"，验证ASR识别结果包含完整的"你好"而非"好"      
  7. **连续音频测试**: 验证从预缓冲到实时音频的无缝衔接                     
  8. **多轮对话测试**: 验证长对话模式下每轮都正确捕获预缓冲                 
  9. **边界测试**: 测试极短语音（<300ms）和极长语音的处理                   
                                                                            
  ---                                                                       
                                                                            
  ## 数据流图                                                               
                                                                            
  ```                                                                       
  NAudio WaveInEvent                                                        
  │                                                                         
  ▼                                                                         
  OnNAudioDataAvailable()                                                   
  │                                                                         
  ├──▶ UnifiedAudioBuffer.WriteAudio()  ──▶ 环形缓冲区 (2秒)                
  │                                           │                             
  │                                           ├──▶ CapturePreBuffer()       
  [VAD触发时]                                                               
  │                                           │                             
  │                                           └──▶ ASR帧队列                
  [流式传输时]                                                              
  │                                                                         
  └──▶ VAD处理队列 ──▶ ONNX推理 ──▶ OnVoiceActivityChanged                  
  │                                                                         
  ▼                                                                         
  VADASRController                                                          
  │                                                                         
  ▼                                                                         
  Record.StartByVADWithPreBuffer()                                          
  │                                                                         
  ┌───────────────────────┴───────────────────────┐                         
  │                                               │                         
  ▼                                               ▼                         
  预缓冲 (500ms)                                    实时ASR帧               
  │                                               │                         
  └───────────────► XunFei ASR Server ◄───────────┘                         
  ```                                                                       
                                                                            
                                                                            
  If you need specific details from before exiting plan mode (like exact    
  code snippets, error messages, or content you generated), read the full   
  transcript at: C:\Users\Admin\.claude\projects\C--1UnityProjects-YiTiJi-M 
  ove\5504da6e-a565-4c37-bd93-4d71afc8ef3f.jsonl                            

● I'll implement this unified VAD and ASR audio input solution. Let me start by reading the existing files to understand their current structure.

● Read(Assets\c#\System\VAD\SileroVADManager.cs)
  ⎿  Read 801 lines

● Read(Assets\AIChatTookit\Speech\Record.cs)
  ⎿  Read 745 lines

● Read(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Read 1385 lines

● Read(Assets\c#\FrameWork\MonoSingleton.cs)
  ⎿  Read 51 lines

● Now I have a complete understanding of the codebase. Let me implement the plan step by step.

● Write(Assets\c#\System\VAD\UnifiedAudioBuffer.cs)
  ⎿  Wrote 1 lines to Assets\c#\System\VAD\UnifiedAudioBuffer.cs        
     using System;
     using System.Collections.Concurrent;
     using UnityEngine;
     using unity_chan_;
     /// <summary>
     /// 统一音频缓冲区 - 管理NAudio音频数据的环形缓冲和预缓冲
     /// 解决VAD触发时ASR麦克风延迟启动导致的音频丢失问题
     /// </summary>
     public class UnifiedAudioBuffer : MonoSingleton<UnifiedAudioBuffer>

❯ /export 

● Update(Assets\c#\System\VAD\SileroVADManager.cs)
  ⎿  Added 7 lines                                                         
      288              if (e == null || e.Buffer == null ||              
           e.BytesRecorded <= 0)                                         
      289                  return;                                       
      290                                                                
      291 +            // ===== 写入统一音频缓冲区（用于ASR预缓冲）=====    
                  

      292 +            if (UnifiedAudioBuffer.Instance != null)          
      293 +            {                                                 
      294 +                                                              
          +UnifiedAudioBuffer.Instance.WriteAudio(e.Buffer, 0,           
          +e.BytesRecorded);                                             
      295 +            }                                                 
      296 +            //                                                
          +================================================              
      297 +                                                              
      298              // 线程安全地管理音频缓冲区                          
              

      299              lock (bufferLock)                                 
      300              {                                                 

● Update(Assets\c#\System\VAD\SileroVADManager.cs)
  ⎿  Added 1 line                                                          
       7  using System.Threading;                                        
       8  using System.Collections.Concurrent;                           
       9  using NAudio.Wave;                                             
      10 +using unity_chan_;                                             
      11                                                                 
      12  /// <summary>                                                  
      13  /// Silero VAD管理器 - 负责语音活动检测的核心类                   
                 


● Now let me add the new methods to Record.cs. I'll add them after the StopByVAD() method.

● Update(Assets\AIChatTookit\Speech\Record.cs)
  ⎿  Added 145 lines                                                       
      221          Debug.Log("[Record] Recording stopped by VAD");       
      222      }                                                         
      223                                                                
      224 +    #region 统一音频缓冲区方法（带预缓冲）                       
                 

      225 +                                                              
      226 +    private Coroutine _unifiedBufferCoroutine;                
      227 +                                                              
      228 +    /// <summary>                                             
      229 +    /// 使用统一音频缓冲区启动VAD录音（包含预缓冲）              
                      

      230 +    /// 解决VAD触发时音频丢失问题                                
             

      231 +    /// </summary>                                            
      232 +    public void StartByVADWithPreBuffer()                     
      233 +    {                                                         
      234 +        if (_isRecording)                                     
      235 +        {                                                     
      236 +            Debug.LogWarning("[Record] 已在录音中");             
       

      237 +            return;                                           
      238 +        }                                                     
      239 +                                                              
      240 +        Debug.Log("[Record] 启动VAD录音（带预缓冲）");           
            

      241 +                                                              
      242 +        _isVADControlled = true;                              
      243 +        _isRecording = true;                                  
      244 +                                                              
      245 +        var audioBuffer = UnifiedAudioBuffer.Instance;        
      246 +        if (audioBuffer == null)                              
      247 +        {                                                     
      248 +            Debug.LogError("[Record] UnifiedAudioBuffer       
          +未找到!");                                                       

      249 +            _isRecording = false;                             
      250 +            _isVADControlled = false;                         
      251 +            return;                                           
      252 +        }                                                     
      253 +                                                              
      254 +        // 启动ASR流式传输                                       
        

      255 +        audioBuffer.StartASRStreaming();                      
      256 +                                                              
      257 +        // 停止之前的协程                                        
         

      258 +        if (_unifiedBufferCoroutine != null)                  
      259 +        {                                                     
      260 +            StopCoroutine(_unifiedBufferCoroutine);           
      261 +        }                                                     
      262 +                                                              
      263 +        // 启动统一缓冲区录音协程                                
             

      264 +        _unifiedBufferCoroutine =                             
          +StartCoroutine(UnifiedBufferRecordingCoroutine());            
      265 +    }                                                         
      266 +                                                              
      267 +    /// <summary>                                             
      268 +    /// 统一缓冲区录音协程                                       
           

      269 +    /// 先发送预缓冲音频，然后持续发送实时音频帧                 
                      

      270 +    /// </summary>                                            
      271 +    private IEnumerator UnifiedBufferRecordingCoroutine()     
      272 +    {                                                         
      273 +        var audioBuffer = UnifiedAudioBuffer.Instance;        
      274 +        bool firstPacketSent = false;                         
      275 +                                                              
      276 +        Debug.Log("[Record] UnifiedBufferRecordingCoroutine   
          +开始");                                                         
      277 +                                                              
      278 +        while (_isRecording && _isVADControlled)              
      279 +        {                                                     
      280 +            yield return null;                                
      281 +                                                              
      282 +            // 检查SessionManager是否可用                        
        

      283 +            if (_sessionManager == null)                      
      284 +            {                                                 
      285 +                Debug.LogError("[Record] SessionManager       
          +为空");                                                         
      286 +                break;                                        
      287 +            }                                                 
      288 +                                                              
      289 +            // 发送预缓冲作为首包                                
           

      290 +            if (!firstPacketSent)                             
      291 +            {                                                 
      292 +                byte[] preBuffer =                            
          +audioBuffer.CapturePreBuffer();                               
      293 +                if (preBuffer != null && preBuffer.Length >   
          +0)                                                            
      294 +                {                                             
      295 +                    int chunkSize = 640 * 2;  // 640样本 *      
          +2字节 = 1280字节                                                 
      

      296 +                    int chunksSent = 0;                       
      297 +                                                              
      298 +                    for (int offset = 0; offset <             
          +preBuffer.Length; offset += chunkSize)                        
      299 +                    {                                         
      300 +                        int remaining = Math.Min(chunkSize,   
          +preBuffer.Length - offset);                                   
      301 +                        byte[] chunk = new byte[remaining];   
      302 +                        Array.Copy(preBuffer, offset, chunk,  
          +0, remaining);                                                
      303 +                        _ =                                   
          +_sessionManager.SendAudioFrame(chunk);                        
      304 +                        chunksSent++;                         
      305 +                    }                                         
      306 +                                                              
      307 +                    Debug.Log($"[Record] 预缓冲已发送:           
        

          +{preBuffer.Length} 字节 ({chunksSent} 帧)");                     

      308 +                }                                             
      309 +                firstPacketSent = true;                       
      310 +            }                                                 
      311 +                                                              
      312 +            // 发送队列中的ASR帧                                 
         

      313 +            int framesSent = 0;                               
      314 +            while (audioBuffer.HasASRFrames())                
      315 +            {                                                 
      316 +                byte[] frame = audioBuffer.GetNextASRFrame(); 
      317 +                if (frame != null)                            
      318 +                {                                             
      319 +                    _ =                                       
          +_sessionManager.SendAudioFrame(frame);                        
      320 +                    framesSent++;                             
      321 +                }                                             
      322 +            }                                                 
      323 +                                                              
      324 +            // 每发送100帧打印一次统计（可选，调试用）           
                    

      325 +            // if (framesSent > 0 && framesSent % 100 == 0)   
      326 +            // {                                              
      327 +            //     Debug.Log($"[Record] 已发送 {framesSent}      

          +帧");                                                          
      328 +            // }                                              
      329 +        }                                                     
      330 +                                                              
      331 +        Debug.Log("[Record] UnifiedBufferRecordingCoroutine   
          +结束");                                                         
      332 +    }                                                         
      333 +                                                              
      334 +    /// <summary>                                             
      335 +    /// 停止VAD录音（带预缓冲版本）                              
              

      336 +    /// </summary>                                            
      337 +    public void StopByVADWithPreBuffer()                      
      338 +    {                                                         
      339 +        if (!_isRecording || !_isVADControlled)               
      340 +        {                                                     
      341 +            return;                                           
      342 +        }                                                     
      343 +                                                              
      344 +        Debug.Log("[Record] 停止VAD录音（带预缓冲）");           
            

      345 +                                                              
      346 +        // 停止协程                                              
      

      347 +        if (_unifiedBufferCoroutine != null)                  
      348 +        {                                                     
      349 +            StopCoroutine(_unifiedBufferCoroutine);           
      350 +            _unifiedBufferCoroutine = null;                   
      351 +        }                                                     
      352 +                                                              
      353 +        // 停止ASR流式传输                                       
        

      354 +        var audioBuffer = UnifiedAudioBuffer.Instance;        
      355 +        if (audioBuffer != null)                              
      356 +        {                                                     
      357 +            audioBuffer.StopASRStreaming();                   
      358 +        }                                                     
      359 +                                                              
      360 +        _isRecording = false;                                 
      361 +        _isVADControlled = false;                             
      362 +        state = 0;                                            
      363 +                                                              
      364 +        Debug.Log("[Record] VAD录音已停止");                     
       

      365 +    }                                                         
      366 +                                                              
      367 +    #endregion                                                
      368 +                                                              
      369      IEnumerator PlayAnimation() {                             
      370          // 添加空值检查，防止运行时错误                          
                

      371          if (sprites == null || sprites.Length == 0 ||         
           imageAnim == null)                                            

● Now let me modify VADASRController.cs to use the new pre-buffer methods.

● Update(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Added 3 lines, removed 3 lines                                        
      688                  Debug.Log("[VADASRController] WebSocket       
           connected successfully");                                     
      689          }                                                     
      690                                                                
      691 -        // 2. 启动Record录音                                     
      

      691 +        // 2. 启动Record录音（使用统一音频缓冲区，包含预缓冲）   
                       

      692          if (_record != null)                                  
      693          {                                                     
      694 -            _record.StartByVAD();                             
      694 +            _record.StartByVADWithPreBuffer();                
      695                                                                
      696              if (showDebugLogs)                                
      697 -                Debug.Log("[VADASRController] Recording       
          -started by VAD");                                             
      697 +                Debug.Log("[VADASRController] Recording       
          +started by VAD with pre-buffer");                             
      698          }                                                     
      699                                                                
      700          // 发布会话开始消息                                      
          


● Update(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Added 2 lines, removed 2 lines                                        
      425                  if (showDebugLogs)                            
      426                      Debug.Log("[VADASRController] Tail        
           silence timeout - ending ASR session");                       
      427                                                                
      428 -                // 1. 停止Record录音                             
      

      428 +                // 1. 停止Record录音（使用统一音频缓冲区版本）   
                   

      429                  if (_record != null)                          
      430                  {                                             
      431 -                    _record.StopByVAD();                      
      431 +                    _record.StopByVADWithPreBuffer();         
      432                  }                                             
      433                                                                
      434                  // 2. 发送尾包通过SessionManager                 
        


● Update(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Added 2 lines, removed 2 lines                                        
      1300              if (showDebugLogs)                               
      1301                  Debug.Log("[VADASRController] Long Dialog -  
            静音确认，停止录音并发送尾包");                                 
                

      1302                                                               
      1303 -            // 停止Record录音                                   
      

      1303 +            // 停止Record录音（使用统一音频缓冲区版本）         
                   

      1304              if (_record != null)                             
      1305              {                                                
      1306 -                _record.StopRecordingByVAD();                
      1306 +                _record.StopByVADWithPreBuffer();            
      1307              }                                                
      1308                                                               
      1309              // 转换到处理状态                                   
         


● Update(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Added 2 lines, removed 2 lines                                        
      1164              _longDialogTailSilenceCoroutine = null;          
      1165          }                                                    
      1166                                                               
      1167 -        // 如果正在录音，停止录音                               
             

      1167 +        // 如果正在录音，停止录音（使用统一音频缓冲区版本）     
                          

      1168          if (_longDialogState == LongDialogState.Recording && 
             _record != null)                                            
      1169          {                                                    
      1170 -            _record.StopRecordingByVAD();                    
      1170 +            _record.StopByVADWithPreBuffer();                
      1171          }                                                    
      1172                                                               
      1173          _longDialogState = LongDialogState.Idle;             

● Now I need to update the StartRecordingSession() method in the long dialog mode section as well.

● Update(Assets\c#\System\VAD\VADASRController.cs)
  ⎿  Added 3 lines, removed 3 lines                                        
      1266      }                                                        
      1267                                                               
      1268      /// <summary>                                            
      1269 -    /// 开始录音会话                                            
        

      1269 +    /// 开始录音会话（使用统一音频缓冲区，包含预缓冲）          
                         

      1270      /// </summary>                                           
      1271      private void StartRecordingSession()                     
      1272      {                                                        
      1273          if (showDebugLogs)                                   
      1274 -            Debug.Log("[VADASRController] Long Dialog -      
           -开始录音会话");                                                 
        

      1274 +            Debug.Log("[VADASRController] Long Dialog -      
           +开始录音会话（带预缓冲）");                                     
              

      1275                                                               
      1276          if (_record != null)                                 
      1277          {                                                    
      1278 -            _record.StartRecordingByVAD();                   
      1278 +            _record.StartByVADWithPreBuffer();               
      1279          }                                                    
      1280          else                                                 
      1281          {                                                    

● All tasks are completed. Here's a summary of the implementation:

  Implementation Summary

  1. Created UnifiedAudioBuffer.cs

  File: Assets/c#/System/VAD/UnifiedAudioBuffer.cs

  A new singleton class that provides:
  - Ring buffer (2 seconds): Continuously stores audio from NAudio
  - Pre-buffer capture: Captures audio from before VAD trigger (configurable, default 500ms)
  - ASR frame queue: Packages audio into 640-sample frames for XunFei ASR
  - Thread-safe operations with proper locking

  2. Modified SileroVADManager.cs

  File: Assets/c#/System/VAD/SileroVADManager.cs:284-293

  Added call to UnifiedAudioBuffer.WriteAudio() in OnNAudioDataAvailable() to continuously feed audio to the unified buffer.

  3. Modified Record.cs

  File: Assets/AIChatTookit/Speech/Record.cs:224-349

  Added new methods:
  - StartByVADWithPreBuffer(): Starts recording using unified buffer with pre-buffer
  - UnifiedBufferRecordingCoroutine(): Sends pre-buffer first, then streams real-time frames
  - StopByVADWithPreBuffer(): Stops the unified buffer recording

  4. Modified VADASRController.cs

  File: Assets/c#/System/VAD/VADASRController.cs

  Updated all recording calls to use the new pre-buffer methods:
  - StartASRSession(): Uses StartByVADWithPreBuffer()
  - TailSilenceTimerCoroutine(): Uses StopByVADWithPreBuffer()
  - StartRecordingSession(): Uses StartByVADWithPreBuffer()
  - LongDialogTailSilenceCoroutine(): Uses StopByVADWithPreBuffer()
  - StopLongDialogMode(): Uses StopByVADWithPreBuffer()

  Scene Configuration Required

  Add a GameObject with UnifiedAudioBuffer component to your scene. The component has these configurable parameters:
  - preBufferDurationMs: Duration of audio to capture before VAD trigger (default: 500ms, recommended: 300-500ms)
  - sampleRate: Audio sample rate (default: 16000Hz)
  - showDebugLogs: Enable/disable debug logging

✻ Sautéed for 4m 13s



