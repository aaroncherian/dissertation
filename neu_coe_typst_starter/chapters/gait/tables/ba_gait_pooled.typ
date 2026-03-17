#figure(
  {
    set text(size: 9pt)
    table(
      columns: (auto, auto, auto, auto, auto, auto),
      align: (left, left, right, right, right, right),
      stroke: none,
      table.hline(stroke: 1pt),
      table.header(
        [*Metric*], [*Tracker*], [*Bias*], [*Lower LoA*], [*Upper LoA*], [*ICC (95% CI)*],
      ),
      table.hline(stroke: 0.5pt),
      [Stride Length (mm)], [MediaPipe], [-0.29], [-68.98], [+68.41], [0.993 (0.990, 0.990)],
      [], [RTMPose], [-0.41], [-63.05], [+62.23], [0.994 (0.990, 0.990)],
      [], [ViTPose], [-0.07], [-63.73], [+63.59], [0.994 (0.990, 0.990)],
      table.hline(stroke: 0.3pt),
      [Step Length (mm)], [MediaPipe], [+0.70], [-68.64], [+70.04], [0.972 (0.970, 0.970)],
      [], [RTMPose], [-0.31], [-62.18], [+61.56], [0.977 (0.980, 0.980)],
      [], [ViTPose], [+0.16], [-66.01], [+66.33], [0.974 (0.970, 0.980)],
      table.hline(stroke: 0.3pt),
      [Stance Duration (ms)], [MediaPipe], [+4.78], [-57.64], [+67.20], [0.991 (0.990, 0.990)],
      [], [RTMPose], [+2.48], [-34.09], [+39.06], [0.997 (1.000, 1.000)],
      [], [ViTPose], [-0.93], [-37.76], [+35.89], [0.997 (1.000, 1.000)],
      table.hline(stroke: 0.3pt),
      [Swing Duration (ms)], [MediaPipe], [-5.35], [-49.27], [+38.58], [0.900 (0.880, 0.910)],
      [], [RTMPose], [-2.56], [-38.92], [+33.81], [0.936 (0.930, 0.940)],
      [], [ViTPose], [+0.81], [-37.13], [+38.75], [0.932 (0.930, 0.940)],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Bland-Altman agreement statistics for spatiotemporal gait parameters across all walking speeds. Bias and limits of agreement (LoA) are reported in the native units of each metric. ICC = intraclass correlation coefficient (2,1) with 95% confidence interval.],
) <tbl-ba-gait-pooled>