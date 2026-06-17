// =============================================================================
//  paper.typ — MAIN FILE.  Compile this one:  typst compile paper.typ
//  ---------------------------------------------------------------------------
//  The template lives in elife.typ (definitions only). This file applies the
//  document style once and pulls the body in from part files with #include.
//  Counters, the figure-supplement auto-numbering, labels, and cross-references
//  all work across #include boundaries because the whole thing compiles into a
//  single document.
// =============================================================================

#import "elife.typ": *

#show: elife.with(
  title: "FreeMoCap: an extensible benchmarking framework for markerless motion capture across clinical movement paradigms",
  authors: (
    (name: "Aaron [Surname]", affil: (1,), corresponding: true),
    (name: "Jonathan Matthis", affil: (2,)),
  ),
  affiliations: (
    "FreeMoCap Foundation, Providence, Rhode Island, United States",
    "Department of Biology, Northeastern University, Boston, Massachusetts, United States",
  ),
  corresponding-email: "aaron@freemocap.org",
  abstract: [
    Markerless motion capture from consumer cameras promises to broaden access
    to quantitative movement analysis, but its accuracy depends on choices that
    are rarely evaluated head-to-head. We present FreeMoCap as an extensible
    benchmarking framework and compare three pose-estimation backends
    (MediaPipe, RTMPose, ViTPose) against a marker-based reference (Qualisys)
    across treadmill gait and clinical balance paradigms. Backend choice
    interacts with task type. Framing the system as a forward-facing benchmark
    rather than a single validation makes these trade-offs explicit.
  ],
)


// ---- body: each section can be its own file --------------------------------
#include "introduction.typ"
#include "results.typ"
#include "discussion.typ"
#include "methods.typ"

// ---- end-matter declarations (inline here, or include a declarations.typ) --
= Acknowledgements
We thank ...

= Author contributions
#text(size: 10pt)[
*Aaron [Surname]:* Conceptualization, Methodology, Software, Formal analysis,
Investigation, Data curation, Writing – original draft, Visualization. \
*Jonathan Matthis:* Conceptualization, Software, Supervision, Writing – review
and editing.
]

= Competing interests
The authors declare that no competing interests exist.

= Funding
This work was supported by [funder / grant number].

= Data availability
All data underlying the figures are available at [repository + DOI].

= Code availability
FreeMoCap is open source at https://github.com/freemocap.

// ---- references, collected supplements, appendices -------------------------
#bibliography("references.bib", style: "harvard-cite-them-right", title: "References")

#supplementary-material()

#include "appendices.typ"
