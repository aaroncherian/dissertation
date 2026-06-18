// =============================================================================
//  eLife manuscript template for Typst  (single-column adaptation)
//  ---------------------------------------------------------------------------
//  Structural port of the official eLife LaTeX class, with AUTO-NUMBERING that
//  mirrors \figsupp / \figdata / \tabledata:
//   - Figure supplements detect their PARENT figure automatically and number
//     themselves per parent (Figure 1—figure supplement 1, 2, ...; restarting
//     at 1 for each parent). You do NOT pass numbers.
//   - Figure / table source data and source code likewise auto-number.
//   - All of the above are declared next to their parent but RENDERED AT THE
//     END of the manuscript (the eLife behaviour).
//   - Appendices auto-number ("Appendix 1", "Appendix 2"); appendix figures
//     number per appendix ("Appendix 1—figure 1").
//
//  PLACEMENT RULE (same as the LaTeX class, where \figsupp lives inside the
//  parent figure): put #figsupp / #figdata / #figsrccode immediately AFTER
//  their parent #figure and before the next #figure. Put #tabledata /
//  #tablesrccode immediately after their parent table #figure.
//
//  Requires Typst >= 0.12.  Single-column on purpose: production reformats to
//  the published two-column look, so there is nothing to gain by matching it.
// =============================================================================


// ---- appendix counters ------------------------------------------------------
#let _appendix-c = counter("elife-appendix")
#let _appendix-fig-c = counter("elife-appendix-figure")
#let _appendix-tab-c = counter("elife-appendix-table")


// ----------------------------------------------------------------------------
//  DOCUMENT SETUP   ( #show: elife.with(...) )
// ----------------------------------------------------------------------------
#let elife(
  title: "",
  // each author: (name: "...", affil: (1, 2), corresponding: false, marks: ("†",))
  authors: (),
  affiliations: (),          // index + 1 = the number used in affil
  corresponding-email: none,
  author-notes: (),          // list of content: equal-contribution / present-address notes
  abstract: [],
  impact: none,              // optional; the official template has none
  doc,
) = {
  set document(title: title, author: authors.map(a => a.name))

  set page(
    paper: "us-letter",
    margin: (x: 1in, top: 1in, bottom: 1in),
    numbering: "1",
    number-align: center,
  )

  // set text(font: "Libertinus Serif", size: 11pt)   // pick your installed font
  set text(size: 11pt, lang: "en")
  set par(justify: true, leading: 0.62em, spacing: 0.9em)
  set par.line(numbering: "1")   // eLife reviews a line-numbered PDF

  // Unnumbered headings, eLife sizing.
  set heading(numbering: none)
  show heading.where(level: 1): it => block(above: 1.4em, below: 0.6em)[
    #set text(size: 13pt, weight: "bold")
    #it.body
  ]
  show heading.where(level: 2): it => block(above: 1em, below: 0.4em)[
    #set text(size: 11pt, weight: "bold")
    #it.body
  ]
  show heading.where(level: 3): it => block(above: 0.8em, below: 0.3em)[
    #set text(size: 11pt, style: "italic", weight: "regular")
    #it.body
  ]

  // Figure / table numbering + captions.
  set figure(numbering: "1")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "appendixtab"): set figure.caption(position: top)
  show figure.caption: it => context {
    let label = if it.kind in ("figsupp", "appendixfig", "appendixtab") {
      it.supplement                                   // full label already built
    } else {
      [#it.supplement #it.counter.display(it.numbering)]   // "Figure N" / "Table N"
    }
    block(width: 100%, above: 0.5em)[
      #set align(left)
      #set text(size: 9.5pt)
      #set par(justify: true, leading: 0.55em)
      #strong[#label.]~#it.body
    ]
  }

  // ---- TITLE BLOCK ----------------------------------------------------------
  block(width: 100%)[
    #set par(justify: false)
    #text(size: 18pt, weight: "bold")[#title]

    #v(0.6em)
    #set text(size: 11pt)
    #{
      let rendered = authors.map(a => {
        let nums = a.affil.map(str).join(",")
        let star = if a.at("corresponding", default: false) { "*" } else { "" }
        let extra = a.at("marks", default: ()).join()
        [#a.name#super[#nums#star#extra]]
      })
      rendered.join(", ")
    }

    #v(0.4em)
    #set text(size: 9.5pt, style: "italic")
    #for (i, aff) in affiliations.enumerate() [
      #super[#str(i + 1)]#aff #linebreak()
    ]

    #if corresponding-email != none {
      set text(size: 9.5pt, style: "normal")
      [#super[\*]For correspondence: #link("mailto:" + corresponding-email)[#corresponding-email]#linebreak()]
    }
    #for note in author-notes {
      set text(size: 9pt, style: "normal")
      [#note #linebreak()]
    }
  ]

  v(1em)

  // ---- ABSTRACT (<=150 words, single paragraph) -----------------------------
  block(width: 100%)[
    #heading(level: 2, outlined: false)[Abstract]
    #set par(justify: true)
    #abstract
  ]

  // ---- IMPACT STATEMENT (optional) ------------------------------------------
  if impact != none {
    v(0.4em)
    block(width: 100%, fill: luma(245), inset: 8pt, radius: 3pt)[
      #set text(size: 9.5pt)
      #strong[Impact statement.]~#impact
    ]
  }

  v(1em)
  doc
}


