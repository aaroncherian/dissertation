// Northeastern University COE MS/PhD Dissertation Template (Typst)
// Matches: neu_msthesis LaTeX class (US Letter, 1.5" left margin, double-spaced)

// --- Vendored from headcount package (https://github.com/jbirnick/typst-headcount) ---
#let hc-reset-counter(ctr, levels: 1) = it => {
  if it.level <= levels { ctr.update((0,)) }
  it
}
#let hc-normalize-length(array, length) = {
  if array.len() > length {
    array = array.slice(0, length)
  } else if array.len() < length {
    array += (length - array.len()) * (0,)
  }
  return array
}
#let hc-dependent-numbering(style, levels: 1) = n => {
  numbering(style, ..hc-normalize-length(counter(heading).get(), levels), n)
}

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
  set par(first-line-indent: (amount: 0pt, all: false), spacing: .5em)
  set page(footer: none)
  align(center)[
    #v(0.8in)
    #text(14pt, weight: "bold")[#title]
    #v(1.2in)
    A Dissertation Presented \
    By \
    #v(0.15in)
    #text(14pt, weight: "bold")[#author]
    #v(0.2in)
    to
    #v(0.15in)
    #text(14pt, weight: "bold")[The Department of #dept]
    #v(0.15in)
    in partial fulfillment of the requirements \
    for the degree of
    #v(0.15in)
    #text(14pt, weight: "bold", style: "italic")[#if degree != none { degree } else { [Doctor of Philosophy] }]
    #v(0.15in)
    in the field of \
    #text(14pt, weight: "bold")[#if field != none { field } else { dept }]
    #v(1.0in)

    #text(14pt, weight: "bold")[Northeastern University] \
    #text(14pt, weight: "bold")[Boston, Massachusetts]
    #v(0.75in)

    #if submit_date != none { submit_date } else { [Month Year] }
  ]
}

// Front matter section heading (centered, bold, real heading for TOC)
#let front-heading(name) = {
  heading(level: 1, numbering: none)[#name]
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

// Appendix state
#let in-appendix = state("in-appendix", false)

// Front matter state
#let in-frontmatter = state("in-frontmatter", false)

// Switch to appendix mode (letter-numbered chapters, reset counter)
#let begin-appendix() = {
  pagebreak()
  in-appendix.update(true)
  counter(heading).update(0)
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


  show enum: set block(spacing: 1.25em)
  show list: set block(spacing: 1.25em)
  
  // Heading numbering
  set heading(numbering: "1.1.1")

  // Figure numbering: "Chapter.Figure" (e.g. Figure 3.2)
  set figure(numbering: hc-dependent-numbering("1.1"))

  set math.equation(numbering: num =>
    numbering("(1.1)", counter(heading).get().first(), num)
  )

  show math.equation.where(block: true): it => {
  v(1.5em)
  it
  v(1.5em)
}
  // Chapter headings (level 1)
  show heading.where(level: 1): it => context {
    let is-app = in-appendix.get()
    let is-front = in-frontmatter.get()
    set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    pagebreak(weak: true)
    v(1.0cm)
    if is-front {
      // Front matter headings: centered, bold, no "CHAPTER N" label
      align(center)[
        #text(14pt, weight: "bold")[#it.body]
      ]
      v(0.75cm)
    } else if it.numbering == none {
      // Unnumbered main-matter headings (e.g. Bibliography) — no CHAPTER label
      align(center)[
        #text(14pt, weight: "bold")[#it.body]
      ]
      v(1.2cm)
    } else {
      align(center)[
        #if is-app {
          smallcaps(text(12pt, weight: "bold")[APPENDIX #counter(heading).display("A")])
        } else {
          smallcaps(text(12pt, weight: "bold")[CHAPTER #counter(heading).display("1")])
        }
        #v(0.7cm)
        #text(14pt, weight: "bold")[#it.body]
      ]
      v(1.2cm)
    }
  }

  // Section headings (level 2)
  show heading.where(level: 2): it => context {
    let is-app = in-appendix.get()
    set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    v(0.65em)
    if is-app {
      text(weight: "bold")[#counter(heading).display("A.1") #h(0.5em) #it.body]
    } else {
      text(weight: "bold")[#counter(heading).display("1.1") #h(0.5em) #it.body]
    }
    v(0.35em)
  }

  // Subsection headings (level 3)
  show heading.where(level: 3): it => context {
    let is-app = in-appendix.get()
    set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    v(0.45em)
    if is-app {
      text(weight: "bold")[#counter(heading).display("A.1.1") #h(0.5em) #it.body]
    } else {
      text(weight: "bold")[#counter(heading).display("1.1.1") #h(0.5em) #it.body]
    }
    v(0.25em)
  }

  show figure: it => {
    v(1.5em)
    it
    v(1.5em)
  }
  
  // Figure captions (single-spaced, slightly smaller)
  show figure.caption: it => [
    #set par(leading: 1.0em, spacing: 0em, first-line-indent: (amount: 0pt, all: true))
    #text(11pt)[#it]
  ]

// Table of contents styling — tighter spacing, bold chapter headings only
show outline.entry: it => {
  set par(first-line-indent: (amount: 0pt, all: true))
  if it.level == 1 and it.element.func() == heading {
    v(0.5em)
    strong(it)
  } else if it.level == 1 {
    // Figure entries (level 1 but not headings) — normal weight
    v(0.2em)
    it
  } else {
    v(-0.5em)
    it
  }
}


  // Reset figure counters at each new chapter (MUST be after heading formatting show rules)
  show heading: hc-reset-counter(counter(figure.where(kind: image)))
  show heading: hc-reset-counter(counter(figure.where(kind: table)))
  show heading: hc-reset-counter(counter(figure.where(kind: raw)))

  body
}
#let in-outline = state("in-outline", false)
#let flex-caption(long, short) = context if in-outline.get() { short } else { long }