#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    stroke: none,

    // Header
    table.hline(stroke: 1pt),
    table.header(
      [], [*FMC-MediaPipe*], [*Reference*],
    ),
    table.hline(stroke: 0.5pt),

    // 2D velocity section
    table.cell(colspan: 3, align: left)[*Mean 2D COM Velocity (mm/s)*],

    [Eyes Open / Solid Ground], [3.54 $plus.minus$ 0.76], [3.63 $plus.minus$ 0.77],
    [Eyes Closed / Solid Ground], [4.45 $plus.minus$ 1.16], [4.61 $plus.minus$ 1.16],
    [Eyes Open / Foam], [6.84 $plus.minus$ 1.46], [7.35 $plus.minus$ 1.52],
    [Eyes Closed / Foam], [10.53 $plus.minus$ 3.48], [11.48 $plus.minus$ 3.32],
    table.hline(stroke: 1pt),
  ),
  caption: [Mean 2D COM velocity for MediaPipe-derived and reference data. Values are reported as group mean $plus.minus$ SD (n = 12). Vertical velocity SD on firm ground with eyes open serves as an estimate of system measurement noise.],
) <tbl-velocity-metrics>
