#figure(
  table(
    columns: (auto, auto, auto, auto, auto),
    align: (left, left, center, center, center),
    stroke: none,

    table.hline(stroke: 1pt),
    table.header(
      [*Condition*], [*Backend*], [*Path Length* \ (mm)], [*Ellipse Area* \ (mm#super[2])], [*Mean Velocity* \ (mm/s)],
    ),
    table.hline(stroke: 0.5pt),

    [EO / Solid], [Reference], [201.1 $plus.minus$ 38.7], [256.8 $plus.minus$ 111.7], [3.63 $plus.minus$ 0.75],
    [], [MediaPipe], [228.9 $plus.minus$ 39.3], [242.4 $plus.minus$ 111.1], [3.54 $plus.minus$ 0.73],
    [], [RTMPose], [1299.2 $plus.minus$ 383.0], [274.4 $plus.minus$ 118.5], [19.52 $plus.minus$ 8.09],
    [], [ViTPose], [951.3 $plus.minus$ 363.4], [269.6 $plus.minus$ 124.7], [14.93 $plus.minus$ 6.80],
    table.hline(stroke: 0.3pt),
    [EC / Solid], [Reference], [251.5 $plus.minus$ 55.3], [310.5 $plus.minus$ 150.7], [4.61 $plus.minus$ 1.05],
    [], [MediaPipe], [272.7 $plus.minus$ 53.2], [304.6 $plus.minus$ 160.3], [4.45 $plus.minus$ 1.02],
    [], [RTMPose], [1298.6 $plus.minus$ 275.7], [310.9 $plus.minus$ 142.2], [19.45 $plus.minus$ 5.41],
    [], [ViTPose], [1063.5 $plus.minus$ 277.6], [331.9 $plus.minus$ 149.2], [17.20 $plus.minus$ 5.23],
    table.hline(stroke: 0.3pt),
    [EO / Foam], [Reference], [406.9 $plus.minus$ 81.0], [971.5 $plus.minus$ 467.2], [7.35 $plus.minus$ 1.52],
    [], [MediaPipe], [403.8 $plus.minus$ 87.7], [938.2 $plus.minus$ 476.2], [6.84 $plus.minus$ 1.48],
    [], [RTMPose], [1435.8 $plus.minus$ 230.7], [977.7 $plus.minus$ 481.2], [21.77 $plus.minus$ 4.92],
    [], [ViTPose], [1139.3 $plus.minus$ 319.2], [971.1 $plus.minus$ 447.7], [18.53 $plus.minus$ 5.79],
    table.hline(stroke: 0.3pt),
    [EC / Foam], [Reference], [639.9 $plus.minus$ 171.6], [870.2 $plus.minus$ 387.3], [11.48 $plus.minus$ 3.22],
    [], [MediaPipe], [599.0 $plus.minus$ 188.1], [843.7 $plus.minus$ 390.5], [10.53 $plus.minus$ 3.37],
    [], [RTMPose], [1673.8 $plus.minus$ 428.3], [897.2 $plus.minus$ 380.2], [26.14 $plus.minus$ 7.46],
    [], [ViTPose], [1250.1 $plus.minus$ 300.7], [858.7 $plus.minus$ 373.0], [20.54 $plus.minus$ 5.30],
    table.hline(stroke: 1pt),
  ),
  caption: [Center-of-mass postural sway metrics (path length, 95% prediction ellipse area, and 2D mean velocity in the horizontal plane) across balance conditions for each tracker. Values are reported as group mean $plus.minus$ SD. EO = eyes open, EC = eyes closed. ],) <tbl-postural-metrics>

