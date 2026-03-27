== Results

=== Accuracy of Prosthetic Tracking
Integrating a prosthesis-specific DeepLabCut (DLC) model into the tracking pipeline markedly improved reconstruction quality. @fig-prosthetic-tracking illustrates representative trajectories for the prosthetic knee, ankle and toe trajectories during gait. Improvements from the DLC model were evident across the sagittal and mediolateral axes, although the biggest improvements were seen in the vertical axis. For instance, vertical error at the prosthetic ankle decreased from 152.1 ± 11.5 mm to 8.0 ± 2.4 mm following DLC model integration (@tbl-prosthetic-rmse).

#figure(
  image("figures/tracking_fig_v5.png"),
  caption: [Comparison of prosthesis-side keypoint trajectories captured by Qualisys (black), MediaPipe (red), RTMPose (green), and DeepLabCut (DLC) (blue) during a treadmill walking trial. Left panel shows pose estimation tracking overlays from MediaPipe (top), RTMPose (middle), and a DeepLabCut model trained on prosthetic limb features (bottom). Right panel illustrates 3D trajectories (X: anterior-posterior, Y: medio-lateral, Z: vertical) for the prosthetic leg (right knee, ankle, heel and toe) joint centers from a representative trial.]
) <fig-prosthetic-tracking>

#figure(
  table(
    columns: 5,
    align: (left, left, center, center, center),
    stroke: none,
    table.hline(),
    table.header(
      [Marker], [Tracker], [X (mm)], [Y (mm)], [Z (mm)],
    ),
    table.hline(),
    [], [MediaPipe], [13.6 $plus.minus$ 1.1], [29.0 $plus.minus$ 5.3], [50.0 $plus.minus$ 8.1],
    [Right Knee], [RTMPose], [12.4 $plus.minus$ 1.3], [24.4 $plus.minus$ 3.1], [73.4 $plus.minus$ 4.3],
    [], [DeepLabCut], [2.6 $plus.minus$ 0.8], [21.9 $plus.minus$ 4.1], [14.3 $plus.minus$ 2.1],
    table.hline(),
    [], [MediaPipe], [18.8 $plus.minus$ 2.8], [45.8 $plus.minus$ 5.5], [96.4 $plus.minus$ 12.9],
    [Right Ankle], [RTMPose], [14.6 $plus.minus$ 1.9], [46.5 $plus.minus$ 5.0], [152.1 $plus.minus$ 11.5],
    [], [DeepLabCut], [7.8 $plus.minus$ 2.0], [23.7 $plus.minus$ 6.3], [11.3 $plus.minus$ 2.8],
    table.hline(),
    [], [MediaPipe], [25.4 $plus.minus$ 3.4], [50.0 $plus.minus$ 7.8], [74.6 $plus.minus$ 12.7],
    [Right Heel], [RTMPose], [16.0 $plus.minus$ 1.6], [79.0 $plus.minus$ 7.6], [124.5 $plus.minus$ 12.5],
    [], [DeepLabCut], [11.9 $plus.minus$ 1.7], [17.6 $plus.minus$ 5.9], [8.8 $plus.minus$ 1.9],
    table.hline(),
    [], [MediaPipe], [25.3 $plus.minus$ 5.7], [51.4 $plus.minus$ 6.7], [86.2 $plus.minus$ 13.4],
    [Right Toe], [RTMPose], [16.9 $plus.minus$ 2.4], [60.5 $plus.minus$ 6.7], [112.3 $plus.minus$ 8.7],
    [], [DeepLabCut], [10.6 $plus.minus$ 4.1], [18.8 $plus.minus$ 5.7], [10.6 $plus.minus$ 4.7],
    table.hline(),
  ),
  caption: [Prosthetic-side marker RMSE (mm), mean $plus.minus$ SD across trials.],
) <tbl-prosthetic-rmse>

=== Tracking Leg-Length Adjustments
Both systems consistently tracked the ±6.35 mm and ±12.70 mm prosthetic leg length adjustments (@fig-llp), with measured differences preserving the order and approximate magnitude of adjustments. The marker-based data exhibited small deviations from expected values (-0.58 to +1.43 mm) with low variability (MAD: 0.53-0.80 mm). The markerless system exhibited comparable deviations from expected values (-1.58 to +1.64 mm) with higher variability (MAD: 1.57-3.08 mm). 

#figure(
  image("figures/leg_length_plot.png", width:80%),
  caption: [Median leg length relative to the neutral prosthetic configuration across prosthesis length conditions, measured by marker-based and markerless systems. Dashed line indicates the expected change based on known prosthetic adjustments (±6.35 mm, ±12.70 mm). Error bars represent median absolute deviation (MAD).]
) <fig-llp>