// ----------------------------------------------------------------------------
//  AUTO-NUMBERED, DEFERRED SUPPLEMENTARY MATERIAL
//  (the parent number is read from the live figure/table counter; the per-
//   parent index is the count of same-parent markers declared earlier)
// ----------------------------------------------------------------------------

// FIGURE SUPPLEMENT — place right after its parent figure.
//   #figsupp(key: "rmse-x",                           // optional, for #suppref
//            short: [one-line note for main text],     // optional
//            caption: [full legend used at the end],
//            data: ([Underlying values (CSV).],),      // optional, auto-numbered
//            srccode: ([Analysis script.],))[          // optional, auto-numbered
//     #image("fig1-figsupp1.png")
//   ]
#let figsupp(key: none, short: none, caption: [], data: (), srccode: (), body) = context {
  let parent = counter(figure.where(kind: image)).get().first()
  let n = query(selector(<efs>).before(here(), inclusive: false)).filter(m => m.value.parent == parent).len() + 1
  [#metadata((parent: parent, n: n, key: key, caption: caption, body: body, data: data, srccode: srccode))<efs>]
  if short != none {
    block(width: 100%, above: 0.5em, below: 0.5em)[
      #set text(size: 9.5pt)
      #strong[Figure #parent#sym.dash.em#"figure supplement"~#n.]~#short
    ]
  }
}

// Reference a figure supplement by the `key` you gave it:  #suppref("rmse-x")
// Prints the live "Figure N—figure supplement M" and updates automatically if
// supplements are added, removed, or reordered. Works before or after the
// supplement is declared. Shows a red marker if the key is not found.
#let suppref(key) = context {
  let hits = query(<efs>).filter(m => m.value.at("key", default: none) == key)
  if hits.len() > 0 {
    let v = hits.first().value
    [Figure #(v.parent)#sym.dash.em#"figure supplement"~#(v.n)]
  } else {
    text(fill: red)[#("[?suppref: " + key + "?]")]
  }
}

// FIGURE source data / source code — place right after the parent figure.
#let figdata(body) = context {
  let parent = counter(figure.where(kind: image)).get().first()
  let n = query(selector(<efd>).before(here(), inclusive: false)).filter(m => m.value.parent == parent).len() + 1
  [#metadata((parent: parent, n: n, body: body))<efd>]
}
#let figsrccode(body) = context {
  let parent = counter(figure.where(kind: image)).get().first()
  let n = query(selector(<efsc>).before(here(), inclusive: false)).filter(m => m.value.parent == parent).len() + 1
  [#metadata((parent: parent, n: n, body: body))<efsc>]
}

// TABLE source data / source code — place right after the parent table figure.
#let tabledata(body) = context {
  let parent = counter(figure.where(kind: table)).get().first()
  let n = query(selector(<etd>).before(here(), inclusive: false)).filter(m => m.value.parent == parent).len() + 1
  [#metadata((parent: parent, n: n, body: body))<etd>]
}
#let tablesrccode(body) = context {
  let parent = counter(figure.where(kind: table)).get().first()
  let n = query(selector(<etsc>).before(here(), inclusive: false)).filter(m => m.value.parent == parent).len() + 1
  [#metadata((parent: parent, n: n, body: body))<etsc>]
}

// ---- emit everything collected above (call once, near the end) -------------
#let _srcline(label-body, legend) = block(width: 100%, above: 0.4em)[
  #set text(size: 9pt)
  #strong[#label-body.]~#legend
]

