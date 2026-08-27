#import "@preview/modern-se-kul-thesis:0.1.0": template
// Vascularization reconstruction using Contrast-Enhanced Micro CT for high-resolution X-ray based 3D histology
// Clinical tooling for vascularization reconstruction on Contrast-Enhanced Micro CT 3D images.

#show: template.with(
  title: "Advancing image segmentation of vascularization in contrast-enhanced microCT data",
  // subtitle: "With a subtitle",
  academic-year: 2025, // datetime.today().year(),
  authors: ("Nachtrab Sean"),
  promotors: ("Prof. Greet Kerckhofs","Prof. Sébastien Jodogne",),

  assessors: none, //(),

  // supervisors: (
  //   //"supervisor nr 1",
  // ),
  // Hacky: since I cannot load my local package changes, I edited the base package
  // To rename supervisors to readers
  supervisors: (
    "Isabelle Gennart",
    "Juliette Vanderhaeghen",
  ),

  // Customize with your own faculty and degree (should be in dutch if you are doing the dutch master)
  degree: (
    elective: "Medical informatics",
    master: "SINF - Computer science",
    color: (0, 0, 1, 0),
  ),
  language: "en",
  english-master: true,
  font-size: 11pt,
  // set to true to remove extra title-page and have non-changing margins
  electronic-version: true,
  // Hayagriva bibliography is the default one, if you want to use a
  // BibTeX file, pass a .bib file instead (e.g. "works.bib")
  bibliography: bibliography("references.bib", style:"ieee"),
  preface: include "sections/0-preface.typ",
  abstract: include "sections/1-abstract.typ",
  // dutch-summary: include "sections/main-text/dutch-abstract.typ",
  list-of-figures: false,
  list-of-listings: false,
  abbreviations: none, // include "sections/appendices/list-of-abbreviations-and-symbols.typ",
  symbols: none,
  appendices: include "sections/appendices/0-appendix.typ", 
  // Make sure that this is the correct logo for the correct master (en/nl)!
  logo: [#image("../resources/1024px-UCLouvain_logo.png")],//[#text(size: 3em, fill: gradient.linear(..color.map.turbo))[Fix logo]],
)

#include "sections/2-introduction.typ"
#include "sections/3-state-of-the-art.typ"
#include "sections/4-problem-statement.typ"
#include "sections/5-methodology.typ"
#include "sections/6-results.typ"
#include "sections/8-conclusions.typ"

// #include "sections/5-chapter_1.typ"
// #include "sections/6-chapter_2.typ"
// #include "sections/7-chapter_3.typ"
// #include "sections/8-conclusions.typ"

