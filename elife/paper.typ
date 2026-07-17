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
  title: "FreeMoCap",
  authors: (

  ),
  affiliations: (

  ),
  corresponding-email: "aaron@freemocap.org",
  abstract: [

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
