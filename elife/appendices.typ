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


#appendix(title: "Mathematics of reconstruction")[
  Derivation of the triangulation and reprojection geometry. The camera
  geometry is shown in #appendixfigref("triangulation").

  #appendix-figure(key: "triangulation", caption: [Multi-camera triangulation geometry.])[
    #placeholder(h: 6cm, label: "Appendix 1—figure 1")
  ]

  #appendix-figure(caption: [Reprojection error vs. calibration quality.])[
    #placeholder(h: 6cm, label: "Appendix 1—figure 2")
  ]
]

#appendix(title: "Practical considerations")[
  Notes on capture setup and failure modes.

  #appendix-figure(caption: [Recommended camera placement.])[
    #placeholder(h: 6cm, label: "Appendix 2—figure 1")
  ]
]
