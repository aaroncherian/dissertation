#figure(
  {
    set text(size: 9pt)
    table(
      columns: (1.2fr, 1.5fr, 1.5fr, 1.5fr),
      align: (left, center, center, center),
      stroke: none,
      table.hline(stroke: 1pt),
      table.header(
        [*System*],
        [*EC:Solid − EO:Solid*],
        [*EO:Foam − EO:Solid*],
        [*EC:Foam − EO:Solid*],
      ),
      table.hline(stroke: 0.5pt),
      [FMC-MediaPipe],
      [slope = 0.89, _r_#super[2] = 0.90],
      [slope = 1.02, _r_#super[2] = 0.85],
      [slope = 1.05, _r_#super[2] = 0.97],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [slope = -0.70, _r_#super[2] = 0.02],
      [slope = -5.31, _r_#super[2] = 0.32],
      [slope = -0.21, _r_#super[2] = 0.01],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [slope = -1.23, _r_#super[2] = 0.06],
      [slope = 0.76, _r_#super[2] = 0.02],
      [slope = 1.50, _r_#super[2] = 0.23],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length sensitivity metrics across FreeMoCap pose estimation backends. Each cell reports the regression slope and coefficient of determination (_r_#super[2]) for the condition contrast relative to Qualisys.],
) <tbl-path-length-sensitivity>