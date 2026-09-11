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
        [*Visual <br> Perturbation*],
        [*Proprioceptive <br> Perturbation*],
        [*Visual + Proprioceptive  <br> Perturbation*],
      ),
      table.hline(stroke: 0.5pt),
      [MediaPipe],
      [slope = 0.89, _r_#super[2] = 0.89],
      [slope = 1.02, _r_#super[2] = 0.83],
      [slope = 1.06, _r_#super[2] = 0.96],
      table.hline(stroke: 0.5pt),
      [ViTPose],
      [slope = -0.73, _r_#super[2] = 0.02],
      [slope = -5.48, _r_#super[2] = 0.33],
      [slope = -0.24, _r_#super[2] = 0.02],
      table.hline(stroke: 0.5pt),
      [RTMPose],
      [slope = -1.23, _r_#super[2] = 0.06],
      [slope = 0.63, _r_#super[2] = 0.01],
      [slope = 1.45, _r_#super[2] = 0.21],
      table.hline(stroke: 0.5pt),
      table.hline(stroke: 1pt),
    )
  },
  caption: [Summary of COM path length sensitivity metrics across FreeMoCap pose estimation backends. Each cell reports the regression slope and coefficient of determination (_r_#super[2]) for the condition contrast relative to Qualisys.],
) <tbl-path-length-sensitivity>