#let supplementary-material(title: "Figure supplements, source data and source code") = context {
  let supps = query(<efs>).map(m => m.value)
  let fdata = query(<efd>).map(m => m.value)
  let fcode = query(<efsc>).map(m => m.value)
  let tdata = query(<etd>).map(m => m.value)
  let tcode = query(<etsc>).map(m => m.value)
  let total = supps.len() + fdata.len() + fcode.len() + tdata.len() + tcode.len()

  if total > 0 {
    heading(level: 1)[#title]

    // ---- grouped by parent FIGURE ----
    let fparents = ()
    for e in (supps + fdata + fcode) { if e.parent not in fparents { fparents.push(e.parent) } }
    for p in fparents.sorted() {
      for e in supps.filter(x => x.parent == p).sorted(key: x => x.n) {
        figure(
          e.body, caption: e.caption, kind: "figsupp", numbering: none,
          supplement: [Figure #p#sym.dash.em#"figure supplement"~#(e.n)],
        )
        for (i, d) in e.data.enumerate() {
          _srcline([Figure #p#sym.dash.em#"figure supplement"~#(e.n)#sym.dash.em#"source data"~#(i + 1)], d)
        }
        for (i, c) in e.srccode.enumerate() {
          _srcline([Figure #p#sym.dash.em#"figure supplement"~#(e.n)#sym.dash.em#"source code"~#(i + 1)], c)
        }
        v(0.6em)
      }
      for e in fdata.filter(x => x.parent == p).sorted(key: x => x.n) {
        _srcline([Figure #p#sym.dash.em#"source data"~#(e.n)], e.body)
      }
      for e in fcode.filter(x => x.parent == p).sorted(key: x => x.n) {
        _srcline([Figure #p#sym.dash.em#"source code"~#(e.n)], e.body)
      }
    }

    // ---- grouped by parent TABLE ----
    let tparents = ()
    for e in (tdata + tcode) { if e.parent not in tparents { tparents.push(e.parent) } }
    for p in tparents.sorted() {
      for e in tdata.filter(x => x.parent == p).sorted(key: x => x.n) {
        _srcline([Table #p#sym.dash.em#"source data"~#(e.n)], e.body)
      }
      for e in tcode.filter(x => x.parent == p).sorted(key: x => x.n) {
        _srcline([Table #p#sym.dash.em#"source code"~#(e.n)], e.body)
      }
    }
  }
}


// ----------------------------------------------------------------------------
//  APPENDICES  ("Appendix 1", ...; figures "Appendix 1—figure 1")
//    #appendix(title: "Mathematics of reconstruction")[
//      ...text...  see #appendixfigref("triangulation") ...
//      #appendix-figure(key: "triangulation", caption: [Triangulation geometry.])[ #image("a1f1.png") ]
//    ]
// ----------------------------------------------------------------------------
#let appendix(title: none, body) = {
  _appendix-c.step()
  _appendix-fig-c.update(0)
  _appendix-tab-c.update(0)
  context {
    let n = _appendix-c.display("1")
    heading(level: 1)[Appendix #n#if title != none [ — #title]]
  }
  body
}

#let appendix-figure(key: none, caption: [], body) = {
  _appendix-fig-c.step()
  context {
    let a = _appendix-c.get().first()
    let f = _appendix-fig-c.get().first()
    [#metadata((a: a, f: f, key: key))<eaf>]
    figure(
      body, caption: caption, kind: "appendixfig", numbering: none,
      supplement: [Appendix #a#sym.dash.em#"figure"~#f],
    )
  }
}

// Reference an appendix figure by its `key`:  #appendixfigref("triangulation")
// Prints the live "Appendix N—figure M" and updates if appendices or appendix
// figures are reordered. Red marker if the key is not found.
#let appendixfigref(key) = context {
  let hits = query(<eaf>).filter(m => m.value.at("key", default: none) == key)
  if hits.len() > 0 {
    let v = hits.first().value
    [Appendix #(v.a)#sym.dash.em#"figure"~#(v.f)]
  } else {
    text(fill: red)[#("[?appendixfigref: " + key + "?]")]
  }
}

// APPENDIX TABLE — like appendix-figure, but labelled "Appendix N—table M".
// eLife table legends sit ABOVE the table; the caption show rule already does
// this for the `table` kind, and the position is set here for "appendixtab".
//    #appendix-table(key: "rmse", caption: [Full RMSE table.])[ #table(...) ]
#let appendix-table(key: none, caption: [], body) = {
  _appendix-tab-c.step()
  context {
    let a = _appendix-c.get().first()
    let t = _appendix-tab-c.get().first()
    [#metadata((a: a, t: t, key: key))<eat>]
    figure(
      body, caption: caption, kind: "appendixtab", numbering: none,
      supplement: [Appendix #a#sym.dash.em#"table"~#t],
    )
  }
}

#let appendixtableref(key) = context {
  let hits = query(<eat>).filter(m => m.value.at("key", default: none) == key)
  if hits.len() > 0 {
    let v = hits.first().value
    [Appendix #(v.a)#sym.dash.em#"table"~#(v.t)]
  } else {
    text(fill: red)[#("[?appendixtableref: " + key + "?]")]
  }
}


// ---- placeholder box so the template compiles without real image files ------
#let placeholder(h: 5cm, label: "figure") = rect(
  width: 100%, height: h, fill: luma(235), stroke: 0.5pt + luma(180),
)[
  #set align(center + horizon)
  #set text(size: 9pt, fill: luma(120))
  #label
]
