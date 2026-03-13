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
      [0.985 (0.970-0.990)],
      [1.25],
      [(-64.63, 67.13)],
      [0.90],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [0.083 (-0.060-0.290)],
      [726.19],
      [(97.82, 1354.56)],
      [0.71],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [0.057 (-0.040-0.220)],
      [1052.02],
      [(257.06, 1846.98)],
      [0.97],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length agreement metrics across FreeMoCap pose estimation backends compared to Qualisys.],
) <tbl-path-length-agreement>