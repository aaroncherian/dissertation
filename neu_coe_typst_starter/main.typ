#import "template.typ": *

#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}

#show: neu-coe-dissertation

// --- Title page ---
#title-page(
  title: "Open-source Development and Validation of a Low-Cost Markerless System for Quantitative Motion Analysis
",
  author: "Aaron T. Cherian",
  dept: "Bioengineering",
  degree: "Doctor of Philosophy",
  field: "Bioengineering",
  submit_date: "April 2026",
)



// --- Front matter (roman numerals) ---
#pagebreak()
#set page(numbering: "i")
#counter(page).update(1)

#front-heading("ABSTRACT")
Write your abstract here.

#pagebreak()
#front-heading("ACKNOWLEDGMENTS")
Write your acknowledgments here.

#pagebreak()
#front-heading("PREFACE")
#include "preface.typ"
#pagebreak()
#front-heading("TABLE OF CONTENTS")
#outline(title: none)

#pagebreak()
#front-heading("List of Figures")



#outline(
  title: none,
  target: figure.where(kind: image),
)

// --- Main matter (arabic numerals) ---
// --- Main matter ---
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)


#include "chapters/ch1_intro.typ"
#include "chapters/ch2_freemocap.typ"
#include "chapters/ch_math.typ"
#include "chapters/ch_gait.typ"
#include "chapters/ch_balance.typ"
#include "chapters/ch_prosthetics.typ"
#include "chapters/ch_practical_considerations.typ"
#include "chapters/ch_conclusion.typ"

#bibliography("references.bib", style: "nature")

// --- Appendices ---
#begin-appendix()

// Example: include appendix files just like chapters
// #include "chapters/appendix_a.typ"

#include "chapters/appendix/appendix_a.typ"
#include "chapters/appendix/appendix_b.typ"