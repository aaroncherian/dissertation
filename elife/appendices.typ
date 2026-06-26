#import "elife.typ": *

#import "tables/gait/trajectory_rmse_x.typ": traj-rmse-x
#import "tables/gait/trajectory_rmse_y.typ": traj-rmse-y
#import "tables/gait/trajectory_rmse_z.typ": traj-rmse-z

#import "tables/gait/ba_gait_by_speed_spatial.typ": ba-gait-by-speed-spatial
#import "tables/gait/ba_gait_by_speed_temporal.typ": ba-gait-by-speed-temporal

#appendix(title: "Supplementary Gait Data")[

  #appendix-table(key: "rmse-x", caption: [Trajectory RMSE per pose estimation backend across speeds — ML (mm). RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Values represent mean ± SD across all participants and trials compared to the marker-based reference.])[
    #traj-rmse-x
  ]
  #appendix-table(key: "rmse-y", caption: [Trajectory RMSE per pose estimation backend across speeds — AP (mm). RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Values represent mean ± SD across all participants and trials compared to the marker-based reference.])[
    #traj-rmse-y
  ]
  #appendix-table(key: "rmse-z", caption: [Trajectory RMSE per pose estimation backend across speeds — Vertical (mm). RMSE was calculated per gait-cycle-normalized stride and averaged across strides within each trial. Values represent mean ± SD across all participants and trials compared to the marker-based reference])[
    #traj-rmse-z
  ]
  #appendix-table(
  key: "ba-spatial",
  caption: [Bland-Altman agreement statistics for spatial gait parameters (stride length, step length) stratified by walking speed. Bias and limits of agreement (LoA) are reported in millimeters. ICC = intraclass correlation coefficient (2,1) with 95% confidence interval.],
  )[
    #ba-gait-by-speed-spatial
  ]

  #appendix-table(
    key: "ba-temporal",
    caption: [Bland-Altman agreement statistics for temporal gait parameters (stance duration, swing duration) stratified by walking speed. Bias and limits of agreement (LoA) are reported in milliseconds. ICC = intraclass correlation coefficient (2,1) with 95% confidence interval.],
  )[
    #ba-gait-by-speed-temporal
  ]
    
]

#import "tables/balance/balance_metrics_table.typ": balance-metrics
#import "tables/balance/path_length_agreement_table.typ": path-length-agreement
#import "tables/balance/path_length_sensitivity_table.typ": path-length-sensitivity

#appendix(title: "Supplementary Balance Data")[
  #appendix-table(
    key: "balance-metrics",
    caption: [Center-of-mass postural sway metrics (path length, 95% prediction ellipse area, and 2D mean velocity in the horizontal plane) across balance conditions for each tracker. Values are reported as group mean $plus.minus$ SD. EO = eyes open, EC = eyes closed.],
  )[
    #balance-metrics
  ]

  #appendix-table(
    key: "pl-agreement",
    caption: [Summary of COM path length agreement metrics across FreeMoCap pose estimation backends compared to Qualisys.],
  )[
    #path-length-agreement
  ]

  #appendix-table(
    key: "pl-sensitivity",
    caption: [Summary of COM path length sensitivity metrics across FreeMoCap pose estimation backends. Each cell reports the regression slope and coefficient of determination (_r_#super[2]) for the condition contrast relative to Qualisys.],
  )[
    #path-length-sensitivity
  ]

  #appendix-figure(
    key: "agreement-all",
    caption: [Trial-level agreement between markerless and marker-based reference center of mass path length (n = 12) per pose estimation backend (Top: Mediapipe; Middle: ViTPose; Bottom: RTMPose). Left: Identity plot with identity line (dashed) and line of best fit (red). Right: Bland-Altman plot of differences between tracker-derived and reference estimates plotted against the mean of the two measurements. Dashed lines represent bias, and dotted lines represent 95% limits of agreement. Colors indicate balance condition.],)[
      #image("figures/balance/agreement_all_trackers.png")
    ]
  )
  #appendix-figure(
    key: "sensitivity-all",
    caption: [Sensitivity of markerless system center of mass path length to condition-dependent perturbations across all pose estimation backends (Top: MediaPipe; Middle: RTMPose; Bottom: ViTPose). Identity plots are shown with identity line (dashed) and line of best fit (red). Each panel shows trial-level path length differences (n = 12) in different conditions, representing system perturbations. Left: Visual perturbation = Eyes Closed (Solid Ground) - Eyes Open (Solid Ground); Middle: Proprioceptive perturbation = Eyes Open (Foam Pad) - Eyes Open (Solid Ground); Right: Visual + Proprioceptive Perturbation = Eyes Closed (Foam Pad) - Eyes Open (Solid Ground).],)[
      #image("figures/balance/sensitivity_all_trackers.png")
    ]
  )
]

