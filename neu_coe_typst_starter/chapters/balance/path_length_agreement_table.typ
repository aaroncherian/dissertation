#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1.2fr, 1.8fr, 0.8fr, 1.2fr, 1fr),
      align: (left, center, center, center, center),
      stroke: none,
      table.hline(stroke: 1pt),
      table.header(
        [*System*],
        [*ICC(2,1) (95% CI)*],
        [*Bias (mm/s)*],
        [*LoA (mm/s)*],
        [*Slope*],
      ),
      table.hline(stroke: 0.5pt),
      [FMC-MediaPipe],
      [0.986 (0.970-0.990)],
      [0.02],
      [(-1.24, 1.28)],
      [0.90],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [0.067 (-0.050-0.260)],
      [14.37],
      [(3.47, 25.27)],
      [0.55],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [0.053 (-0.040-0.210)],
      [20.49],
      [(4.69, 36.29)],
      [0.89],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length agreement metrics across FreeMoCap pose estimation backends compared to Qualisys.],
) <tbl-path-length-agreement>