#import "template.typ": *

#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}

#show: neu-coe-dissertation

// --- Title page ---
#title-page(
  title: "Open-Source Development and Validation of a Low-Cost Markerless System for Quantitative Motion Analysis",
  author: "Aaron T. Cherian",
  dept: "Bioengineering",
  degree: "Doctor of Philosophy",
  field: "Bioengineering",
  submit_date: "April 13th, 2026",
)



// --- Front matter (roman numerals) ---
#pagebreak()
#set page(numbering: "i")
#counter(page).update(1)
#in-frontmatter.update(true)

// Manual heading so the TOC doesn't list itself
#v(1.0cm)
#align(center)[#text(14pt, weight: "bold")[TABLE OF CONTENTS]]
#v(0.75cm)
#outline(title: none)

#pagebreak()
#front-heading("List of Figures")

#outline(
  title: none,
  target: figure.where(kind: image),
)

#pagebreak()
#front-heading("Abstract")
Write your abstract here.

#pagebreak()
#front-heading("Acknowledgements")
Write your acknowledgments here.

#pagebreak()
#front-heading("Preface")
#include "preface.typ"

#in-frontmatter.update(false)

// --- Main matter (arabic numerals) ---
// --- Main matter ---
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#counter(figure).update(0)
#include "chapters/ch1_intro.typ"
#counter(figure).update(0)
#include "chapters/ch2_freemocap.typ"
#counter(figure).update(0)
#include "chapters/ch_math.typ"
#counter(figure).update(0)
#include "chapters/ch_gait.typ"
#counter(figure).update(0)
#include "chapters/ch_balance.typ"
#counter(figure).update(0)
#include "chapters/ch_prosthetics.typ"
#counter(figure).update(0)
#include "chapters/ch_practical_considerations.typ"
#counter(figure).update(0)
#include "chapters/ch_conclusion.typ"

#bibliography("references.bib", style: "nature")

// --- Appendices ---
#begin-appendix()

// Example: include appendix files just like chapters
// #include "chapters/appendix_a.typ"

#include "chapters/appendix/appendix_a.typ"
#include "chapters/appendix/appendix_b.typ"