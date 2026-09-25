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
      [Stride Length (mm)], [MediaPipe], [-0.39], [-69.52], [+68.73], [0.993 (0.990, 0.990)],
      [], [RTMPose], [-0.42], [-63.05], [+62.22], [0.994 (0.990, 0.990)],
      [], [ViTPose], [-0.07], [-63.73], [+63.59], [0.994 (0.990, 0.990)],
      table.hline(stroke: 0.3pt),
      [Step Length (mm)], [MediaPipe], [+0.91], [-68.33], [+70.15], [0.972 (0.970, 0.970)],
      [], [RTMPose], [-0.21], [-62.16], [+61.73], [0.977 (0.980, 0.980)],
      [], [ViTPose], [+0.17], [-66.03], [+66.37], [0.974 (0.970, 0.980)],
      table.hline(stroke: 0.3pt),
      [Stance Duration (ms)], [MediaPipe], [+4.52], [-59.66], [+68.70], [0.991 (0.990, 0.990)],
      [], [RTMPose], [+2.48], [-34.09], [+39.06], [0.997 (1.000, 1.000)],
      [], [ViTPose], [-0.95], [-37.75], [+35.85], [0.997 (1.000, 1.000)],
      table.hline(stroke: 0.3pt),
      [Swing Duration (ms)], [MediaPipe], [-5.23], [-49.32], [+38.86], [0.899 (0.880, 0.910)],
      [], [RTMPose], [-2.56], [-38.92], [+33.81], [0.936 (0.930, 0.940)],
      [], [ViTPose], [+0.83], [-37.08], [+38.74], [0.932 (0.930, 0.940)],
      table.hline(stroke: 0.3pt),
      [Stride Duration (ms)], [MediaPipe], [-1.75], [-91.34], [+87.85], [0.988 (0.990, 0.990)],
      [], [RTMPose], [-0.08], [-36.36], [+36.20], [0.998 (1.000, 1.000)],
      [], [ViTPose], [-0.12], [-37.23], [+36.99], [0.998 (1.000, 1.000)],
      table.hline(stroke: 1pt),
    )
  },
  caption: [Bland-Altman agreement statistics for spatiotemporal gait parameters across all walking speeds. Bias and limits of agreement (LoA) are reported in the native units of each metric. ICC = intraclass correlation coefficient (2,1) with 95% confidence interval.],
) <tbl-ba-gait-pooled>