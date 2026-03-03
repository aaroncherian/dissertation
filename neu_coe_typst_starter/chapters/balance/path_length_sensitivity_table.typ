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
      [slope = 0.89, _r_#super[2] = 0.92],
      [slope = 1.04, _r_#super[2] = 0.84],
      [slope = 1.07, _r_#super[2] = 0.96],
      table.hline(stroke: 0.5pt),
      [FMC-ViTPose],
      [slope = -0.80, _r_#super[2] = 0.03],
      [slope = -6.46, _r_#super[2] = 0.45],
      [slope = -0.58, _r_#super[2] = 0.10],
      table.hline(stroke: 0.5pt),
      [FMC-RTMPose],
      [slope = -1.24, _r_#super[2] = 0.06],
      [slope = 0.58, _r_#super[2] = 0.01],
      [slope = 1.58, _r_#super[2] = 0.21],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length sensitivity metrics across FreeMoCap pose estimation backends. Each cell reports the regression slope and coefficient of determination (_r_#super[2]) for the condition contrast relative to Qualisys.],
) <tbl-path-length-sensitivity>