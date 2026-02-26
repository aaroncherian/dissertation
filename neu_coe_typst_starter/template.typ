// Northeastern University COE MS/PhD Dissertation Template (Typst)
// Matches: neu_msthesis LaTeX class (US Letter, 1.5" left margin, double-spaced)

// -------------------
// Helper functions (called from main.typ)
// -------------------

// Title page generator
#let title-page(
  title: none,
  author: none,
  nuid: none,
  dept: none,
  degree: none,
  field: none,
  submit_date: none,
) = {
  set par(first-line-indent: (amount: 0pt, all: false), spacing: 1em)
  set page(footer: none)
  align(center)[
    #v(1.6in)
    #text(18pt, weight: "bold")[#title]
    #v(1.2in)
    by \
    #text(14pt, weight: "bold")[#author] \
    #v(0.3in)
    #if nuid != none { [NUID: #nuid] } \
    #v(1.0in)

    A dissertation submitted to the faculty of \
    Northeastern University \
    in partial fulfillment of the requirements for the degree of \
    #if degree != none { degree } else { [Doctor of Philosophy] } \
    in \
    #if field != none { field } else { dept } \
    #v(0.75in)

    #if dept != none { dept } \
    #v(0.75in)

    #if submit_date != none { submit_date } else { [Month Year] }
  ]
}

// Front matter section heading (centered, bold)
#let front-heading(name) = {
  set par(first-line-indent: (amount: 0pt, all: true), leading: 1.0em, spacing: 0em)
  v(1.0cm)
  align(center)[#text(14pt, weight: "bold")[#name]]
  v(0.75cm)
}

// Switch to front matter (roman numerals)
#let begin-frontmatter() = {
  pagebreak()
  counter(page).update(1)
}

// Switch to main matter (arabic numerals)
#let begin-mainmatter() = {
  pagebreak()
  counter(page).update(1)
}

// -------------------
// Main template wrapper — applies all styling to the document body
// -------------------
#let neu-coe-dissertation(body) = {
  // Page setup
  set page(
    paper: "us-letter",
    margin: (left: 1.5in, rest: 1in),
    numbering: "1",
    footer: context {
      set text(10pt)
      align(center)[#counter(page).display()]
    },
  )

  set text(
    font: "Times New Roman",
    size: 12pt,
  )

  set par(
    justify: true,
    leading: 1.25em,
    spacing: 2.0em,
    first-line-indent: (amount: 0pt, all: true),
  )

  set block(spacing: 0em)

  // Heading numbering
  set heading(numbering: "1.1.1")

  // Chapter headings (level 1)
  show heading.where(level: 1): it => [
    #set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    #pagebreak(weak: true)
    #v(1.0cm)
    #align(center)[
      #smallcaps(text(12pt, weight: "bold")[CHAPTER #counter(heading).display("1")])
      #v(0.7cm)
      #text(14pt, weight: "bold")[#it.body]
    ]
    #v(1.2cm)
  ]

  // Section headings (level 2)
  show heading.where(level: 2): it => [
    #set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    #v(0.65em)
    #text(weight: "bold")[#counter(heading).display("1.1") #h(0.5em) #it.body]
    #v(0.35em)
  ]

  // Subsection headings (level 3)
  show heading.where(level: 3): it => [
    #set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    #v(0.45em)
    #text(weight: "bold")[#counter(heading).display("1.1.1") #h(0.5em) #it.body]
    #v(0.25em)
  ]

  show figure: it => {
    v(1.5em)
    it
    v(1.0em)
  }

  // Figure captions (single-spaced, slightly smaller)
  show figure.caption: it => [
    #set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    #text(11pt)[#it]
  ]

  body
}