The marker-based system demonstrated sensitivity to changes in pelvic obliquity from leg length adjustments. In contrast, the markerless system showed poor preservation of alignment-dependent changes, with reduced amplitude in the detected changes. RMSE across conditions ranged from 2.75-10.3°.

#figure(
  image("figures/pelvic_obliquity_plot.png", width: 95%),
  caption: [ Pelvic obliquity is shown for markerless (left) and marker-based (right) systems across five alignment conditions (leg length adjustment: -12.70 mm, -6.35 mm, neutral, +6.35 mm, +12.70 mm). Pelvic obliquity data for the markerless system is derived from an RTMPose pose estimation backend. Solid lines indicate condition-level means and error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100\% for comparison across strides. Positive values indicate that the right hip is higher than the left. ]
)

=== Tracking Ankle Plantar/Dorsiflexion Adjustments

The markerless system and marker-based reference both demonstrated sensitivity to changes in sagittal knee and ankle angles across each prosthetic ankle alignment condition ( @fig-aap). Mean RMSE across conditions was 3.84 ± 0.12° for the knee and 1.45 ± 0.20° for the ankle. Both systems detected consistent, condition-dependent increases in peak ankle dorsiflexion corresponding to the alignment adjustments. Peak ankle dorsiflexion increased from 1.81 ± 0.60° (-5.6° condition) to 7.06 ± 0.37° (+5.6° condition) in the markerless system, and from 2.30 ± 0.34° to 6.52 ± 0.30° in the marker-based system, demonstrating similar sensitivity to alignment-induced changes. During swing phase, markerless ankle angle profiles showed greater fluctuation and larger between-stride variability relative to the marker-based system.

Both systems demonstrated a general increase in minimum toe clearance with progressive dorsiflexion, although the magnitude of change differed between systems (marker-based system range: 3 mm; markerless system range: 9 mm). The markerless system underestimated toe clearance in plantarflexed conditions and overestimated clearance in dorsiflexed conditions. Mean RMSE between systems was 4.50 ± 0.62 mm. 

#figure(
  image("figures/ankle_adjustment_plot.png", width:90%),
  caption: [Mean sagittal plane knee and ankle angles are shown for markerless (left) and marker-based (right) systems across five prosthetic alignment conditions (plantarflexion: -5.6°, -2.8°; neutral: 0°, dorsiflexion: +2.8°, +5.6°). Solid lines indicate condition-level means and error bars indicate ±1 SD across strides. The gait cycle is normalized to 0-100\% for comparison across strides.]
) <fig-aap>


#figure(
  image("figures/toe_clearance.png", width: 80%),
  caption: [Minimum toe clearance measured by markerless (blue circles) and marker-based (red squares) systems across prosthetic ankle plantar/dorsiflexion alignment conditions relative to neutral. Points represent condition-level means and error bars indicate ±1 SD across strides]
)

=== Tracking Toe-In/Toe-Out Adjustments
Both markerless and marker-based systems captured systematic changes in foot progression angle (FPA) consistent with the toe-in/out adjustments to the prosthesis (@fig-fpa). The markerless system preserved condition ordering relative to the reference system, with a mean stride-level RMSE across conditions of 0.96 ± 0.37°, demonstrating sensitivity to controlled prosthetic alignment changes. 

#figure(
  image("figures/fpa_plot.png", width:90%),
  caption: [Mean foot progression angle is shown for markerless (left) and marker-based (right) systems across five alignment conditions (toe-in: –6°, –3°; neutral: 0°, toe-out: +3°, +6°). Solid lines indicate condition-level means and error bars indicate ±1 SD across strides. The gait cycle is normalized to 0–100\% for comparison across strides. ]) <fig-fpa>

=== Gait Parameter Comparison
The markerless system tended to underestimate stance duration and overestimate swing duration (@fig-prosthetic-hist). Mean error for the prosthetic leg 3D data (DLC-derived) was close to zero (stance duration: -12.7 ± 31.8 ms; swing duration: 13.9 ± 29.6 ms; N = 590 strides). For the non-prosthetic leg 3D data (RTMPose-derived), mean error was slightly larger (stance duration: -23.4 ± 137.6 ms; swing duration: 29.6 ± 132.1 ms; N = 591 strides), with substantially greater variability in temporal estimates. 

#figure(
  image("figures/gait_error_histogram_left_right.png", width:90%),
  caption: [Distribution of stride-level markerless system gait event errors relative to marker-based reference across all trials. Left: Stance duration. Right: Swing duration. The vertical dashed line indicates zero error. Prosthetic leg gait parameters (blue) are derived from the custom-trained DeepLabCut model and non-prosthetic gait parameters (orange) are derived from an RTMPose pose estimation backend. Display range set to the 99th percentile of absolute error (±333 ms). Twenty-three strides (1.0\%) with errors exceeding this range are not shown. All observations were retained in statistical analyses.]
) <fig-prosthetic-hist>