#appendix(title: "Pose estimation backend configurations")[
All three pose estimation backends were executed within FreeMoCap through the `SkellyTracker` interface. The specific settings for each pose estimation in the `SkellyTracker` interface are detailed below. 


  *ViTPose.* 
  
  Implemented via the `easy_ViTPose` repository on GitHub - with a wrapper implemented in `SkellyTracker` to handle download of necessary models for ViTPose and YOLOv8 (as the person detector) from HuggingFace.

  ```python
  HF_VIT_REPO  = "JunkyByte/easy_ViTPose"
  HF_YOLO_REPO = "ultralytics/YOLOv8"

  confidence_threshold: float = 0.5
  vit_model:  str      = "huge"    # -> torch/wholebody/vitpose-h-wholebody.pth
  yolo_model: str      = "medium"  # -> yolov8m.pt
  yolo_size:  int      = 640       
  yolo_step:  int      = 1         
  device:     str|None = None       
  ```

  *RTMPose.* 
  
  Implemented via `rtmlib` v0.0.14, using the Wholebody model
  (COCO-WholeBody 133).

  ```python
  # rtmlib v0.0.14 — Wholebody (COCO-WholeBody 133)
  class RTMPoseDetectorConfig(BaseDetectorConfig):
      mode: str    = "performance"
      backend: str = "onnxruntime"
      device: str  = "cuda"
  ```

  *MediaPipe.* 
  
  Using MediaPipe Holistic from v0.10.14. This is the legacy Holistic
  solution, deprecated by Google in favor of the Tasks API; we remained on the
  legacy version because Holistic's integrated single-pass body + face + hand
  topology is the basis of the FreeMoCap processing pipeline and is what these data
  were processed with.

  ```python
  # MediaPipe Holistic v0.10.14 (legacy solution)
  MEDIAPIPE_TRACKER_POSTHOC_PRESET = MediapipeDetectorConfig(
      model_complexity=MediapipeModelComplexity.HEAVY,  # = 2
      min_detection_confidence=0.5,
      min_tracking_confidence=0.5,
      static_image_mode=False,
      smooth_landmarks=True,        
      enable_segmentation=True,     
      smooth_segmentation=True,
      refine_face_landmarks=True,  
  )
  ```
    One main setting warrants emphasis. The MediaPipe configuration is the only one applying temporal smoothing: with `smooth_landmarks = True`, MediaPipe Holistic applies a One Euro filter to the output landmarks, whereas RTMPose and ViTPose were run per-frame with no temporal filtering. The One Euro parameters are internal to the MediaPipe graph; setting either `static_image_mode = True`or `smooth_landmarks = False` disables the filter. These configurations are summarized in the table below.


  #appendix-table(
    key: "tracker-config",
    caption: [Pose-estimation backend configurations. Detectors, keypoint formats, temporal processing; these differences bear on the agreement and signal-quality results reported in the main text.],
  )[
    #table(
      columns: (1.15fr, 1fr, 1fr, 1fr),
      align: (left, left, left, left),
      stroke: none,
      table.hline(),
      table.header(
        [], [*MediaPipe*], [*RTMPose*], [*ViTPose*],
      ),
      table.hline(stroke: 0.5pt),

      [Library / version],
        [MediaPipe Holistic v0.10.14 (legacy)],
        [rtmlib v0.0.14],
        [easy_ViTPose (HuggingFace)],

      [Person detector],
        [Internal (MediaPipe)],
        [RTMDet (bundled in rtmlib)],
        [YOLOv8m (`yolov8m.pt`)],

      [Pose model / checkpoint],
        [Holistic, complexity HEAVY (= 2)],
        [Wholebody, `mode = "performance"`],
        [ViTPose-H, `vitpose-h-wholebody.pth`],

      [Native keypoint set],
        [33 pose + 468 face + 21$times$2 hand],
        [COCO-WholeBody (133)],
        [COCO-WholeBody (133)],

      [Temporal processing],
        [One Euro filter (via `smooth_landmarks`)],
        [none (per-frame)],
        [none (per-frame)],

      [Compute backend],
        [TensorFlow Lite (internal)],
        [ONNX Runtime],
        [PyTorch],
      table.hline(),
    )
  ]
]

