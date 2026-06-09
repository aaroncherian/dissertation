#import "template.typ": *

#show outline: it => {
  in-outline.update(true)
  it
  in-outline.update(false)
}

#show: neu-coe-dissertation






#include "chapters/ch1_intro.typ"
#include "chapters/ch_results.typ"

// #include "chapters/ch2_freemocap.typ"
// #include "chapters/ch_math.typ"
// #include "chapters/ch_gait.typ"
// #include "chapters/ch_balance.typ"
// #include "chapters/ch_prosthetics.typ"
// #include "chapters/ch_practical_considerations.typ"
// #include "chapters/ch_conclusion.typ"

#bibliography("references.bib", style: "nature")

// --- Appendices ---
#begin-appendix()

// Example: include appendix files just like chapters
// #include "chapters/appendix_a.typ"

#include "chapters/appendix/appendix_a.typ"
#include "chapters/appendix/appendix_b.typ"