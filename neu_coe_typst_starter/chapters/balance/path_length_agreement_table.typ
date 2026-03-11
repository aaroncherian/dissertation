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
      [0.984 (0.970-0.990)],
      [4.09],
      [(-62.49, 70.67)],
      [0.89],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [0.080 (-0.050-0.280)],
      [715.29],
      [(132.28, 1298.31)],
      [0.65],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [0.046 (-0.040-0.190)],
      [1110.14],
      [(331.77, 1888.50)],
      [0.83],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length agreement metrics across FreeMoCap pose estimation backends compared to Qualisys.],
) <tbl-path-length-agreement>