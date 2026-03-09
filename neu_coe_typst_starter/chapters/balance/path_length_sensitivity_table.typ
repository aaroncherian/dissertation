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
      [slope = 0.87, _r_#super[2] = 0.89],
      [slope = 0.99, _r_#super[2] = 0.78],
      [slope = 1.03, _r_#super[2] = 0.96],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [slope = -0.74, _r_#super[2] = 0.03],
      [slope = -6.00, _r_#super[2] = 0.38],
      [slope = -0.29, _r_#super[2] = 0.03],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [slope = -1.30, _r_#super[2] = 0.07],
      [slope = 0.43, _r_#super[2] = 0.01],
      [slope = 1.46, _r_#super[2] = 0.21],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length sensitivity metrics across FreeMoCap pose estimation backends. Each cell reports the regression slope and coefficient of determination (_r_#super[2]) for the condition contrast relative to Qualisys.],
) <tbl-path-length-sensitivity>