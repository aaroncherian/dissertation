#import "template.typ": *

#show: neu-coe-dissertation

// --- Title page ---
#title-page(
  title: "Your Dissertation Title",
  author: "Your Name",
  nuid: "123456789",
  dept: "Your Department",
  degree: "Doctor of Philosophy",
  field: "Bioengineering",
  submit_date: "February 2026",
)

// --- Front matter (roman numerals) ---
#begin-frontmatter()

#front-heading("ABSTRACT")
Write your abstract here.

#pagebreak()
#front-heading("ACKNOWLEDGMENTS")
Write your acknowledgments here.

#pagebreak()
#front-heading("TABLE OF CONTENTS")
#outline()

// --- Main matter (arabic numerals) ---
#begin-mainmatter()

#include "chapters/ch1_intro.typ"
#include "chapters/ch2_freemocap.typ"
#include "chapters/ch_balance.typ"


#bibliography("references.bib", style: "nature")