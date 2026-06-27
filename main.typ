/*
 * VARIABLES
 */
#let base-font-size = 11pt;

#let heading-1-font-size = 2em;
#let heading-1-sup-font-color = black.lighten(20%);
#let heading-1-sup-font-size = 1.5em;
#let heading-1-sup-font-color = rgb("#4281A4").darken(45%).desaturate(10%);

#let heading-2-font-size = 1.3em;
#let heading-2-numbering-font-color = rgb("#4281A4").darken(30%).desaturate(10%);

#let heading-3-font-size = 1.1em;
#let heading-3-numbering-font-color = rgb("#4281A4").darken(30%).desaturate(40%);

// Amount of space before the heading and its
// numbering on the left side in the margins.
#let heading-to-left-numbering-margin = 8pt;

#let page-inner-margin = 2.5cm;
#let page-outer-margin = 2.0cm;
#let page-top-margin = 2.6cm;
#let page-bottom-margin = 2.4cm;


#let show-references-to-workshop = true;
// #let show-references-to-workshop = false;


/*
 * PACKAGE IMPORTS AND FUNCTION SETUP
 */

#import "@preview/fletcher:0.5.8" as fletcher

#import "@preview/cetz:0.5.2" as cetz

#import "@preview/meander:0.4.4" as meander

#import "@preview/hydra:0.6.3": hydra

#import "@preview/shadowed:0.3.0": shadow

#import "@preview/dtree:0.1.1": dtree

#import "@preview/keyle:0.3.0" as keyle
+
#let kbd-theme(symb) = {
  let fill = rgb("#f6f8fa");
  let stroke = rgb("#d0d7de") + 0.6pt;
  let radius = 3pt;
  let inset = (x: 2.5pt, y: 0pt);
  let outset = (x: 0pt, y: 3pt)
  let raise = 0pt;
  let shadow = none;
  let baseline = 0.08em;
  let text-args = (fill: rgb("#1f2328"), font: ("DejaVu Sans Mono"), weight: "medium", size: base-font-size - 1pt);
  let wrap = it => it;

  let body = keyle.style-text(symb, args: text-args, wrap: wrap)
  let face = rect(inset: inset, outset: outset, radius: radius, stroke: stroke, fill: fill, body)
  let r = if type(raise) == length { raise } else { float(raise) * 1pt }

  box(
    baseline: baseline,
    inset: (right: r, bottom: r),
    if r == 0pt or shadow == none {
      face
    } else {
      // Same-size block offset diagonally -> a solid bottom-right drop shadow.
      let lip = rect(inset: inset, radius: radius, fill: shadow, stroke: shadow + 0.6pt, hide(body))
      place(dx: r, dy: r, lip)
      face
    },
  )
};

#let kbd = keyle.config(
  // theme: keyle.themes.deep-blue.with(
  //   wrap: (it) => it,
  // ),
  theme: kbd-theme,
)


#import "@preview/codly:1.3.0": codly, codly-disable, codly-enable, codly-init, no-codly
#import "@preview/codly-languages:0.1.10": codly-languages
#show: codly-init

// Adds support for GDScript when using the `gd` tag.
#set raw(
  syntaxes: "external/gdscript.sublime-syntax",
  tab-size: 4,
)

#let all-languages = codly-languages;
#all-languages.insert(
  "gd",
  (
    name: text(size: 8pt, fill: black.lighten(10%))[GDScript],
    icon: box(
      inset: (
        right: 0.08cm,
      ),
      align(bottom)[
        #image("external/Godot.svg", height: 0.77em)
      ],
    ),
    color: blue,
  ),
)

// Enables codly for code highlighting.
#codly(
  enabled: true,
  languages: all-languages,
)

// #import "@preview/drafting:0.2.2" as drafting
// #drafting.set-page-properties(margin-inside: 1.8cm, margin-outside: 2.2cm)

#import "@preview/frame-it:2.0.0" as frame-it
#import "modules/frame-it/styles/boxy-custom.typ": boxy-custom

// https://typst.app/universe/package/frame-it
// https://github.com/marc-thieme/frame-it

#let _box-warning = frame-it.frame("", rgb("#e9130b"))
#let box-warning(content) = {
  _box-warning(
    numbering: none,
    outlined: false,
    [
      #text(fill: white, weight: "black")[Pozor!]
    ],
    content,
  )
};

#let _box-info = frame-it.frame("", rgb("#2ba2da"))
#let box-info(title: [], content) = {
  _box-info(
    numbering: none,
    outlined: false,
    text(fill: white, weight: "bold", title),
    content,
  )
};

#let _box-repeat = frame-it.frame("", rgb("#607580"))
#let box-repeat(title: [Ponovimo], content) = {
  _box-repeat(
    numbering: none,
    outlined: false,
    text(fill: white, weight: "bold", title),
    content,
  )
};

#let _box-task = frame-it.frame("", rgb("#3bc20a"))
#let box-task(content) = {
  _box-task(
    numbering: none,
    outlined: false,
    text(fill: white, weight: "bold")[Naloga],
    content,
  )
};

#let box-divider() = {
  frame-it.divide()
};

// #show: frame-it.frame-style(frame-it.styles.boxy)
#show: frame-it.frame-style(boxy-custom)


// #show figure.where(kind: "frame"): set block(breakable: true)

#let reference-to-workshop = (content) => {
  if not show-references-to-workshop {
    return;
  }

  content
}

#let todo(content) = {
  underline(text(fill: red, weight: "bold", content))
};


// A shorthand for a centered image figure with an optional caption.
#let screenshot(width: 100%, caption: none, path: str) = {
  figure(
    align(center, image(
      width: width,
      path,
    )),
    caption: caption,
  )
};


// #let inline-button-image(path: str) = {
//   box(
//     height: base-font-size,
//     // stroke: (paint: black.lighten(30%), thickness: 1pt, join: "round"),
//     move(
//       dy: base-font-size * 0.25,
//       shadow(
//         blur: 3pt,
//         radius: 2pt,
//         fill: black.lighten(60%),
//         align(
//           center,
//           box(radius: 2pt, clip: true, image(path)),
//         ),
//       ),
//     ),
//   )
// };

#let button-image(path: str, width: 100%) = {
  align(
    center,
    block(
      // height: base-font-size + 6pt,
      width: width,
      // stroke: (paint: black.lighten(30%), thickness: 1pt, join: "round"),
      move(
        // dy: base-font-size * 0.25,
        shadow(
          blur: 3pt,
          radius: 2pt,
          fill: black.lighten(60%),
          align(
            center,
            box(radius: 2pt, clip: true, image(path)),
          ),
        ),
      ),
    ),
  )
};

#let advanced-topic-heading(content) = {
  text(
    size: base-font-size + 2pt,
    weight: "medium",
    smallcaps(
      all: true,
      [
        #content~#text(fill: red, weight: "bold")[\*]
      ],
    ),
  )
};

// Useful for temporarily disabling the underline rule.
#let no-underline(body) = {
  show underline: it => it.body
  body
}


/*
 * COLORED NODE TYPE TEXT
 */
#let node-type-name = (
  name,
  fill-color: rgb("#e0e0e0"),
  disable-link: false
) => {
  if disable-link == true {
    box(
      text(
        fill: fill-color,
        weight: "medium",
        name
      )
    )
    return;
  }

  let base-prefix = "https://docs.godotengine.org/en/4.7/classes/class_"
  let base-suffix = ".html"

  let target-type-name = std.lower(name)

  let target-link = base-prefix + target-type-name + base-suffix

  box(
    // fill: rgb("#1f1f1f"),
    no-underline(
      link(
        target-link,
        text(
          fill: fill-color,
          weight: "medium",
          name
        )
      )
    )
  )
};

#let node2d-type-name = (name, disable-link: false) => {
  node-type-name(
    name,
    fill-color: rgb("#6393ff").darken(10%),
    disable-link: disable-link
  )
};

#let node3d-type-name = (name, disable-link: false) => {
  node-type-name(
    name,
    fill-color: rgb("#ff5c5c"),
    disable-link: disable-link
  )
};

#let control-type-name = (name, disable-link: false) => {
  node-type-name(
    name,
    fill-color: rgb("#70ff81"),
    disable-link: disable-link
  )
};


/*
 * COLORED DATA TYPE
 */
#let data-type-name = (name) => {
  text(
    fill: rgb("#42ffc2"),
    weight: "medium",
    name
  )
};

#let resource-type-name = (name) => {
  data-type-name(name)
};

#let function-name = (name) => {
  text(
    fill: rgb("#66e5ff"),
    weight: "medium",
    name
  )
};

#let variable-name = (name) => {
  text(
    fill: rgb("#6d3d3d"),
    weight: "medium",
    name
  )
};

#let ui-button = (name) => context {
  // let x-padding = 4pt;
  // let y-padding = 7pt;

  // let base-text = text(
  //   fill: rgb("#cdcdcd"),
  //   weight: "bold",
  //   name
  // )

  // let base-text-measured = measure(base-text);

  // [~]
  // box[
  //   #place(
  //     dx: -(x-padding / 2),
  //     dy: -(y-padding / 2),
  //     top + left,
  //     rect(
  //       width: base-text-measured.width + x-padding,
  //       height: base-text-measured.height + y-padding,
  //       fill: rgb("#393939"),
  //       radius: 2pt,
  //     )
  //   )
  //   #base-text
  // ]
  // [~]
  // 
  
  ["#name"]
};


#let copyright-text = (value) => {
  codly-disable()
  v(8pt)
  block(
    width: 100%,
    stroke: (
      thickness: 0.5pt
    ),
    radius: 3pt,
    outset: (
      x: 6pt,
      y: 8pt
    ),
    value
  )
  v(8pt)
  codly-enable()
};



/*
 * PAGE SETUP AND STYLING
 */

#set text(lang: "sl")

#set page(
  paper: "a4",
  header: context {
    let current-page = here().page()

    // This way we remove the header on the first two pages.
    if current-page <= 2 {
      return
    }

    // align(
    //   right,
    //   text(fill: black.lighten(20%))[
    //     Razvoj iger z igralnim pogonom Godot
    //   ]
    // )
    //

    let hydra-1 = hydra(1, skip-starting: true)
    let hydra-2 = hydra(2, skip-starting: false)

    if (hydra-1 == none) {
      return
    }

    let final-content
    if (hydra-2 != none) {
      final-content = [#hydra-1: #hydra-2]
    } else {
      final-content = [#hydra-1]
    }

    if calc.odd(current-page) {
      align(right, emph(final-content))
    } else {
      align(left, emph(final-content))
    }

    block(
      above: 0.8em,
      line(
        length: 100%,
        stroke: (
          paint: black.lighten(60%),
        ),
      ),
    )
  },
  footer: context {
    let current-page = here().page()

    // This way we remove the footer on the first page.
    if current-page == 1 {
      return
    }

    align(right, [#current-page])
  },
  margin: (
    inside: page-inner-margin,
    outside: page-outer-margin,
    top: page-top-margin,
    bottom: page-bottom-margin,
  ),
  header-ascent: 36%,
  footer-descent: 40%,
)

#set text(font: "EB Garamond", size: base-font-size)
#set par(
  justify: true,
  linebreaks: "optimized",
  // first-line-indent: 1.8em
)

#show link: underline

#set heading(numbering: "1.1.1")

// We define a hacky styling marker here, so if any heading has the
// <_styling-marker__no-styling> label, it appears normally as a heading body
// without any numbering.
//
// This is used only for the outline and the glossary.
#show heading.where(level: 1): c => context {
  if (c.has("label") and c.label == <_styling-marker__no-styling>) {
    c.body
    return
  }

  block(
    above: 0pt,
    below: 2em,
  )[
    #block(above: 0pt, below: 0pt)[
      #text(
        size: heading-1-sup-font-size,
        weight: "bold",
        fill: heading-1-sup-font-color.darken(10%),
      )[Poglavje]
      #text(
        size: heading-1-sup-font-size,
        weight: "extrabold",
        fill: heading-1-sup-font-color,
      )[
        #counter(heading).display()
      ]
    ]

    #block(above: 0.84em, below: 0pt)[
      #text(size: heading-1-font-size, c.body)
    ]

    #let current-page = here().page();

    #{
      if calc.odd(current-page) {
        // This is an odd page, meaning it is printed on
        // the right side, so we'll position the heading line
        // to the left.
        block(
          above: 1em,
          below: 0pt,
        )[
          #line(
            stroke: (
              paint: rgb("#2c6280").lighten(10%),
              thickness: 2.4pt,
              cap: "butt",
            ),
            start: (-page-inner-margin, 0pt),
            length: 100% - 0.5pt + page-inner-margin,
          )
        ]
      } else {
        // This is an even page, meaning it is printed on
        // the left side, so we'll position the heading line
        // to the right.
        block(
          above: 1em,
          below: 0pt,
        )[
          #line(
            stroke: (
              paint: rgb("#2c6280").lighten(10%),
              thickness: 2.4pt,
              cap: "butt",
            ),
            // end: (100% - 2.2cm, 0pt),
            start: (0.5pt, 0%),
            length: 100% - 0.5pt + page-inner-margin,
          )
        ]
      }
    }
  ]
}


#show heading.where(level: 2): c => context {
  let sup-heading = [
    #text(
      size: heading-2-font-size,
      weight: "extrabold",
      fill: heading-2-numbering-font-color,
    )[
      #counter(heading).display()
    ]
  ]

  let sup-heading-measurement = measure(sup-heading)

  block(
    above: 1.8em,
    below: 1em,
  )[
    #place(
      dx: -sup-heading-measurement.width - heading-to-left-numbering-margin,
      block(above: 0pt, below: 0pt, sup-heading),
    )

    #block(above: 0.5em, below: 0pt)[
      #text(size: heading-2-font-size, c.body)
    ]
  ]
}


#show heading.where(level: 3): c => {
  let margin-numbering = [
    #text(
      size: heading-3-font-size,
      weight: "extrabold",
      fill: heading-3-numbering-font-color,
    )[
      #counter(heading).display()
    ]
  ]

  let margin-numbering-measurement = measure(margin-numbering)

  block(
    above: 1.6em,
    below: 1em,
  )[
    #place(
      dx: -margin-numbering-measurement.width - heading-to-left-numbering-margin,
      block(above: 0pt, below: 0pt, margin-numbering),
    )

    #block(
      above: 0.55em,
      below: 0pt,
      text(size: heading-3-font-size, c.body),
    )
  ]
}


// #show raw: text(font: "Cascadia Code")


/*
 * BOOK CONTENT
 */

// Prva stran

#pdf.attach(
  "data/dinozaver_paket-sredstev_2026-06-27_16-55.zip",
  relationship: "supplement",
  mime-type: "application/zip",
  description: "Paket sredstev, potreben za razvoj igre z dinozavrom skozi knjigo."
)

#align(center + horizon)[
  #v(7cm)
  
  #reference-to-workshop[
    #block(
      above: 0em,
      below: 20pt,
      text(size: 16pt)[
        Poletna šola FRI 2026
      ],
    )
  ]

  #block(
    outset: (
      x: page-inner-margin + 4cm,
      // y: 20pt,
    ),
    inset: (
      y: 20pt
    ),
    // fill: rgb("#b3e3f3"),
    fill: gradient.linear(
      angle: 27deg + 180deg,
      ..(
        rgb("#b3e1f3"),
        rgb("#a9ecc5")
      ),
    )
  )[
    #block(
      above: 0em,
      below: 2em,
      text(size: 28pt, weight: "bold")[
        Razvoj iger z igralnim pogonom Godot
      ],
    )

    #block(
      above: 0em,
      below: 0em,
      text(size: 22pt, smallcaps(all: true)[knjiga in učna gradiva]),
    )
  ]

  #v(0.85fr)

  #image(
    "assets/game-assets/dino-sprite.png",
    scaling: "pixelated",
  )

  #v(1fr)

  #block(
    inset: (
      x: 1.8cm,
    ),
  )[
    *Želiš spoznati ustvarjalni in razvijalni proces videoiger?*

    #align(left)[
      V tej knjigi bomo spoznali osnove ustvarjanja iger v odprtokodnem igralskem pogonu Godot, od začetnih korakov v njegovem urejevalniku pa vse do prvih grafičnih elementov, skriptiranja v programskem jeziku GDScript, interaktivnosti, fizikalnih teles, animacij in ustvarjanja uporabniškega vmesnika. Skozi učbenik bomo ob spoznavanju novih konceptov gradili našo majhno igro z dinozavrom in novo znanje vgrajevali vanjo.
    ]
  ]

  #v(5.5em)

  #text()[Andrej Matos in Simon Goričar \ _junij 2026_]
]

#pagebreak(weak: true)

#align(top, block[
  #set par(spacing: base-font-size * 2)

  RAZVOJ IGER Z IGRALNIM POGONOM GODOT

  #set par(leading: base-font-size - 4pt, spacing: base-font-size + 2pt)

  Avtorja: Andrej Matos in Simon Goričar

  Leto izida: 2026 \
  Zadnja sprememba: 27. junij 2026#footnote(numbering: "*")[Zadnja stabilna različica pogona Godot je, za časa pisanja, Godot 4.7, ki je bil izdan 18. junija 2026. Avtorja priporočata, da bralci (še posebej začetniki) uporabite to različico pogona, saj zaslonski posnetki ustrezajo Godot 4.7.] \

  #v(1em)

  Avtorja se zahvaljujeta tudi mentorjema Cirilu Bohaku in Gorazdu Gorupu v Laboratoriju za računalniško grafiko in multimedije na Fakulteti za računalništvo in informatiko v Ljubljani za svetovanje pri izdelavi knjige, izkazano zaupanje in ponujeno možnost.
])

#align(bottom, block[
  #align(
    center,
    stack(
      dir: ltr,
      align(
        center,
        link(
          "https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en", 
          image(
            "assets/licence/by-nc-sa.eu.svg"
          )
        )
      ),
      align(right + horizon, block(
        inset: (left: 16pt)
      )[
        Vsebina knjige je ponujena pod licenco *#link("https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en", "Creative Commons BY-NC-SA 4.0")*#footnote(numbering: "*")[
          Določena vizualna vsebina, ki se prikaže v nekaterih posnetkih zaslona v knjigi in ki je na voljo v paketu sredstev ob tej knjigi, je na voljo pod licenco #link("https://spdx.org/licenses/BSD-3-Clause.html", "BSD-3-Clause") iz projekta #link("https://github.com/chromium/chromium", "Chromium").
        ]. \ Iz te licence je izvzeta koda, ki je namesto tega ponujena pod licenco *#link("https://spdx.org/licenses/MIT.html", "MIT")*.
      ])
    )
  )

  V praktičnem smislu to pomeni, da lahko to knjigo prosto delite naprej in jo celo spreminjate, pri čemer pa morate spoštovati pogoje, ki jih postavlja ta licenca. Med drugim: knjiga se ne sme uporabiti za komercialne namene, kopije knjige morajo obdržati imena avtorjev (in kopijo licence), če pa material spreminjate, ste primorani tudi novo različico knjige ponuditi pod isto licenco kot midva#footnote(numbering: "*")[Take licence predstavljajo nabor nepreklicnih pravic, ki jih avtorji določenega dela lahko dodelijo svojemu delu. Ravno v tej nepreklicnosti, ki za uporabnike veljajo le ob sprejemu licenčnih pogojev, je moč odprtokodnih licenc. Najin namen s to licenco je omogočiti prost dostop in redistribucijo te knjige in vseh njenih prihodnih različic, tudi če se zgodi, da midva v izboljšavah knjige nisva več udeležena!]. Kodo pa lahko uporabljate še bolj prosto kot to, saj je edina obveza to, da obdržite kopijo besedila licence. To pomenu, da kodo lahko uporabite tudi v komercialne namene in lahko svoje prihodnje projekte, ki bi morebiti temeljili na tej kodi, licencirate (ali ne) popolnoma poljubno.

  Podrobnosti aktivnih licenc tega materiala lahko najdete na koncu knjige v #ref(<licences>, supplement: [poglavju]), nekaj malega o odprtokodnih licencah na splošno pa bomo spregovorili tudi v #ref(<game-engine-history>, supplement: [poglavju]).
])


#pagebreak(weak: true)

#block(
  below: 3em,
)[
  #heading(
    depth: 1,
    numbering: none,
    outlined: false,
    text(size: heading-1-font-size)[Vsebina],
  ) <_styling-marker__no-styling>
]

#show outline.entry.where(level: 1): set block(above: 1.5em)
#show outline.entry.where(level: 1): set text(weight: "extrabold", fill: heading-1-sup-font-color.saturate(50%), size: base-font-size + 2pt)

#outline(depth: 4, title: none)




#pagebreak(weak: true)

#let translation-table(translation-pairs) = {
  table(
    columns: (auto, auto),
    inset: (
      x: 8pt,
      y: 6pt,
    ),
    table.header([*Angleški pojem*], [*Slovenski pojem*]),
    ..(translation-pairs.flatten()),
  )
}

#let translation-entry-context(ctx) = {
  text(size: base-font-size - 2pt, style: "italic", ctx)
};


// #show table.cell.where(x: 3): it => text(size: base-font-size - 4pt, it)


#block(
  below: 2em,
)[
  #heading(
    depth: 1,
    numbering: none,
    outlined: false,
    text(size: heading-1-font-size)[Slovarček],
  ) <_styling-marker__no-styling>
]

#align(horizon + center, translation-table(
  (
    ("asset", "sredstvo"),
    ("collider", "trkalnik"),
    ("area", "površina"),
    ("node", "vozlišče"),
    ("root", "koren"),
    ("child", "otrok"),
    ("sibling", "sorojenec"),
    ("parent", "starš"),
    ("grandparent", "stari starš"),
    ([
      inspector \
      #translation-entry-context[(Godot editor section)]
    ], [
      podrobnosti \
      #translation-entry-context[(podokno urejevalnika Godot)]
    ]),
    ("instance", "primerek"),
    ("scene", "prizor"),
    ("sprite", "sličica"),
    ("spritesheet", "plahta sličic"),
    ("script", "skripta"),
    ("template", "predloga"),
    ("folder", "mapa"),
    ("level", "nivo"),
    ("texture filtering", "filtriranje tekstur"),
    ([
      linear filtering \
      #translation-entry-context[(texture filtering)]
    ], [
      linearno filtriranje \
      #translation-entry-context[(filtriranje tekstur)]
    ]),
    ([
      nearest neighbour filtering \
      #translation-entry-context[(texture filtering)]
    ], [
      filtriranje z najbližjim sosedom \
      #translation-entry-context[(filtriranje tekstur)]
    ]),
    ([
      container \
      #translation-entry-context[(user interface)]
    ], [
      zaboj \
      #translation-entry-context[(uporabniški vmesnik)]
    ]),
    ("theme", "motiv"),
    ("theme override", "preglasovanje motiva"),
  ),
))

// Začetek skripte

#pagebreak(weak: true)
= Uvod

V tej knjigi bomo spoznali osnove ustvarjanja in razvoja iger v igralnem pogonu Godot. Začeli bomo z namestitvijo pogona Godot, osnovami uporabe urejevalnika in prvimi koraki pisanja kode v jeziku GDScript. Obenem bomo začeli razvijati lastno majhno igro s skakajočim dinozavrom in kaktusi ter ob tem spoznali še druge teme, kot so premikanje, fizika, animacije, osnove proceduralne generacije in izdelave uporabniškega vmesnika ter še veliko drugih tem.

Knjiga razen osnov uporabe računalnika ne zahteva nobenega predznanja in je namenjena popolnim začetnikom, ki še nikoli niso razvili svoje igre, pa tudi tistim, ki se sploh še niso spoznali s programiranjem.

Cilj knjige je vzpodbuditi zanimanje in nuditi osnovno podlago za razvoj iger, katero lahko bralci in bralke nato nadgrajujejo sami. Razvoj iger je izjemno veliko področje, okoli katerega so ponekod razviti tudi večletni študijski programi. Vsebina te knjige obsega le površinska področja, s katerimi se je morda smiselno spoznati najprej, vsekakor pa to ni vseobsegajoč priročnik za razvoj iger.

Preden se zakopljemo v samo uporabo igralnega pogona in razvoja iger z njim, je smiselno povedati še nekaj malega o tem, zakaj smo si izbrali prav Godot.

== Kratka zgodovina pogonov <game-engine-history>

Skozi zgodovino razvoja videoiger so ljudje uporabljali različne igralne pogone. Sprva sta bila pogon in igra precej bolj združen pojem kot danes, saj je bila strojna oprema mnogo bolj omejena, področje pa manj razvito. Skozi leta so zato številni izdelovalci iger razvijali lastne pogone, ki so bili večinoma namenjeni interni rabi in do njih splošna javnost ni imela dostopa.

Danes se za „resne igre“ večinoma uporabljajo igralni pogoni, ki so dostopni vsem. Za časa pisanja sta na sceni ena izmed največjih igralcev Unreal Engine, ki ga razvija podjetje Epic Games, in Unity, ki ga razvija podjetje Unity Technologies. 
Oba pogona sta stabilna, testirana, zelo zmogljiva, vendar tudi *zaprta* in *plačljiva* (če že ne skozi nakup ali naročnino pa skozi pristojbine).

=== Kratka zgodovina pogona Godot

Pogon Godot sta okoli leta 2001 začela razvijati Juan Linietsky in Ariel Manzur. Sprva je bil uporabljen za interne projekte pod različnimi drugimi imeni in je bil, kot skoraj vsi pogoni tega časa, zaprtokoden.

Leta 2014 pa sta se odločila, da pogon odpreta navzven, in ga objavila pod odprtokodno licenco MIT. Od takrat ga, kot mnoge druge odprtokodne projekte, razvija globalna skupnost prostovoljcev. Ta je v primeru Godota od leta 2023 pod okriljem neprofitne organizacije Godot Foundation.

#box-info(title: [Kaj je licenca MIT?])[
  MIT je licenca, namenjena programski kodi in dokumentaciji, pri čemer ta licenca dovoljuje, da se programsko kodo distribuira naprej, jo spreminja, prilagaja, objavlja, licencira pod drugimi pogoji, prodaja itd. Gre za eno izmed glavnih licenc odprtokodnega sveta poleg licenc, kot so GNU GPLv3, GNU AGPLv3, Mozilla Public License 2.0, licence CC idr.

  Več o odprtokodnih licencah si lahko preberete na \ #link("https://choosealicense.com"), #link("https://opensource.org") in #link("https://creativecommons.org").
]

#box-info(title: [Kaj pomeni, da je Godot odprtokoden?])[
  To, da je nek kos programske opreme odprtokoden, poglavitno pomeni dvoje.

  Prvič, Godot je povsem brezplačen. Nima mesečnih naročnin (kot pogon Unity) ali provizij od zaslužkov (kot ga imata Unity in Unreal Engine) in se preživlja od prostovoljnih donacij in prostovoljnega dela. V teoriji sta plačljiva programska oprema in odprtokodnost združljivi, a kljub vsemu je to pogosto težko doseči. Ponavadi razvijalci v primeru odprtokodnih programov zaračunajo za podporo ali naprednejše funkcije (kot na primer pgModeler in GitLab CE).

  Drugič, vsa izvorna koda je javno dostopna in jo lahko prilagajamo, kot se nam zahoče, a seveda v mejah licence, pod katero je koda ponujena. Za dostop do izvorne kode zaprtega pogona, kot je Unity, so potrebna posebna dovoljenja s strani podjetja Unity Technologies.
]

== Zmogljivosti pogona Godot

Čeprav sta bila kot industrijska standarda zgoraj omenjena Unreal Engine in Unity, ima Godot tudi v sami razvijalski industriji vedno večji glas in delež#footnote[
  Če gledamo trg iger, narejenih za namizne igre (angl. _PC gaming_), je Godot za časa pisanje te knjige na podlagi podatkov projekta SteamDB na platformi Steam četrti najbolj uporabljen pogon po številu izdanih iger ($4.340$). Nad njim stojijo trenutno Unity ($64.319$ iger), Unreal Engine ($20.101$ iger), GameMaker ($6.401$ iger). To pomeni, da je Godot na platformi Steam trenutno najbolj uporabljen odprtokodni pogon po številu iger. Obenem pa drži tudi, da je Godotova povprečna desetletna rast znatno večja od ostalih večjih pogonov ($78.83%$ proti $47.37%$, $28.12%$ in $26.22%$). Vir podatkov: #link("https://steamdb.info/tech/", "SteamDB (tech)") in #link("https://steamdb.info/stats/releases/?tech=Engine.Godot", "SteamDB (releases)").
  #pdf.attach(
    "data/steamdb_top-four-game-engine-growth_2026-06-25.xlsx",
    relationship: "supplement",
    mime-type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    description: "Vir podatkov, ki prikazuje letno rast največjih štirih igralnih pogonov na platformi Steam od leta 2006 do vključno leta 2025."
  )
].

Godot nam omogoča ustvarjanje 2D in 3D iger ter iger v razširjeni resničnosti za vse večje platforme, kot so Windows, Linux, maxOS, Android, iOS in splet, ter z nekaj dodanega truda tudi za konzole, kot so PlayStation, Xbox in Nintendo Switch.

Podpira programiranje v lastnem namenskem jeziku GDScript, v splošnem jeziku C\# (znotraj ogrodja .NET) in v jeziku, v katerem je tudi napisan -- v C++. Neuradno Godot skozi sistem, imenovan GDExtension, podpira tudi mnoge druge programske jezike, kot so JavaScript, Python, Rust in še mnogi drugi.

Na spletu lahko na naslovu #link("https://store.godotengine.org") najdete knjižnico raznoraznih sredstev. Od modelov, tekstur in plaht sličic (angl. _spritesheets_) do že narejenih kosov funkcionalnosti in skript. Ta knjižnica je tudi vgrajena v Godot sam in je lahko dostopna v samem urejevalniku.

Pogon Godot se razvija in postaja čedalje zmogljivejši, kar dokazuje že občudovanja vredna knjižnica iger, ki ga uporabljajo. Med njimi sicer ne boste našli visokoproračunskih („AAA“) iger, je pa možno, da prepoznate naslove raznih neodvisnih uspešnic, kot so Slay the Spire 2, Buckshot Roulette in KinitoPET.

#screenshot(
  path: "assets/history/made-with-godot.png",
  width: 80%,
  caption: [Nekaj iger, ki za pogon uporabljajo Godot.],
)

== Namestitev

Za namestitev pogona se odpravimo na naslov #link("https://godotengine.org/download"). Spletna stran nam ponuja prenos dveh različic pogona: eno z in eno brez podpore za C\# .NET. Tekom poletne šole se bomo najbolj osredotočili na razvoj 2D igre v jeziku GDScript, tako da pogona s podporo za C\# .NET ne potrebujemo. Kliknemo torej na zgornji moder gumb "Godot Engine 4.7" (oziroma višjo verzijo, če je v trenutku branja že na voljo).

#screenshot(
  path: "assets/install/install-page.png",
  width: 80%,
  caption: [Spletna stran za namestitev pogona.],
)

Na naš računalnik se bo prenesla datoteka s končnico `.zip`, ki jo razširimo. Godot nima čarovnika za namestitev, kot ste ga morda vajeni, če ste kdaj na svoj računalnik nameščali kakšne druge programe. Namesto tega Godot namestimo sami, tako da vsebino datoteke ZIP prekopiramo na poljubno mesto na računalniku in poženemo zagonsko datoteko s končnico `.exe`. Godot je tako pripravljen na uporabo.

#reference-to-workshop(
  box-warning[
    #text(size: base-font-size + 4pt, align(center)[*Shranjujte pogon Godot in svoje projekte na disk D!*])
    *Ker delamo na fakultetnih računalnikih, na katerih se disk C ponastavi ob vsakem ponovnem zagonu, nekatere mape pa celo po vsaki prijavi, je IZJEMNO POMEMBNO, da svoj projekt shranite na disk D!*

    *To velja tudi za pogon Godot, ki smo ga pravkar namestili.*

    Če temu dokumentu sledite v domačem okolju, lahko to opozorilo prezrete.
  ]
)

#box-info(title: "Samozadostni način", [
  Godot je že sam po sebi precej samozadosten in premičen. Nima nobenih posebnih namestitvenih procesov, zato lahko le prenesemo zagonsko datoteko in jo zaženemo.

  Vseeno pa nastavitve pogona (kar ni isto kot nastavitve projekta) shranjuje v uporabniško mapo. To ponavadi ni težava in je celo zaželeno, saj na tak način nastavitve urejevalnika obdržimo ob posodabljanju pogona Godot. Če delate v domačem okolju, je to priporočen način dela in lahko naslednji odstavek preskočite.

  Ker pa delamo na fakultetnih računalnikih in želimo vse imeti na prej omenjenem disku D, priporočamo, da v mapi, v katero ste premaknili pogonsko datoteko Godot (`Godot_v4.7.0-stable_win64.exe`), naredite še eno datoteko z imenom `_sc_` ali `._sc_`. V mapo, kjer je Godot shranjen, bo pogon sedaj začel shranjevati vse nastavitve pogona in ostale vsebine, ki bi jih drugače shranil v globalno uporabniško mapo. Le-ta ni na disku D in jo boste ob vsakem ponovnem zagonu računalnika izgubili.

  #screenshot(
    path: "assets/install/godot-self-contained-directory-screenshot.png",
    width: 86%,
    caption: [Izgled mape s pogonom Godot po uporabi samozadostnega načina.],
  )
])

In to je vse, Godot je nameščen in pripravljen za uporabo. Čas je, da začnemo z izdelavo svoje prve igre.

// #v(1fr)

#v(2 * base-font-size)

*V naslednjih poglavjih sledi uvod v koncepte in funkcionalnosti, katerih razumevanje je potrebno za razvoj preprostih iger. Obenem bomo pri spoznavanju pogona Godot vzporedno napredovali tudi z razvojem majhne igre „Dinozaver“, skozi katero bomo spoznane koncepte preizkusili.*

#pagebreak(weak: true)

// = Dinozaver


#pagebreak(weak: true)
= Osnove uporabniškega vmesnika

Ko poženemo urejevalnik Godot, se najprej pokaže glavni meni, s katerim lahko ustvarjamo in odpiramo projekte ter spreminjamo nastavitve urejevalnika:

#screenshot(
  path: "assets/ui-basics/godot-ui_main-menu.png",
  width: 76%,
  caption: [Glavni meni urejevalnika Godot.],
)


Ker želimo ustvariti nov projekt, kliknemo na gumb #ui-button("Create") levo zgoraj, nato pa storimo sledeče (glej #ref(<new-project-menu>, supplement: [sliko])):
- vnesemo ime našega projekta, naj bo to kar "Dinozaver";
- na disku D ustvarimo ali izberemo mapo, kamor bomo shranili naš projekt;
- pri "Version Control Metadata" v spustnem meniju izberemo "None";
- nato kliknimo na gumb "Create".


#box-warning[
  #text(size: base-font-size + 4pt, align(center)[Še enkrat: *shranjujte svoje projekte na disk D!*])
  *Ker delamo na fakultetnih računalnikih, na katerih se disk C ponastavi ob vsakem ponovnem zagonu, nekatere mape pa celo po vsaki prijavi, je IZJEMNO POMEMBNO, da svoj projekt shranite na disk D!*
  // #box-divider()

  *Če tega nasveta ne boste upoštevali, boste izgubili svojo igro!*

  Če temu dokumentu sledite v domačem okolju, lahko to opozorilo prezrete.
]

#screenshot(
  path: "assets/ui-basics/godot-ui_create-new-project.png",
  width: 46%,
  caption: [Meni za ustvarjanje novega projekta v Godotu.],
) <new-project-menu>


== Urejevalnik <urejevalnik>

Po stvaritvi novega projekta bomo pristali v urejevalniku Godot. To je glavni del programa, v katerem bomo razvijali svojo igro.
Urejevalnik nam bo pomagal pri ustvarjanju in urejanju prizorov, programiranju in povezovanju manjših delov naše igre v večje prizore ter pri testiranju naše igre.


Urejevalnik se nam bo privzeto odprl v okolju 3D, ki je eno glavnih okolij.
Kmalu bomo preskočili na druga okolja, ki bodo za našo delavnico precej bolj pomembna, ampak pred tem si na #ref(<ui-basics-annotated-sections>, supplement: [sliki]) na hitro oglejmo, iz katerih delov je sestavljen urejevalnik pogona Godot.

#screenshot(
  path: "assets/ui-basics/godot-ui_3d-section_bare-annotated.png",
  width: 100%,
  caption: [Označeni deli urejevalnika Godot v začetni postavitvi.],
) <ui-basics-annotated-sections>

Urejevalnik je sestavljen iz ločenih podoken, označenih z barvnimi okvirčki na #ref(<ui-basics-annotated-sections>, supplement: [sliki]):
- *Orodna vrstica urejevalnika* (označena z belo, zgoraj levo) nam omogoča urejanje nastavitev in izvažanje projekta, urejanje nastavitev urejevalnika, dostop do dokumentacije in še marsikaj.
- *Izbirni meni za delovno okolje* (označen z oranžno, zgoraj na sredini) nam omogoča hiter preklop med delovnimi okolji, kot je na primer urejevalnik 2D prizorov, urejevalnik skript itd.
- *Orodna vrstica igre* (označena z belo, zgoraj desno) nam omogoča zagon naše igre (prvi gumb), premor ali ugašanje naše igre (drugi in tretji gumb) ali pa zagon trenutno odprtega prizora (peti gumb).
- *Struktura prizora* (označena z vijolično, levo) nam omogoča ustvarjanje novega prizora ali urejanje trenutnega. Kot bomo videli čez nekaj poglavij, bomo v tem podoknu dodajali nove elemente v prizor, preurejali drevesno strukturo našega prizora itd.
- *Raziskovalec datotek* (označen s svetlomodro, spodaj levo) nam omogoča dostop do mape na disku, kjer je shranjen naš projekt. Kot v navadnih raziskovalcih datotek, ki jih srečamo v sistemih Windows, MacOS ali Linux, gre za preprost brskalnik po drevesni strukturi datotek in map. Mapa `res://` predstavlja koren našega projekta, t.j. vrhnjo mapo, v kateri se nahaja naš projekt.
- *Urejevalnik podrobnosti* (označen z roza, desno) nam v povezavi z izbiro v drevesnem pogledu omogoča, da izbranemu objektu v prizoru spreminjamo poljubne lastnosti (npr. položaj, barvo ali teksturo). Ker nimamo odprtega nobenega prizora, je ta del trenutno prazen in se bomo nanj vrnili pozneje.
- *Plošča delovnega okolja* (označena z zeleno, na sredini), kar je v našem primeru trenutno urejevalnik 3D prizora, je najpomembnejši del urejevalnika, saj bomo v njem videli in urejali prizore, ki bodo tvorili našo igro. Trenutno res vidimo urejevalnik za tridimenzionalni prostor, a bomo kmalu ta pogled zamenjali (in to počeli precej pogosto). To sredinsko podokno se bo pravzaprav spreminjalo glede na izbrano delovno okolje nad njim (kjer je trenutno izbrano okolje 3D, v modrem). Več o tem v #ref(<delovna-okolja>, supplement: [poglavju]).

Skozi razvoj naše igre si bomo ogledali in uporabili vsa od naštetih podoken, pa tudi še kakšnega, ki smo ga tukaj izpustili. Najprej si podrobneje oglejmo *izbirni meni za okolje*, ki ga bomo uporabljali zelo pogosto.

== Delovna okolja <delovna-okolja>

Godot je sestavljen iz petih glavnih delovnih okolij, do katerih lahko dostopamo s klikom na želeno okolje v izbirnem meniju za delovna okolja (obrobljeno z oranžno na #ref(<ui-basics-annotated-sections>, supplement: [sliki]) in vidno na #ref(<delovna-okolja-toolbar>, supplement: [sliki])).
Plošča z vsebino aktivnega delovnega okolja se bo pojavila na središčni površini (označeni z zeleno na #ref(<ui-basics-annotated-sections>, supplement: [sliki])).

#screenshot(
  path: "assets/ui-basics/godot-ui_mode-selection.png",
  width: 65%,
  caption: [Orodna vrstica na vrhu urejevalnika, kjer izberemo delovno okolje.],
) <delovna-okolja-toolbar>

Kot vidimo na #ref(<delovna-okolja-toolbar>, supplement: [sliki]), imamo na voljo:
- *2D*, t.j. urejevalnik dvodimenzionalnih prizorov,
- *3D*, t.j. urejevalnik tridimenzionalnih prizorov,
- *Script*, t.j. urejevalnik skript, napisanih v jeziku GDScript in
- *Game*, t.j. interaktivni predogled naše igre.


#box-info(title: [Kaj pa "Asset Store"?])[
  Poleg omenjenih štirih ste zagotovo opazili še petega, *Asset Store*. To je zavihek, kjer lahko dostopamo do Godotove brezplačne oblačne storitve, preko katere lahko prenesemo različne pakete sredstev (angl. _asset packs_), senčilnikov (angl. _shaders_), razširitev (angl. _extensions_), ikon, skript, zvokov in drugih vsebin, s katerimi si lahko pomagamo pri razvoju iger.

  Zaenkrat se tega zavihka ne bomo dotikali, vsaj ne, dokler se ne razdelimo v skupine in začnemo sestavljati lastno igro. Takrat boste izvedli tudi več o paketih sredstev oziroma delovnih materialih.
]


=== Okolje "Game" <env-game>
Čeprav ob prvem odpiranju Godota zagledamo okolje 3D, ga zaenkrat zanemarimo in si najprej oglejmo zavihek *Game*. V tem pogledu bomo našo igro poganjali in igrali.

#screenshot(
  path: "assets/ui-basics/godot-ui_game-section.png",
  width: 100%,
  caption: [Okolje "Game" v urejevalniku Godot.],
)

Tik pod vrstico, kjer izbiramo okolje, sedaj na mestu, kjer je bil prej urejevalnik 3D prizora (na #ref(<ui-basics-annotated-sections>, supplement: [sliki]) označen z zeleno), zagledamo ploščo, ki je trenutno večinoma prazna, a ima na vrhu lastno orodno vrstico:

#screenshot(
  path: "assets/ui-basics/godot-ui_game-section_game-toolbar-focused.png",
  width: 75%,
  caption: [Orodna vrstica okolja "Game".],
) <ui-game-tools>

// TODO (Gorazd): Razmislita o posebnem oblikovanju za imena gumbov in nastavitev. Skripta za Blender jih prikazuje kot nekakšne gumbe. Trenutno sem opazil, da so ponekod zapisana v oklepajih, v primeru Embedding Options, ponekod pa v navednicah: "Make Game Workspace Floating on Next Play". Fino bi bilo poenotiti, magar v nekem posebnem slogu.

Da bo proces testiranja naše igre potekal brezhibno, pred nadaljevanjem spremenimo eno nastavitev: kliknimo na zadnji gumb v orodni vrstici (na #ref(<ui-game-tools>, supplement: [sliki]) obrobljen z oranžno barvo). Odprl se bo spustni meni z nastavitvami vgrajevanja (angl. _Embedding Options_), kjer *onemogočimo* nastavitev #ui-button("Make Game Workspace Floating on Next Play"), kar pomeni, da bo Godot ob zagonu igre njen interaktivni predogled vgradil v obstoječe okno:

#screenshot(
  path: "assets/ui-basics/godot-ui_game-section_floating-dropdown.png",
  width: 60%,
  caption: [Spustni meni "Game Window Options" na desni strani okolja "Game".],
)

#box-info(title: [Zakaj?])[
  Ta sprememba v nastavitvah bo povzročila, da se bo ob testnem zagonu igre le-ta pokazala v _tem delovnem okolju_ (torej v okolju "Game"), namesto da bi se pojavilo novo samostojno okno poleg urejevalnika.

  Za manj zmede zato priporočamo, da zgornjo nastavitev spremenite tako, kot smo jo mi, in svojo igro raje testirate znotraj glavnega urejevalnika Godot. Če vam ta način dela ne bo ustrezal, lahko to nastavitev kadarkoli spet omogočite. V tem primeru se vam bo ob zagonu igre odprlo samostojno okno.
]

=== Okolje "2D" <okolje-2d>
Kliknimo na prvi zavihek -- "2D". Zagledali bomo dvodimenzionalno površino, na kateri lahko ustvarimo svojo igro. Pred seboj v sredinskem delu urejevalnika vidimo polje, na katerem bo stala naša igra.

Igre v tem načinu so postavljene na *dve osi: na $X$ in $Y$*. Os $X$ teče od leve proti desni (označena s tanko rdečo črto), os $Y$ pa od zgoraj navzdol (označena s tanko zeleno črto). Kjer se osi sekata v urejevalniku, stoji koordinatno izhodišče -- točka $(0, 0)$ (t.j. točka, kjer je $X = 0$ in $Y = 0$).

Vse elemente, ki jih bomo postavljali v našo igro, bomo opisali z določeno lokacijo v tem dvodimenzionalnem svetu. Večja kot je vrednost na osi $X$, bolj desno je naš element. Večja kot je vrednost na osi $Y$, nižje je naš element. Na #ref(<2d-editor-default>, supplement: [sliki]) vidimo, da je koordinatno izhodišče levo zgoraj, kjer se črti sekata.

Ko poženemo našo igro brez posebnih nastavitev kamere, velja, da bo koordinatno izhodišče (lokacija $(0, 0)$) postavljena v levi zgornji kot naše igre. Obenem lahko na #ref(<2d-editor-default>, supplement: [sliki]) s tanko modro črto vidimo oznako velikosti našega pogleda. Vse kar je v tem okvirju, bo privzeto videl igralec ob zagonu igre. To je seveda mogoče spremeniti z uporabo nastavitev kamere.

Ker bomo na delavnicah ustvarjali igre v 2D, bomo v tem okolju preživeli precej časa!



#screenshot(
  path: "assets/ui-basics/godot-ui_2d-section_bare.png",
  width: 80%,
  caption: [Okolje "2D" v urejevalniku Godot.],
) <2d-editor-default>

#box-info(title: [Razlike med 2D in 3D])[
  V nasprotju z igrami v treh dimenzijah se igre v 2D omejijo samo na ravno ploskev. To pa ne pomeni, da ne moremo pričarati vtisa globine! Oddaljenost od gledalca lahko namreč še vedno poustvarimo s spreminjanjem velikosti (angl. _scale_) objektov v prizoru in drugimi vizualnimi učinki, na primer s sencami.

  Obenem naj vas omejitev na dve dimenziji ne odvrne od ustvarjanja v tem načinu! Z izjemo določene matematike in določenih novih pristopov, ki jih je fino obvladati za razvoj v 3D, ustvarjanje igre v 2D ni v splošnem zares nič drugačno kot v 3D. Obenem je popolnoma nesmiselno 3D igre obravnavati, kot boljše ali bolj napredne izključno zaradi dodatne dimenzije. Oba načina imata svoje prednosti in slabosti.

  *Kljub temu za to enotedensko poletno šolo zelo močno svetujemo, da ustvarjate igro v 2D!* Če želite res ustvarjati igro v 3D, se prej pogovorite z mentorjema.
]


=== Okolje "3D"
Kliknimo na drugi zavihek -- "3D". Tako kot ob zagonu urejevalnika bomo sedaj spet zagledali tridimenzionalno površino. Ta je podobna kot pri 2D, le da ima še tretjo globinsko dimenzijo. Koordinate v 3D svetu so sestavljene iz treh komponent, ki označujejo položaj vzdolž *osi $X$, $Y$ in $Z$*.

Ker bo naša igra izdelana v načinu 2D, se v koncepte 3D iger ne bomo poglabljali.

#screenshot(
  path: "assets/ui-basics/godot-ui_3d-section_bare.png",
  width: 90%,
  caption: [Okolje "3D" v urejevalniku Godot.],
)


=== Okolje "Script"

Kliknimo še na tretji zavihek -- "Script". V tem načinu bomo pozneje pisali skripte (t.j. kodo) v jeziku GDScript. Te skripte bomo prilepili na določene objekte v prizorih, na primer na naš lik dinozavra, in s skripto dosegli, da bo dinozaver skočil ob pritisku na določen gumb. Rečeno drugače: s skriptami bomo dosegli interaktivnost naše igre.

#screenshot(
  path: "assets/ui-basics/godot-ui_script_bare.png",
  width: 90%,
  caption: [Okolje "Script" v urejevalniku Godot.],
)



== Raziskovalec datotek

Raziskovalec datotek nam omogoča dostop do mape na disku, kjer imamo shranjen naš projekt, in urejanje datotek v tej mapi. Koncept je skoraj identičen klasičnim raziskovalcem datotek, ki jih srečamo na sistemih Windows, MacOS ali Linux.


#box-info(title: [Kaj je `res://`?])[
  Mapa `res://` predstavlja koren našega projekta. Torej, če smo naš projekt shranili na primer v mapo `D:/projekti/dinozaver`, potem koren našega raziskovalca datotek, torej ta pot `res://`, kaže v to mapo.
  Gre samo za "virtualno" mapo! Ta mapa ne obstaja zares, prav tako pa datotek ali podmap ne moremo ustvarjati _poleg_ te mape, le _v njej!_

  Razlog za to funkcionalnost je, da se vnaprej izognemo problemom pri premikanju našega projekta. Vse poti znotraj naše igre, na primer reference na zvočne datoteke, teksture itn. opisujemo z relativno potjo od korena našega projekta `res://`. Le-ta vedno kaže na tisto mesto, kjer je naš projekt v tem trenutku, namesto da bi poti opisovali z absolutno potjo `D:/projekti/dinozaver`, ki bi se lahko v prihodnosti spremenila, če naš projekt premaknemo nekam drugam na disku.

  #box-divider()

  #advanced-topic-heading[Za napredne uporabnike]

  `res://` v resnici predstavlja tudi koren virtualnega datotečnega sistem, ki ga Godot uporablja, ko projekt izvozimo in naredimo izvozno datoteko `.pck`. Datoteka `.pck` je v bistvu samo nek poseben arhiv mape `res://`, Godot pa omogoča njeno vgraditev v samo pogonsko datoteko izvožene igre.

  Tak način delovanja mu omogoča, da enako deluje na vseh platformah, saj ima popoln nadzor nad svojimi datotekami.
]


#screenshot(
  path: "assets/ui-basics/godot-ui_file-browser.png",
  width: 25%,
  caption: [Raziskovalec datotek v urejevalniku Godot. V mapi našega projekta se \ že nahaja vektorska sličica `icon.svg`, ki jo opazimo v drevesnem pogledu.],
)

Pa kar začnimo z osnovnimi sredstvi (angl. _assets_) naše igre! Najprej v korenu projekta ustvarimo mapo `sredstva`, kjer bomo hranili vsa sredstva (v našem primeru teksture in zvok). To storimo tako, da se z miško postavimo na mapo `res://` in kliknemo z desnim miškinim gumbom.
// TODO (Gorazd): Za formatiranje raznih gumbov in bližnjic priporočam, da se zgledujeta po naših drugih skriptah iz LaTeXa, kjer uporabljamo npr. knjižnico https://ctan.org/pkg/menukeys . Za miškine klike uporabljamo ponekod sličice, ki obarvajo pritisnjen gumb/kolešček.
// COMMENT(simon): hmm, obstaja https://typst.app/universe/package/keyle ampak nima sličic za miško...
Odprl se bo kontekstni meni, kjer lahko ustvarimo podmapo, kar storimo tako, da gremo pod kaskadni meni "Create New" in nato kliknemo na "Folder" ter vpišemo ime naše nove mape, torej `sredstva`.

#box-task[
  Ko smo uspešno ustvarili novo mapo, v navadnem raziskovalcu datotek (ne v Godotu) odprimo paket sredstev (angl. _asset pack_), ki nam je na voljo za igro Dinozaver, in celotno vsebino paketa sredstev skopiramo v mapo `sredstva`.

  #reference-to-workshop[
    Datoteko `.zip`, ki vsebuje paket sredstev, lahko prenesete iz naslova \
    https://simongoricar.com/poletna-sola-godot-2026/dinozaver_paket-sredstev.zip
  ]
]

#box-info(title: [Kako se prepričam, da sem v pravi mapi?])[
  Če brskaš po datotekah v raziskovalcu datotek svojega operacijskega sistema, potem pravo korensko mapo projekta v Godot prepoznaš po tem, da vsebuje datoteko `project.godot`!

  Če pa brskaš skozi Godotov lastni raziskovalec datotek, potem pa se sploh ne moreš zmotiti, saj je najvišja mapa `res://` vedno koren projekta.
]

Vrnimo se nazaj v urejevalnik Godot. Preden nadaljujemo z ogledom vsebine, ki smo jo uvozili, si oglejmo še dve uporabni funkcionalnosti raziskovalca datotek.
- Datotečni sistem je predstavljen kot drevesna struktura map: vsaka mapa ima ime in vsebino (datoteke ali podmape). V nasprotju z drugimi raziskovalci, kot je recimo Windowsov, kjer moramo mapo dvoklikniti, če jo želimo odpreti, lahko v raziskovalcu datotek v pogonu Godot vidimo več nivojev map naenkrat. Če želimo videti v notranjost posamezne mape, lahko ime mape dvokliknemo ali pa kliknemo na puščico levo od njenega imena. Naredimo to na primer za mapo `res://sredstva`: to dejanje bo razširilo pogled v notranjost mape, kjer bomo zdaj zagledali podmape `chromium-dino`, `dinozaver`, `kaktus`, ...
- Izberimo poljubno mapo ali datoteko, na primer `res://sredstva/piksel.png`, in kliknemo na datoteko z desnim miškinim gumbom. Pokazal se bo kontekstni meni, v katerem lahko izvajamo kup akcij, vključno s preimenovanjem, premikanjem, podvajanjem in brisanjem. //To pomeni, da se nam za take akcije ni treba vračati v raziskovalec datotek našega operacijskega sistema, ampak lahko te operacije izvedemo kar znotraj urejevalnika Godot.

#box-info(title: [
  #advanced-topic-heading[Za napredne uporabnike]
])[
  Od uporabe raziskovalca datotek imamo še eno korist: če npr. datoteko `res://sredstva/piksel.png` uporabimo v nekem prizoru, nato pa jo v Godotovem raziskovalcu datotek preimenujemo, se bo referenca, ki je zapisana v tistem prizoru, samodejno posodobila na novo ime datoteke (torej bo tisti prizor še vedno deloval normalno). To se ne bi zgodilo, če bi preimenovanje izvedli v raziskovalcu datotek našega operacijskega sistema, saj Godot v tem primeru ne bi vedel, kaj se je zgodilo.
]

#v(base-font-size)

Prepričajmo se, da je bil uvoz uspešen: struktura našega projekta bi sedaj morala biti sledeča:

#dtree("
📁 | res://                        (koren projekta)
  📁 | sredstva                (mapa, ki smo jo ustvarili v prejšnjem koraku)
    📁 | chromium-dino
    📁 | dinozaver
    📁 | kaktus
    📁 | okolje
    📁 | ptic
  icon.svg
")

#v(base-font-size)

Podrobneje si oglejmo vsebino enega izmed sredstev, ki smo ga ravnokar uvozili: v raziskovalcu datotek poiščimo datoteko `res://sredstva/chromium-dino/200-offline-sprite.png` in dvokliknimo nanjo. Desno zgoraj v urejevalniku v zavihku "Inspector" bomo sedaj zagledali podrobnosti tega sredstva kot na #ref(<inspector-spritesheet-selection>, supplement: [sliki]):
- Vidimo, da gre za datoteko z imenom `200-offline-sprite.png`.
- Vidimo majhen predogled slike. Ker gre za plahto sličic (angl. _spritesheet_), je malo težje videti vsebino, a vidimo, da je nekaj notri. Več o vsebini bomo povedali pozneje v #ref(<about-spritesheets>, supplement: [poglavju]) o plahtah sličic.
- Vidimo metapodatke, kot sta ločljivost in velikost.


#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_inspector_no-selection.png",
        width: 25%,
        caption: [Podokno "Inspector" \ brez izbrane datoteke.],
      ) <inspector-no-selection>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_inspector-selected-png.png",
        width: 25%,
        caption: [Podokno "Inspector" \ z izbrano datoteko.],
      ) <inspector-spritesheet-selection>
    ],
  ),
)


== Okno z uvoznimi nastavitvami

Oglejmo si še eno novo podokno, ki smo ga prej izpustili: "Import", torej podokno za nastavitve uvoza. To podokno najdemo levo zgoraj kot zavihek poleg strukture prizora (podokno z imenom "Scene"; označeno z vijolično na #ref(<ui-basics-annotated-sections>, supplement: [sliki])).

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_import-menu.png",
        width: 25%,
        caption: [Podokno "Import" \ brez izbrane datoteke.],
      ) <import-tab-no-selection>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_import-menu-spritesheet.png",
        width: 25%,
        caption: [Podokno "Import" \ z izbrano datoteko.],
      ) <import-tab-spritesheet-selection>
    ],
  ),
)

Ko prvič izberemo podokno za nastavitve uvoza, bo verjetno videti kot na #ref(<import-tab-no-selection>, supplement: [sliki]), torej brez vsebine. Razlog za praznino je to, da trenutno nimamo izbrane nobene datoteke. Če pa spodaj v raziskovalcu datotek z levim klikom izberemo eno izmed ravnokar dodanih datotek, na primer `res://sredstva/chromium-dino/200-offline-sprite.png`, bomo v podoknu za nastavitve uvoza zagledali kup nastavitev, kot je prikazano na #ref(<import-tab-spritesheet-selection>, supplement: [sliki]).

V tem podoknu lahko prilagodimo postopek uvažanja datoteke, ki smo jo izbrali. To vključuje način stiskanja, predobdelave slikovnih kanalov in še marsikaj naprednega, s čimer se na tej delavnici ne bomo ukvarjali. V primeru problemov je pomembno vedeti, da to okno obstaja, a se, vsaj pri razvoju igre Dinozaver, z njim ne bomo ukvarjali.

#box-task[
  Kliknite nazaj na gumb "Scene", da skrijete podokno "Import".
]


== Ustvarjanje in urejanje prizorov <urejanje-prizorov>

Sedaj, ko smo spoznali osnovna podokna urejevalnika in uvozili začetna sredstva za našo igro, se lahko lotimo ustvarjanja in urejanja prizorov, torej razvoja naše igre z dinozavrom!

// #v(base-font-size)

Vsaka igra, razvita s pogonom Godot, je osnovana na konceptu *vozlišč* (angl. "nodes"). Vozlišče je najmanjša enota funkcionalnosti, ki jo lahko uporabimo v naši igri. Vozlišča so različnih tipov: nekatera vozlišča so mišljena za razvoj iger v 2D, nekatera za 3D, nekatera za uporabniški vmesnik (angl. "user interface" oz. "UI"), nekatera za animacije itd. Primer vozlišča je na primer #node2d-type-name("Sprite2D"), ki preprosto prikaže 2D teksturo, ali `Camera2D`, ki vzpostavi igralski pogled.

Vozlišča sestavljamo skupaj v *prizore*. Prizori so, poleg skript, glavni način sestavljanja, hranjenja in urejanja naše igre. Vsak prizor ima korensko (t.j. vrhnje) vozlišče. Korensko vozlišče ima nase prilepljene "otroke", na isti način kot recimo v drevesni strukturi raziskovalca datotek. Vsako vozlišče ima lahko poljubno število otrok. Vozlišče, skupaj z njegovimi otroki, imenujemo veja. 

Če bi želeli na primer sestaviti avto, bi vrhnje vozlišče bilo splošno vozlišče za 2D, njegovi otroci pa bi bili lahko tipa #node2d-type-name("Sprite2D") in vsebovali komponente avta (kolesa, okvir, ...), razporejene vizualno tako, da skupaj sestavijo izgled avtomobila.

Relacija starš-otrok med vozlišči je pogosto uporabna, ker se, na primer pri poziciji vozlišča (torej recimo pri lastnosti `position` na vozliščih tipa #node2d-type-name("Node2D")):
- pod-vozlišča premikajo samodejno skupaj s starševskim vozliščem
- ker se pozicije pod-vozlišč zapisujejo relativno na starševsko vozlišče.

Več o lastnostih bomo povedali kasneje, v #ref(<composite-types>, supplement: "poglavju").

// #v(base-font-size)

=== Ustvarjanje prizora<scene-creation>


Preden zaidemo pregloboko v podrobnosti, ustvarimo nov prizor, ki bo vseboval našo igro z dinozavrom. To storimo tako, da odpremo okolje "2D" (glej #ref(<okolje-2d>, supplement: [poglavje])), na levi izberemo zavihek "Scene", in pod besedilom "Create Root Node" kliknemo na gumb "2D Scene", kot vidimo na #ref(<root-node-creation-screenshot>, supplement: [sliki]). Podokno "Scene" se bo spremenilo v hierarhični pogled našega novega prizora z enim samim korenskim vozliščem tipa #node2d-type-name("Node2D"), kot vidimo na #ref(<root-node-creation-screenshot-after>, supplement: [sliki]). V središčnem predelu urejevalnika se sedaj prepričajmo, da smo v okolju "2D". V tem okolju na sredini zaslona sedaj zagledamo prazno površino z dvema osema, na vrhu urejevalnika, pod izbiro okolja, pa vidimo nov zavihek z naslovom `[unsaved] (*)`.

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_creating-a-root-node.png",
        width: 25%,
        caption: [Ustvarjanje korenskega vozlišča.],
      ) <root-node-creation-screenshot>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_creating-a-root-node-after.png",
        width: 25%,
        caption: [Ustvarjeno korensko vozlišče #node2d-type-name("Node2D").],
      ) <root-node-creation-screenshot-after>
    ],
  ),
)

Čestitke! Ustvarili smo svoj prvi prizor, četudi zaenkrat še ne počne ničesar. Preden nadaljujemo, shranimo ta prizor na disk, da ne bomo našega napredka izgubili: pritisnimo `Ctrl+S` (ali kliknimo z desnim klikom na zavihek neshranjenega prizora in izberimo "Save Scene"). V shranjevalnem oknu, ki se prikaže, se premaknimo v korensko mapo `res://`, če slučajno nismo začeli tam, in nato v tej mapi poleg mape `sredstva` ustvarimo novo mapo z imenom `prizori`. To storimo ali z desnim klikom na prazen prostor in klikom na "New Folder ..." v kontekstnem meniju, ali pa s klikom na gumb za novo mapo z zelenim plusom, ki je desno zgoraj v tem podoknu. V mapi `prizori` sedaj ustvarimo še mapo `igra`, nato pa vanjo shranimo naš prizor z imenom `igra.tscn` (namesto privzetega `node_2d.tscn`), kot vidimo na #ref(<scene-save-dialog-igra-tscn>, supplement: [sliki]).

Novo datoteko s končnico `.tscn` bomo sedaj lahko našli tudi spodaj levo v raziskovalcu datotek na poti `res://prizori/igra/igra.tscn`. Če v prihodnosti ta prizor ponesreči ali nalašč zapremo s klikom na `X` ob imenu zavihka na vrhu, lahko ta prizor ponovno odpremo tako, da nanj dvokliknemo v raziskovalcu datotek. Kot bomo videli tekom razvoja, imamo lahko celo odprtih več prizorov hkrati, pri čemer lahko med njimi skačemo s kliki na njihove zavihke na vrhu urejevalnika.

#screenshot(
  path: "assets/ui-basics/godot-ui_scene_save-scene-dialog.png",
  width: 80%,
  caption: [Dialog za shranjevanje prizora `igra.tscn`.],
) <scene-save-dialog-igra-tscn>


=== Osnovni tipi vozlišč <basic-node-types>


Kot smo omenili že v začetku #ref(<urejanje-prizorov>, supplement: [poglavja]), obstajajo vozlišča različnih tipov. Nekatere tipe vozlišč uporabljamo za igre 2D, nekatere za 3D, nekatere za uporabniški vmesnik itd. Kar moramo v osnovi vedeti, je da so tipi vozlišč v osnovi prav tako odvisni med seboj (temu bi rekli drevesna struktura), na primer: vozlišče #node2d-type-name("Node2D") je specializirana različica tipa `Node`, in vozlišče #node2d-type-name("Sprite2D") je specializirana različica tipa #node2d-type-name("Node2D").

#figure(
  align(
    center,
    cetz.canvas({
      import cetz.draw: line, set-style

      let default-background-color = rgb("#353232")
      let line-color = rgb("#cacaca")

      let grayed-bg-color = rgb("#746f6f")
      let three-d-bg-color = rgb("#db3f3f")
      let two-d-bg-color = rgb("#4474db")
      let control-bg-color = rgb("#24b635")

      let grayed-fill-color = rgb("#dbdbdb")

      let node(
        name,
        fill-color: white,
        background-color: default-background-color,
        style: "normal"
      ) = {
        box(
          fill: background-color,
          inset: 5pt,
          radius: 4pt,
          text(
            fill: fill-color,
            weight: "bold",
            style: style,
            size: base-font-size - 1pt,
            name,
          ),
        )
      }

      cetz.tree.tree(
        spread: 0.1,
        grow: 0.5,
        draw-edge: (parent, child) => {
          let (a, b) = (parent.group-name, child.group-name)
          line((a, 0, b), (b, 0, a), stroke: (
            paint: line-color,
            thickness: 1.5pt,
          ))
        },
        (
          node("Node"),
          (
            node("Node3D", background-color: three-d-bg-color),
            // (
            //   // node("CollisionObject3D", background-color: three-d-bg-color),
            //   // (
            //   //   node("PhysicsBody3D", background-color: three-d-bg-color),
            //   //   node("StaticBody3D", background-color: three-d-bg-color),
            //   //   node("CharacterBody3D", background-color: three-d-bg-color),
            //   // ),
            // ),
            // node("Camera3D", background-color: three-d-bg-color),
          ),
          (
            node("CanvasItem", background-color: grayed-bg-color, style: "italic", fill-color: grayed-fill-color),
            (
              node("Node2D", background-color: two-d-bg-color),
              node("AnimatedSprite2D", background-color: two-d-bg-color),
              // node("Camera2D", background-color: two-d-bg-color),
              (
                node("CollisionObject2D", background-color: two-d-bg-color, style: "italic", fill-color: grayed-fill-color),
                (
                  node("PhysicsBody2D", background-color: two-d-bg-color, style: "italic", fill-color: grayed-fill-color),
                  node("StaticBody2D", background-color: two-d-bg-color),
                  node("CharacterBody2D", background-color: two-d-bg-color)
                ),
                node("Area2D", background-color: two-d-bg-color)
              ),
              node("Sprite2D", background-color: two-d-bg-color),
            ),
            (
              node("Control", background-color: control-bg-color),
              (
                node("Container", background-color: control-bg-color),
                node("CenterContainer", background-color: control-bg-color)
              ),
              node("TextEdit", background-color: control-bg-color),
              node("Label", background-color: control-bg-color),
            ),
          ),
        ),
      )
    }),
  ),
  caption: [Delna drevesna struktura nekaterih osnovnih tipov vozlišč.],
) <partial-node-type-structure>

Ta hierarhična odvisnost v praksi pomeni, da imajo bolj specializirana vozlišča vse funkcionalnosti, ki jih imajo tudi vsi njihovi starši. Na primer, vozlišča tipa #node2d-type-name("Sprite2D") imajo vse funkcionalnosti, ki jih imajo vozlišča tipa #node2d-type-name("Node2D") (torej vse, kar je potrebno za igre v dveh dimenzijah). Prav tako imajo recimo vozlišča tipa #node2d-type-name("Area2D") in #node2d-type-name("CharacterBody2D") vse funkcionalnosti, ki jih ima #node2d-type-name("CollisionObject2D"), ampak #node2d-type-name("Area2D") nima funkcionalnosti #node2d-type-name("PhysicsBody2D"), ki jih pa #node2d-type-name("CharacterBody2D") seveda ima, saj je njegov potomec.

Kar vidimo na #ref(<partial-node-type-structure>, supplement: [sliki]) je samo majhen nabor tipov vozlišč, ki jih lahko vnesemo v naše prizore. Cel seznam vozlišč lahko vidimo v podoknu za dodajanje vozlišča, ki ga odpremo tako, da na levi v zavihku "Scene" (glej #ref(<root-node-creation-screenshot-after>, supplement: [sliko])) izberemo vozlišče, kateremu želimo dodati podvozlišče (temu včasih pravimo, da vozlišču dodajamo otroka), nato pa kliknemo na znak za plus na vrhu. Odprlo se bo podokno, kot ga vidimo na #ref(<scene-new-node-dialog>, supplement: [sliki]), kjer lahko izberemo tip vozlišča, ki ga želimo umestiti v prizor. S klikom na puščice levo od njihovega imena lahko razširimo ali skrčimo pod-drevo tipov, ki jih ima določen tip vozlišča na voljo; če na primer razširimo #node2d-type-name("Node2D"), bomo notri našli #node2d-type-name("Sprite2D").

#box-info(title: [Kaj pa sivi tipi?])[
  Določenih tipov vozlišč ni mogoče samostojno umestiti v prizor. Primer takega tipa vozlišč je `CanvasItem`, ki izvira iz `Node`, in katerega podtipa sta #node2d-type-name("Node2D") (za dvodimenzionalne igre) in #control-type-name("Control") (za uporabniški vmesnik). #node2d-type-name("Node2D") in #control-type-name("Control") je seveda mogoče ustvariti (kot je mogoče ustvariti tudi vozlišče tipa `Node`), ampak tipa `CanvasItem` pa ni mogoče ustvariti, kar je prikazano s posivljenim imenom tipa. Gre za posebnost, s katero se nam ni treba preveč ukvarjati.
]

#screenshot(
  path: "assets/ui-basics/godot-ui_scene_new-node-dialog.png",
  width: 70%,
  caption: [Podokno za dodajanje novega vozlišča v prizor.],
) <scene-new-node-dialog>


#box-task[
  Poiščite vozlišče tipa #node2d-type-name("Sprite2D") in ga dodajte v prizor kot otroka vozlišča #node2d-type-name("Node2D"), ki smo ga dodali kot korensko vozlišče ob stvaritvi prizora. To storite tako, da z levim klikom v seznamu izberete ciljni tip vozlišča, nato pa kliknete na gumb "Create". Ko končate, mora vaše drevo prizora izgledati nekako tako kot #ref(<scene-root-with-sprite>, supplement: [slika]).

  #screenshot(
    path: "assets/ui-basics/godot-ui_scene_node-and-sprite-tree.png",
    width: 40%,
    caption: [Preprosta drevesna struktura 2D prizora z vozliščem #node2d-type-name("Sprite2D").],
  ) <scene-root-with-sprite>
]


=== Sprememba lastnosti vozlišč

Vozlišči, ki smo ju do sedaj dodali, sta bili tipa #node2d-type-name("Node2D") in #node2d-type-name("Sprite2D"). Morda ste dobili vtis, da se tip vozlišča prikaže kot besedilo v tej drevesni strukturi (na podlagi #ref(<scene-root-with-sprite>, supplement: [slike])), a stvar ni tako preprosta. Vozlišča imajo poleg svojega tipa namreč tudi lastno *ime*! To ime je tisto, kar vidimo kot besedilo ob ikoni vozlišča. Zaenkrat vidimo imeni #node2d-type-name("Node2D") in #node2d-type-name("Sprite2D") le zato, ker se vozlišča privzeto poimenujejo glede na svoj tip, a mi lahko ta vozlišča poljubno preimenujemo, kar je pravzaprav precej zaželeno, da se ne izgubimo.  
To storimo tako, da ali dvokliknemo na vozlišče ali pa z desnim klikom nanj odpremo kontekstni meni in izberemo akcijo "Rename". Lahko pa sprožite preimenovanje tudi z bližnjico #kbd("F2"), kadar imate izbrano določeno vozlišče.


#box-task[
  Preimenujte korensko vozlišče #node2d-type-name("Node2D") v `Igra` in vozlišče #node2d-type-name("Sprite2D") v `DinozaverSlicica`, ter nato prizor shranite z bližnjico #kbd("Ctrl", "S") ali desnim klikom na zavihek prizora in klikom na akcijo "Save Scene".

  #screenshot(
    path: "assets/ui-basics/godot-ui_scene_node-and-sprite-tree_post-rename.png",
    width: 40%,
    caption: [Preimenovana vozlišča s korenom `Igra` in vozliščem `DinozaverSlicica`.],
  ) <scene-root-with-sprite-renamed>
]

#box-info(
  title: "Kaj je bližnjica?",
  [
    Bližnjica (angl. shortcut) je alternativni (ponavadi hitrejši) način, da izvedemo neko akcijo (kot na primer, izberemo orodje v urejevalniku, shranimo projekt, zaženemo projekt, ...). Bližnjico ponavadi aktiviramo s pritiskom tipke ali kombinacije tipk na tipkovnici. Za aktivacijo bližnjice "shrani" na primer pritisnemo tipko `Ctrl` in nato tipko `S`.

    Definira jih program, ki ga uporabljamo, torej v našem primeru Godot. Seznam vseh bližnjic, ki jih vsebuje, lahko najdete in spreminjate pod `Editor -> Editor Settings -> Shortcuts`.

    #align(
      center,
      stack(
        dir: ltr,
        [
          #screenshot(
            path: "assets/ui-basics/editor-settings.png",
            width: 35%,
            caption: [Navigacija do nastavitev urejevalnika.],
          ) <editor-settings>
        ],
        box(width: 0.25cm),
        [
          #screenshot(
            path: "assets/ui-basics/shortcuts.png",
            width: 45%,
            caption: [Seznam bližnjic.],
          ) <shortcuts>
        ],
      ),
    )
  ],
)


Tip in ime vozlišča nista edini lastnosti, ki ju lahko spreminjamo. Vsako vozlišče ima namreč tudi nabor dodatnih nastavitev, odvisnih od tipa vozlišča, do katerih lahko dostopamo tako, da na levi v podoknu "Scene" izberemo vozlišče, da se osvetli, nato pa na desni strani urejevalnika pogledamo v podokno "Inspector".

Če na primer izberemo vozlišče `DinozaverSlicica`, bomo pri podrobnostih zagledali kup nastavitev, pri čemer so nekatere skrite pod skupinami, ki jih moramo razširiti s klikom na puščice. Znotraj teh nastavitev lahko to specifično izbrano vozlišče prilagodimo za naše potrebe. Na primer, ker gre za vozlišče tipa #node2d-type-name("Sprite2D"), mu lahko določimo sličico, ki jo bo to vozlišče prikazovalo. To lahko storimo na več načinov, a je najbolj enostaven način ta, da spodaj levo v raziskovalcu datotek poiščemo teksturo, ki jo želimo, in jo povlečemo na mesto za teksturo na desni zgoraj (v polje, kjer desno od imena polja `Texture` trenutno piše `<empty>`).

Več o lastnostih bomo spoznali v #ref(<composite-types>, supplement: [poglavju]).


#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_scene_sprite-inspector.png",
        width: 25%,
        caption: [Podrobnosti vozlišča `DinozaverSlicica` \ brez teksture.],
      ) <dino-sprite-inspector>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_scene_sprite-inspector-with-dino.png",
        width: 25%,
        caption: [Podrobnosti vozlišča `DinozaverSlicica`, \ ki mu je nastavljena tekstura.],
      ) <dino-sprite-inspector-with-dino>
    ],
  ),
)

#box-task[
  V Godotovem raziskovalcu datotek poiščite datoteko `res://sredstva/dinozaver/dinozaver_1.tres` in jo povlecite
  na prosto mesto na polju za teksturo izbranega vozlišča `DinozaverSlicica`. Rezultat bi moral izgledati približno tako kot #ref(<dino-sprite-inspector-with-dino>, supplement: [slika]). V okolju 2D na sredini urejevalnika morate zagledati majhnega dinozavra, kot je vidno na #ref(<dino-sprite-in-2d-editor>, supplement: [sliki]).

  #screenshot(
    path: "assets/ui-basics/godot-ui_scene_new-dino-sprite-in-editor.png",
    width: 90%,
    caption: [Izgled prizora, ki vsebuje sličico dinozavra.],
  ) <dino-sprite-in-2d-editor>
]

#box-task[
  Malo samostojnega dela! V svoj prizor dodajte še spodnje sličice:
  - mali kaktus (datoteka `res://sredstva/kaktus/mali-kaktus_1.tres`),
  - večji kaktus (datoteka `res://sredstva/kaktus/veliki-kaktus_1.tres`) in
  - ptiča (datoteka `res://sredstva/ptic/ptic_1.tres`).

  To storite tako, da ustvarite tri nova vozlišča tipa #node2d-type-name("Sprite2D") kot otroke korenskega vozlišča, in nato vsakemu dodelite drugo sličico, kot smo to storili za dinozavra.

  *Ne pozabite sproti shranjevati svojega prizora!*
]

#box-info(title: [Ste ustvarili napačno hierarhijo vozlišč?])[
  Morda se vam bo na tej točki zgodilo, da boste ponesreči ustvarili hierarhično strukturo, ki je niste želeli. Nič hudega! Če želite preurediti hierarhijo vozlišč, v levim klikom preprosto primite vozlišče, ki ga želite premakniti, in ga povlecite na želeno mesto v hierarhiji. Pomagajte si z vodilno belo črto, ki se pokaže ob vleku: ta črta vam nakazuje, kam se bo vozlišče premaknilo ob spustu klika.
]

Ko končate, bi moral biti vaš prizor podoben #ref(<2d-sprites-on-top-of-each-other>, supplement: [sliki]). Sličice oziroma primerki vaših vozlišč #node2d-type-name("Sprite2D") se bodo verjetno prekrivali. To je pričakovan rezultat, saj se vsako novo vozlišče vstavi na položaj starševskega vozlišča, kar je v našem primeru korensko vozlišče, ki je postavljeno v koordinatno izhodišče $(0, 0)$.

#screenshot(
  path: "assets/ui-basics/godot-ui_scene_prekrivajoce-slicice.png",
  width: 90%,
  caption: [Prizor, kjer smo dodali sličice eno na drugo.],
) <2d-sprites-on-top-of-each-other>

Seveda lahko naše sličice, oziroma vozlišča, ki te sličice prikazujejo, premaknemo po dvodimenzionalni površini. Če želimo to storiti na interaktiven način, v orodni vrstici pod zavihkom `igra` poiščemo orodje za premik (angl. "Move Mode"; tretji gumb z leve). To orodje aktiviramo v levim klikom, nato pa na levi v strukturi našega prizora izberemo vozlišče, ki ga želimo premakniti, ter šele nato z uporabo rdeče in zelene puščice (ali pa kar vlečenja sličice) naše vozlišče premaknemo na poljubno mesto. Približen rezultat tega procesa vidimo na #ref(<2d-sprites-arranged>, supplement: [sliki]).

Če sedaj na desni v oknu s podrobnostmi vozlišča razširimo podskupino "Transform", bomo zagledali, da se je vrednost lastnosti "Position" spremenila iz $(0, 0)$ na neko drugo vrednost, odvisno od našega premika:

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_2d_dino-transform-initial.png",
        width: 25%,
        caption: [Podrobnosti podskupine "Transform" na \ vozlišču `DinozaverSlicica` pred premikom.],
      ) <dino-sprite-transform-initial>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/ui-basics/godot-ui_2d_dino-transform-after.png",
        width: 25%,
        caption: [Podrobnosti podskupine "Transform" na \ vozlišču `DinozaverSlicica` po premiku.],
      ) <dino-sprite-transform-after>
    ],
  ),
)

Z našim ročnim premikom smo torej le spremenili vrednost teh dveh koordinat, ničesar drugega.


Poleg premikanja je dobro poznati še dva načina navigacije po urejevalniku 2D prizorov:
- Če vrtimo kolešček na miški gor ali dol, medtem ko imamo miško na 2D polju, bomo naš pogled približevali ali oddaljevali. Enako lahko dosežemo tudi s kliki na gumbe za plus in minus pod orodno vrstico 2D urejevalnika.
- Če pritisnemo kolešček na miški, ga držimo in med tem premikamo miško naokoli, se bomo pomikali po 2D prostoru. Enako lahko dosežemo tudi z uporabo orodja za premik (angl. "Pan Mode"), ki je na voljo v orodni vrstici, pa tudi pod bližnjico `G`.

#box-warning[
  Bodite previdni, da pri uporabi vleke z navadnim orodjem za izbiro (to je prvo orodje v orodni vrstici) po nesreči ne zagrabite enega izmed osmih okroglih vlečnih gumbov okoli vozlišča, saj bo vleka le-teh povzročila, da se bo sličica začela nenavadno raztegovati, česar zaenkrat nočemo. Zaradi tega priporočamo, da za premike res uporabljate orodje za premik, t.j. drugo orodje v orodni vrstici, ki je na voljo tudi pod bližnjico `W`.

  Če se vam zgodi ta nesreča, se lahko vedno vrnete na prejšnje stanje z uporabo bližnjice `Ctrl+Z` (angl. _undo_).
]

#screenshot(
  path: "assets/ui-basics/godot-ui_scene_premaknjene-slicice-dino.png",
  width: 70%,
  caption: [Prizor, kjer smo dodali sličice in jih premaknili.],
) <2d-sprites-arranged>


#box-info(title: [Sličice niso ostre])[
  Morda ste opazili, da sličice, ki smo jih postavili v prizor, niso popolnoma ostre. Razlog za to je, da Godot privzeto uporablja linearno filtriranje tekstur, kar pri sličicah z nizko ločljivostjo povzroči razmazan učinek. Ker mi želimo doseči ostre kvadratke, ki so značilni za t.i. _pixel art_, moramo spremeniti to nastavitev za naš projekt. Primer linearnega filtriranja teksture lahko vidimo na #ref(<godot_texture-filtering_linear>, supplement: [sliki]), primer filtriranja z najbližjim sosedom pa na #ref(<godot_texture-filtering_nearest>, supplement: [sliki]).

  #align(
    center,
    stack(
      dir: ltr,
      [
        #screenshot(
          path: "assets/ui-basics/godot_linear-texture-filtering.png",
          width: 20%,
          caption: [Nizkoločljivostna tekstura, ki \ jo vzorčimo z linearno interpolacijo.],
        ) <godot_texture-filtering_linear>
      ],
      box(width: 1cm),
      [
        #screenshot(
          path: "assets/ui-basics/godot_nearest-neighbour-texture-filtering.png",
          width: 20%,
          caption: [Nizkoločljivostna tekstura, ki \ jo vzorčimo tako, da preberemo najbližji \ piksel.],
        ) <godot_texture-filtering_nearest>
      ],
    ),
  )

  To storimo tako, da v aplikacijski vrstici levo zgoraj kliknemo na spustni meni "Project" in izberemo "Project Settings". Prikazalo se nam bo kup nastavitev našega projekta. Nas zanima nastavitev "Default Texture Filter", ki jo lahko najdemo tako, da na levi v kategoriji "Rendering" izberemo podkategorijo "Textures", kot vidimo na #ref(<godot_project-settings_texture-filtering>, supplement: [sliki]). Nastavitev nastavimo na vrednost "Nearest".

  #screenshot(
    path: "assets/ui-basics/godot_project-settings_texture-filtering.png",
    width: 80%,
    caption: [Nastavitve projekta, kjer nastavimo filtriranje tekstur.],
  ) <godot_project-settings_texture-filtering>

]

#box-info(title: [Relativne koordinate])[
  Na tej točki je pomembno, da spoznamo koncept relativnih koordinat. V #ref(<okolje-2d>, supplement: [poglavju]) smo spoznali dvodimenzionalni koordinatni sistem in ravno malo pred kratkim spoznali še, da lahko naša dvodimenzionalna vozlišča premikamo po tem koordinatnem sistemu.

  Kar pa je poleg tega pomembno razumeti je, da je naš prizor sestavljen hierarhično: če premaknemo pozicijo nekega starševskega vozlišča, bomo obenem sorazmerno premaknili tudi vse potomce tega vozlišča. 
  
  #box-divider()
  
  Na primer, če starševsko vozlišče premaknemo na $(5, 10)$, se bo tudi potomec tega vozlišča premaknil na $(5, 10)$, četudi je njegova lastnost #variable-name("position") nastavljena na $(0, 0)$. Zakaj? Zato, ker je pozicija potomca relativna na vsa starševska vozlišča! Če bi lastnost #variable-name("position") potomca nastavili na $(2, 4)$, bi to vozlišče zagledali na poziciji $(7, 14)$, saj se bi njegova pozicija seštela z njegovim staršem.
]

#pagebreak(weak: true)

= Osnove GDScript <gdscript-basics>
V našo igro smo do zdaj postavili nekaj sličic s kaktusi, dinozavrom in ptičem, a gre samo za nepremične sličice, ki igralcem ne omogočajo nobene interakcije. Zato je naslednji korak naše učne poti to, da se naučimo, kako v naše igre dodati premikanje, skakanje in drugo gibanje. Prišel je čas, da se naučimo jezika GDScript, s katerim bomo dosegli to interaktivnost.

== Pozdravljen, svet!

Pozdravljen, svet! je ponavadi prvi program, ki ga napišemo ob spoznavanju novega jezika, oziroma ob uporabi novega razvojnega okolja. Njegov namen je preizkusiti osnovno delovanje okolja in izpisovanja besedila. Namreč vse kar naredi je, da na zaslon izpiše poved: "Pozdravljen, svet!". Napišimo ga skupaj!

Da ne bomo preveč smetili po našem trenutnem prizoru, najprej ustvarimo novega, v katerem bomo eksperimentirali.

#box-task[
  Izdelajte nov prizor. Nov prizor lahko ustvarite tako, da kliknete na gumbek "+", nad orodno vrstico in desno od vseh trenutno odprtih prizorov. Nato lahko sledite navodilom v #ref(<scene-creation>, supplement: "poglavju").
  
  Korenski tip novega prizora naj bo kar #node2d-type-name("Node2D"), poimenujte ga `Osnove`. Nov prizor poimenujte `osnove.tscn` in ga shranite v mapo z imenom `gdscript_osnove` v korenski mapi `res://`.
]

=== GDScript in vozlišča <gdscript-and-nodes>

Preden napišemo prvo vrstico kode, je treba razčistiti še nekaj konceptov, ki jih vpelje Godot.

Vsaka GDScript skripta (datoteka) je namenjena uporabi na enem od tipov vozlišč. GDScript je namenski programski jezik in se ga izven okolja Godot ne da poganjati. Za svoje delovanje mora biti pripet na enega od vozlišč znotraj drevesa aktivnega prizora.

Na katero vozlišče je lahko pripet, določa tip (razred) same datoteke. O tem bomo malo več povedali kasneje, za zdaj si je pomembno zapomniti, da se mora vrstica `extends` na vrhu datoteke ujemati s tipom vozlišča, na katerega pripenjamo datoteko.

#box-info(title: [Kako prepoznam to napako?])[
  V primeru, da se tip GDScript datoteke ne ujema s tipom vozlišča, bo Godot ob zagonu javil napako: `Script inherits from native type '(tip GDScript datoteke)', so it can't be assigned to an object of type: '(tip vozlišča)'`.

  V tem primeru imamo dve možnosti: ali spremenimo tip datoteke s stavkom `extends` ali pa spremenimo tip vozlišča z desnim klikom na vozlišče in izbiro "Change type".

  *POZOR!* Večino časa bo Godot za vse to poskrbel sam. Če pride do takšne napake, je potrebno preveriti, ali smo se kje zmotili mi. Morda smo na vozlišče pripeli napačno datoteko.
]

Datoteko na vozlišče pripnemo s klikom na vozlišče in nato s klikom na ikono zvitka z zelenim plusom, prikazanim tudi na #ref(<attach-script>, supplement: "sliki").

#screenshot(
  path: "assets/gd-script/attach-script.png",
  width: 50%,
  caption: [Gumb za pripenjanje nove skripte.],
)<attach-script>

Ob kliku na ta gumb nam bo Godot odprl pojavno okno za izdelavo nove skripte, oziroma če skripta s ponujenim imenom že obstaja, okno za pripenjanje obstoječe skripte.

#screenshot(
  path: "assets/gd-script/attach-script-popup.png",
  width: 50%,
  caption: [Okno za pripenjanje nove skripte.],
)

- Polje "Language" (jezik), ki se nanaša na skriptni jezik, ki ga želimo uporabiti, lahko zanemarimo, saj bomo tekom te delavnice delali samo v GDScriptu.
- Polje "Inherits" (dedovanje) *večino časa pustimo na miru*. Če smo skripto naredili po zgoraj opisanem postopku, ga bo Godot sam izpolnil pravilno in se nam napaka z neujemanjem tipa skripte in vozlišča ne more pojaviti.
- Polje "Template" (predloga) prav tako lahko pustimo pri miru. Vse kar naredi, je, da nam novo skriptno datoteko napolni z vnaprej definirano predlogo, ki je za nas uporabna. Ponavadi bomo želeli "Node: Default" ali pa bomo predlogo kar ugasnili.
- Polje "Built-in Script" (vgrajena skripta) lahko prav tako ignoriramo, saj tega mehanizma ne bomo obravnavali, ker za nas ni pomemben.
- Polje "Path" je za nas pravzaprav najbolj pomembno in pogosto se pri izdelavi nove skripte spremeni samo tega. To polje nam v `res://` formatu pove, kam bo shranjena nova skripta.

Potem ko vsa polja nastavimo na želene vrednosti, kliknemo na gumb "Create" (slov. "Ustvari").
Godot bo izdelal novo skripto s končnico `.gd` in nam jo odprl v pogledu urejevalnik (Script), obravnavanem v #ref(<urejevalnik>, supplement: [poglavju]).

#box-task[
  Na korensko vozlišče v sceni pripnite novo skripto. Poimenujte jo `osnove.gd`, shranjena pa naj bo kar v isti mapi kot prizor `osnove.tscn`.
]

=== Prve vrstice

Prišel je čas da napišemo svojo prvo vrstico kode. Godot in GDScript sta kompleksna kosa programske opreme in vseh delov ni mogoče spoznati naenkrat, tako da bomo *na začetku nekaj stvari naredili na slepo in jih bolj podrobneje razložili kasneje*.

Na tej točki bi morali imeti pred seboj kos kode, ki je videti nekako takole:
```gd
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
```

Da na zaslon izpišemo "Pozdravljen, svet!", moramo poklicati funkcijo `print` v funkciji `_ready()`. Če vam te besede zvenijo kot marsovščina, nič hudega, vse bo bolje razloženo v prihodnjih poglavjih. Za zdaj samo spremenite šesto vrstico in `pass` nadomestite s `print("Pozdravljen svet!")`. Pri tem bodite pozorni, na zamik pred besedo `print`. Zakaj bomo malo bolje razložili kasneje, zaenkrat se samo prepričajte da je `print` zamaknjen enako, kakor je bil pred tem `pass`. Če ne veste kako ga pravilno zamakniti, izbrišite vse znake pred njim, dokler ne bo poravnan popolnoma levo in nato enkrat pritisnite tipko "tab" na tipkovnici.

Vse pod to vrstico lahko sedaj zaenkrat izbrišemo, da nas vsebina ne bo preveč medla. Vaša koda bi po tem morala izgledati nekako takole:

```gd
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Pozdravljen, svet!")
```


=== Poganjanje projekta

Na tej točki nam preostane le, da kodo poženemo. Za ta namen ima Godot na svojem vmesniku, zgoraj desno, vedno prikazanih nekaj gumbov.

#screenshot(
  path: "assets/gd-script/run-panel.png",
  width: 50%,
  caption: [Gumbi za poganjanje projekta.],
)

#todo[Popravi screenshot ker so umaknili gumb za oddaljeno konfiguracijo.]

Ti gumbi so, od leve proti desni:

- *Poženi*: zažene privzet prizor. Ob prvem kliku na ta gumb nas bo Godot vprašal, kateri prizor želimo nastaviti kot privzeti. To lahko pozneje spremenimo v nastavitvah projekta.

- *Pavziraj* / *Nadaljuj*: medtem ko je projekt zagnan, začasno zaustavi ali ponovno nadaljuje izvajanje. Uporaben za testiranje in iskanje napak.

- *Ustavi*: ustavi izvajanje projekta.

- _Zaženi oddaljeno konfiguracijo_: tega gumba ne bomo uporabljali in ga lahko ignorirate.

- *Zaženi trenuten prizor*: požene prizor, na katerem trenutno delamo v strukturi prizora (ta prizor je tudi viden v zavihkih nad urejevalnikom). Ta gumb bomo najbolj pogosto uporabljali za zaganjanje.

- *Zaženi prizor z diska*: odpre meni, v katerem lahko izberemo, kateri prizor želimo pognati.

- _Vklop načina za izdelavo videoposnetka_: tega gumba ne bomo uporabljali in ga lahko ignorirate.

Projekt lahko sedaj zaženemo s klikom na "Zaženi trenuten prizor". Godot nas bo sam prestavil v okno Igra (okolje "Game"), v izhodni konzoli (zavihek "Output") pa bi se moralo prikazati naše sporočilo.

#screenshot(
  path: "assets/gd-script/hello-world.png",
  width: 90%,
  caption: [Urejevalnik, kjer se je v zavihku "Output" izpisalo sporočilo "Pozdravljen svet!".],
)<hello-world>

#todo[Popravi tudi ta screenshot da ob imel vejico v pozdravljen svet.]

S tem smo uspešno preverili, da osnovne funkcije našega okolja delujejo pravilno!

#box-info(title: [Se vam igra pojavlja v novem oknu?])[
  Če ste v poglavju #ref(<env-game>, supplement: [poglavju]) slučajno pozabili izklopiti nastavitev "Make Game Workspace Floating on Next Play", se vam bo igra prižgala v novem plavajočem oknu. S tem načeloma ni nič narobe, ampak za lažje sledenje tej skripti priporočamo, da nastavitev vseeno popravite.
]

=== Malo bolj podrobna razlaga

```gd
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Pozdravljen svet!")
```

Pojdimo zdaj skupaj čez ta najbolj osnoven program.

Začnemo z besedo `extends`, ki ji sledi tip vozlišča s katerim delamo. V našem primeru delamo na vozlišču #node2d-type-name("Node2D") zato je tam tudi njegovo ime. `extends` bo bolj podrobno razložen v #ref(<classes-and-extends>, supplement: "poglavju") in se z njim še ne rabimo obremenjevati.

Nato sledi nekaj praznih vrstic. Prazne vrstice uporabljamo, da kodo strukturiramo. Torej da nam jo je lažje brati. Prazne vrstice Godot ob izvedbi skripte ignorira in nimajo nobenega vpliva na delovanje naše igre.

Nato sledi vrstica 4, ki se začne z znakom \#. Gre za komentar, torej del "kode", ki opisuje drugo kodo in jo bo Godot prav tako ignoriral. Komentarji so bolj podrobno razloženi kasneje.

Nato pride vrstica 5, ki je malo bolj kompleksna. Ta vrstica se začne z besedo `func`, ki deklarira funkcijo. Nadaljuje se s podpisom te funkcije, v našem primeru `_ready() -> void`, ki pravi da ta funkcija ne prejema argumentov in nič ne vrača. Vse kar je bilo ravnokar napisano bomo bolje razložili kasneje, v #ref(<functions>, supplement: "poglavju"). Kar je za nas pomembno je, da tako Godotu povemo, kateri kos kode naj izvede, ko se zažene.

Sledi vrstica 6, v kateri je klic funkcije `print`. Kličemo jo z enim samim argumentom - "Pozdravljen svet!". Zopet je vse kar rabimo vedeti, da ta vrstica povzroči izpis, prikazan na #ref(<hello-world>, supplement: "sliki"). Zamik ki smo ga prej tako poudarili, Godotu pove, da ta vrstica pripada funkciji `_ready`. To bo bolj podrobno razloženo v #ref(<indents>, supplement: "poglavju"). Do takrat se samo držite enakih zamikov, kot jih delamo v primerih, oziroma vse po ```gd func _ready() -> void:``` zamikajte za en tabulator.


== Spremenljivke

Spremenljivke so eden najpomembnejših konstruktov programskih jezikov, saj nam omogočajo, da hranimo podatke in stanje naše igre.

Najlažje si jih lahko predstavljamo kot škatle, na katerih so etikete z imeni. V škatlo lahko dajemo poljubno vsebino, v našem primeru vrednosti različnih tipov, od števil do besedila. Nato lahko računalniku skozi programski jezik damo navodila, kaj naj s temi škatlami počne. Ne glede na to, kaj je vsebina škatle, bo vedno ravnal enako, prepoznal pa jih bo po etiketah z imeni.

Kot pri veliko drugih računalniških pojmov se novih konceptov najlažje privadiš s primeri, tako, da si kar poglejmo prvega:

#box-info(
  title: [Da malo poenostavimo],
)[
  Od tod naprej se bodo za boljšo berljivost in zmanjšanje prostora, ki ga zasedejo izseki kode v tej knjigi, odvečni deli v blokih kode izpuščali. Še vedno delamo v enakih GDScript datotekah, ki imajo na vrhu direktivo `extends` in v nekaterih primerih še marsikaj drugega, a bodo primeri od tu naprej vsebovali samo izsek, ki je za nas pomemben.
]

```gd
func _ready() -> void:
    var stevilka
    stevilka = 10
    print("Vrednost stevilke je: ")
    print(stevilka)
```
```izhod
Vrednost stevilke je:
10
```

V zgornjem primeru smo v spremenljivko z imenom `stevilka` shranili vrednost 10. Če program zaženemo, bo to tudi vidno na Godotovem izhodu (v konzoli, oziroma v zavihku "Output").

Spremenljivko deklariramo s ključno besedo `var`, ki ji sledi ime spremenljivke (etiketa na škatli). Spremenljivki vrednost nastavimo tako, da napišemo njeno ime in nato enačaj, nakar sledi vrednost, ki ji bo dodeljena (desno stran enačaja postavljamo v škatlo).


Ker se zelo pogosto zgodi, da želimo oboje narediti hkrati, lahko ta ukaza združimo. Kako bi zgornji primer naredili na tak način, lahko vidite spodaj. Tak način izdelave je priporočen.

```gd
func _ready() -> void:
    var stevilka = 10
    print("Vrednost stevilke je: ")
    print(stevilka)
```

#box-warning[
  GDScript, kot praktično vsi drugi programski jeziki, svoja pravila vleče iz angleščine. Zaradi tega lahko svoje spremenljivke poimenujemo izključno s črkami angleške abecede. V imenih so dovoljene tudi števke in podčrtaj (~`_`~), vendar števka ne sme biti na prvem mestu v imenu.
]

#box-info(
  title: [Kaj je `print`?],
)[
  `print` je funkcija, ki neko vsebino izpiše v Godotov izhod (nam viden pod zavihkom "Output"). V primeru, da `print` prejme neko spremenljivko, na zaslon napiše njeno vrednost in ne njenega imena (kar je v škatli in ne imena škatle). Funkcije bomo bolje spoznali kasneje.
]

Spremenljivki lahko vrednost kasneje v programu tudi spremenimo. V spremenljivki je naenkrat lahko samo ena vrednost. Vrednost `10` je torej po osmi vrstici, ker je nismo shranili nikamor drugam, izgubljena.

```gd
func _ready() -> void:
    var stevilka = 10
    print("Vrednost stevilke je: ")
    print(stevilka)

    stevilka = 20
    print("Nova vrednost stevilke je:")
    print(stevilka)
```
```izhod
Vrednost stevilke je:
10
Nova vrednost stevilke je:
20
```

=== Podatkovni tipi

Vse vrednosti imajo tudi svoj podatkovni tip. V zgornjem primeru je število `10` celo število, torej pripada celoštevilskemu tipu. Posledično je tudi spremenljivka `stevilka` celoštevilskega tipa.

GDScript ima kar nekaj vgrajenih podatkovnih tipov, ki jih lahko uporabljamo. Med pogosto uporabljene spadajo:
- `bool` - je najbolj enostaven tip in lahko predstavlja samo dve stanji. `true` - drži ali `false` - ne drži.
- `int` - celo število. Na primer -5, 0 ali 42.
- `float` - realno število. Na primer -2.6, 0.0005 ali 4.2.
  #box-info(
    title: [Opombi o `float`],
  )[
    - GDScript pravila pisanja vleče iz angleščine. Med pisanjem se za ločilo med celim delom in decimalnim delom torej ne uporablja decimalna vejica (`,`) ampak pika (`.`)! V slovenščini bi seveda navadno uporabljali decimalne vejice, a bomo v tem dokumentu zaradi tega, ker pišemo kodo, to pravilo kršili in v zvezi z realnimi števili uporabljali pojem decimalna pika.
    - Cela števila so podmnožica realnih števil, to do neke mere drži tudi znotraj naših računalnikov. Celo število 42 bi torej lahko prestavili tudi kot realno število 42.0. V nekaterih primerih je to tudi pravilno, se pa tega zaradi razlogov, ki presegajo vsebino te delavnice, izogibamo. Za vas bo dovolj, enostavno pravilo: če vnaprej veste, da neka vrednost nikoli ne bo zašla iz celoštevilskega v realno, uporabite `int`, torej celoštevilski tip. Če pa se na katerikoli točki pojavi decimalni del, uporabite `float`.
  ]
- `String` - zaporedje znakov ali `niz`. Na primer "Pozdravljen svet!". V tem primeru je niz sestavljen iz zaporedja `P o z d r a v l j e n <presledek> s v e t !`. Izdelava in uporaba nizov je precej pomemben del programiranja in si ga bomo malo bolje pogledali kasneje.

V zgornjem primeru je `stevilka` celoštevilskega tipa ```gd int```. GDScript je to lahko sam ugotovil, saj smo spremenljivki dodelili vrednost `10`, ki je sama po sebi celo število, tako da nam tega ni bilo treba nikjer napisati. GDScript pa omogoča tudi eksplicitno pisanje tipov; sicer ne bo nikoli zahteval, da tipe pišemo eksplicitno, je pa zapisovanje tipov v kodi dobra praksa, ki nam lahko prepreči lastne napake.

V spodnjem primeru se bo vrstica 4 izvedla normalno in tip spremenljivke `celo_stevilo` se bo potihoma spremenil iz `int` v `String`. Obenem se vrstica 5 ne bo izvedla, ampak nam bo vrnila napako, saj GDScript ve, da želimo imeti v `eksplicitno_celo_stevilo` celo število in pretvorbe ne bo dovolil.

```gd
var celo_stevilo = 42
var eksplicitno_celo_stevilo: int = 42

celo_stevilo = "dovoljena operacija"
eksplicitno_celo_stevilo = "nedovoljena operacija"
```

#line(length: 100%, stroke: 0.5pt)

```
Parser Error: Cannot assign a value of type "String" as "int".
```

#box-warning[GDScript nam v nekaterih primerih poskuša potihem pomagati in lahko kdaj izvede kakšno operacijo, ki nam potem povzroča preglavice. V spodnjem primeru, na vrstici 5, realno število 10.6 po tihem pretvori v celo število 10, tako da odreže decimalni del.
  ```gd
  var celo_stevilo = 42
  var eksplicitno_celo_stevilo: int = 42

  celo_stevilo = 10.6 # -> 10.6
  eksplicitno_celo_stevilo = 10.6 # -> 10

  print(celo_stevilo)
  print(eksplicitno_celo_stevilo)
  ```
  ```izhod
  10.6
  10

  ```
  Če za tako obnašanje ne vemo in nismo pozorni kaj delamo, lahko preteče precej časa preden težavo, povezano s tem, odkrijemo. GDScript ne bo moral vedno paziti na nas, včasih pa nam bo nevede šel celo nasproti, tako da je še vedno pomembno, da kodo pišemo pazljivo in pozorno ter da napisano kodo razumemo.
]

Poleg navadnih podatkovnih tipov, Godot pozna tudi podatkovni tip #data-type-name("Variant"). To je poseben podatkovni tip, ki predstavlja vse podatkovne tipe. Naše spremenljivke so, če jim nismo eksplicitno dodelili tipa, tipa #data-type-name("Variant"). #data-type-name("Variant") je poseben podatkovni tip, ki predstavlja vse podatkovne tipe, torej lahko v sebi drži katero koli vrednost.
Spodnji vrstici sta ekvivalentni.

```gd
var test: Variant = 42
var test = 42
```

Poleg navadnih vrednosti lahko naši spremenljivki dodelimo tudi vrednost ```gd null```. O vrednosti ```gd null``` lahko razmišljamo kot o prazni škatli, predstavlja nam namreč pomanjkanje vrednosti. Uporabe vrednosti ```gd null``` se pri programiranju pogosto poskušamo izogibati, saj iz tega lahko izvira ogromno napak. Znotraj tega učbenika bomo ```gd null``` uporabili samo takrat, ko bo to res potrebno. Če je naša spremenljivka navadnega (primitivnega) tipa in je njen tip definiran v kodi, ji vrednosti ```gd null``` ne moremo določiti. ```gd null``` pa lahko dodelimo spremenljivkam, katerih tip je na primer vozlišče ali vir.


=== Računske operacije

Ko pišemo kodo, pogosto želimo izvesti različne računske operacije. Praktično vsi programski jeziki to dosegajo kar z uporabo matematičnih simbolov oziroma njihovih približkov na tipkovnici. GDScript v tem ni nobena izjema.

```gd
var vsota = 13 + 5 # = 18
var razlika = 13 - 5 # = 8
var zmnozek = 6 * 7 # = 42

# POZOR, pri deljenju sta pomembna podatkovna tipa deljenca in delitelja.
# V primeru, da sta oboje celi števili, bo šlo za celoštevilsko deljenje,
# pri katerem je ostanek zavržen.
var kolicnik_celostevilsko = 13 / 5 # = 2
# V tem primeru smo GDScriptu, z uporabo decimalne pike, jasno označili,
# da gre za dve realni števili, zato bo izvedel navadno deljenje.
var kolicnik = 13. / 5. # = 2.6

# Ostanek pri celoštevilskem deljenju lahko dobimo z uporabo operatorja %.
var ostanek = 13 % 5 # = 3
```

#box-info(
  title: "Več o komentarjih",
  [
    V programskem jeziku GDScript, simbol `#` označuje začetek komentarja. Komentar traja od znaka `#` do konca vrstice. Komentarje bo Godot med procesiranjem GDScript datotek ignoriral, in nimajo nobenega vpliva na izvajanje.

    V programiranju so komentarji zelo pomemben konstrukt, saj nam omogočajo opisovanje kode. To pride še posebej prav, če na istem delu kode dela več ljudi. Hkrati, pa je uporabno tudi, če na projektu delate sami, ker je verjetnost, da si boste na dolgi rok zapomnili zakaj ste dele kode napisali tako kot ste jih, zelo majhna.
  ],
)

=== Izvožene spremenljivke (direktiva `@export`)<exported-variables>

Razvoj iger je po svoji naravi pogosto iterativen. Zadeti vse vrednosti (kot so hitrost premikanja, velikosti objektov, barva neba, ...) v prvo je praktično nemogoče. Zaradi tega nam igralni pogoni nudijo različna orodja za hitro prilagajanje in testiranje različic. Za premik igralca je potrebno samo povleči puščico, za popravek velikosti platforme spremeniti številko, barvo neba pa lahko izberemo kar s kapalko.

Problem se pojavi pri logiki, ki je ne nadzira pogon ampak jo napiše razvijalec sam. Različni pogoni to rešujejo na različne (precej podobne) načine in Godot k temu pristopi z direktivo ```gd @export```.

Znotraj skriptne datoteke lahko globalno definirane spremenljivke označimo kot "izvožene", kar bo Godotu sporočilo, da gre za vrednosti, ki jih želimo urejati znotraj urejevalnika.
Poglejmo si primer:
```gd
extends Node2D

# "stevilka" je tu globalna spremenljivka, saj je definirana na najvišjem nivoju
# (pred njo ni nobenega tabulatorja ali presledka).
#
# Globalne spremenljivke so na voljo povsod znotraj GDScript datoteke
# (spremenljivke definirane znotraj funkcije so na primer na voljo samo znotraj te
# funkcije)
# da lahko neko spremenljivko označimo z @export, mora biti globalna spremenljivka.
@export
var stevilka: int = 42

func _ready() -> void:
	print("Vrednost stevilke je: ")
	print(stevilka)
```

Na prvi pogled tu ne vidimo ničesar posebno novega. Če bomo ta primer zagnali, bomo dobili podoben izpis kot ponavadi:
```izhod
Vrednost stevilke je:
42
```

Če pa znotraj strukture prizora izberemo vozlišče `Osnove` (na katerega je pripeta naša skripta), lahko na desni v urejevalniku vozlišč opazimo nov odsek, imenovan `osnove.gd`:

#screenshot(
  path: "assets/gd-script/export-section.png",
  width: 30%,
  caption: [Odsek definiran skozi direktivo \@export.],
) <export-section>

Če znotraj odseka spremenimo vrednost $42$ na nekaj drugega in projekt znova poženemo, lahko vidimo, da se sprememba vrednosti odraža na izhodu, kljub temu da je (privzeta) vrednost v `osnove.gd` še vedno 42. To se zgodi zato, ker smo vrednost spremenili v urejevalniku in tako prejšnjo (privzeto) vrednost povozili.

#box-warning([
  Urejanje izvožene spremenljivke znotraj urejevalnika vozlišč, ureja samo vrednost na trenutnem vozlišču (na katerega je pripeta skripta). Če je skripta pripeta na več vozlišč, oziroma je vozlišče skozi sistem prizorov pripeto večkrat, bo sprememba še vedno vidna samo na vozlišču, ki ga trenutno urejamo.

  Ravno obratno se spremembe, če urejamo vozlišče znotraj prizora, lahko odražajo povsod, kjer je prizor uporabljen, razen v nekaterih primerih, kjer je bila osnovna vrednost spremenjena v samem prizoru.

  Pravila glede tega, katero vrednost bo Godot uporabil, ko naleti na izvoženo spremenljivko, so zapletena. Bodite torej pozorni, da med spreminjanjem (privzete) vrednosti izvožene spremenljivke česa ponesreči ne pokvarite.

  Privzeta vrednost za vozlišče, ki mu vrednost nikoli ni bila urejena, je v našem primeru `42`, ki smo jo definirali znotraj kode, oziroma privzeta vrednost podatkovnega tipa, če v kodi nismo navedli nobene vrednosti.

  Privzeta vrednost podatkovnega tipa je za nekatere tipe določena s strani Godota. Če tip privzete vrednosti nima določene je privzeta vrednost `null`. Večina sestavljenih tipov nima določene privzete vrednost.

  Nekaj primerov privzetih vrednosti je:
  ```gd
  var cela_stevilka: int #= 0
  var decimalna_stevilka: float #= 0.0
  var niz: String #= "" (prazen niz)
  var boolean: bool #= false
  var vektor: Vector2 #= (0.0, 0.0)
  var prizor: PackedScene #= null
  ```

  Sestavljene tipe, kot je `PackedScene`, bomo bolj podrobno obravnavali kasneje.
])


Dobra praksa je, da globalnim spremenljivkam, še posebej tistim ki so označene z ```gd @export```, eksplicitno navedemo podatkovni tip in nastavimo začetno vrednost. Samo tako smo lahko prepričani, da Godot pravilno interpretira, kaj želimo izvoziti, in da nam bo lahko pomagal pri lovljenju napak.


Poglejmo si še malo bolj kompleksen primer.

#box-info(title: "Obdelava nizov", [
  Za razumevanje sledečega primera na hitro spoznajmo še osnovno uporabo nizov. Dva niza lahko "zlepimo" z uporabo operatorja `+`.

  ```gd
  print("Pozdravljen " + "svet!")
  ```
  ```izhod
  Pozdravljen svet!
  ```

  Če želimo nek drug tip pretvoriti v niz, lahko to storimo s funkcijo `str`. Večina GDScriptovih in Godotovih podatkovnih tipov podpira takšno pretvorbo.

  ```gd
  print("Odgovor je: " + str(42))

  # Spodnji klic ne bi deloval, saj operator + ne zna "zlepiti" niza in nečesa kar
  # ni niz (število 42).
  print("Odgovor je: " + 42)
  ```
  ```izhod
  Odgovor je: 42
  ```

  Funkcija `print` že sama po sebi nad danim parametrom pokliče funkcijo `str`, zaradi česar smo sploh lahko na izhod pisali primere, kot je bil na primer:

  ```gd
  func _ready() -> void:
    print("Vrednost stevilke je: ")
    # print pred izpisom nad spremenljivko stevilka sam klice str
    print(stevilka)
    # tako da je tak klic praktično ekvivalenten.
    print(str(stevilka))
  ```
])


```gd
extends Node2D

@export
var ime: String

@export
var ulica: String

@export
var hisna_stevilka: int

@export
var postna_stevilka: int

@export
var ime_poste: String

@export
var drzava: String

func _ready() -> void:
	print("Dostavite osebi" + ime + " na naslov:")
	print(ulica + " " + str(hisna_stevilka))
	print(str(postna_stevilka) + " " + ime_poste)
	print(drzava)
```

Ta primer nam omogoča, da sestavimo sporočilo za dostavljavca. Polja v samem sporočilu lahko urejamo znotraj urejevalnika vozlišč.
Če jih na primer izpolnimo takole:

#screenshot(
  path: "assets/gd-script/export-address-example.png",
  width: 50%,
  caption: [Primer izpolnitve polj za primer dostavljavca.],
)

bomo na izhod dobili:
```izhod
Dostavite osebi Andrej Matos na naslov:
Večna pot 113
1000 Ljubljana
Slovenija
```

#box-task[Poigrajte se z direktivo `@export` in poskusite najti kakšen nov način uporabe.]

#box-info(
  title: "Kaj lahko izvozim?",
  [
    Godot zna pravilno izvoziti marsikateri podatkovni tip, ne pa vseh. V primeru, da poskusimo izvoziti podatkovni tip, ki je zanj preveč kompleksen, nam bo to sporočil.
  ],
)

== Pogojni stavek

Če želimo znotraj kode sprejeti neko odločitev, kjer bomo glede na nek pogoj, izvedli bodisi set ukazov _A_ bodisi set ukazov _B_, ponavadi za to uporabimo pogojni stavek. Temu odločanju pravimo vejitev.

V GDScriptu to zgleda takole:
```gd
if <pogoj>:
  <potem>
else:
  <drugače>
```

- `<pogoj>` je kos kode, katere rezultat mora biti, po izvedbi, podatkovnega tipa `bool`.
- `<potem>` je koda, ki se bo izvedla če `<pogoj>` drži (njegova vrednost je `true`).
- `<drugače>` je koda ki se bo izvedla če `<pogoj>` ne drži (njegova vrednost je `false`). Stavek `else` ni nujen in ga lahko, skupaj z `<drugače>` izpustimo.

#box-repeat[
  `bool` je najbolj enostaven podatkovni tip. Predstavlja lahko le 2 stanji: bodisi `true` (drži) ali `false` (ne drži).
]

#todo[Za tale ponovimo bi lahko naredili novo škatlo in malo standardizirali njegovo uporabo, zdaj je dostikrat tak odsek samo znotraj teksta kot navadna poved ali pa v kakšnem oklepaju]

=== Pogojni operatorji

Ponavadi je `<pogoj>` kratek kos kode, ki primerja dve ali več vrednosti s primerjalnimi operatorji. Primerjalni operatorji, za razliko od aritmetičnih (kot so `+`, `-`, `*`, ...), katerih rezultat je ponavadi neko število, je rezultat primerjalnih operatorjev vedno tipa `bool`. Nekaj pogosto uporabljenih primerjalnih operatorjev je:

- `A > B` - večje, vrne `true` če je A strogo večji od B, drugače vrne `false`.
- `A >= B` - večje ali enako, vrne `true` če je A večji ali enak B, drugače vrne `false`.
- `A == B` - je enako, vrne `true` če je A enak B, drugače vrne `false`.
- `A != B` - ni enako, vrne `true` če A ni enak B, drugače vrne `false`.
- `A <= B` - manjše ali enako, vrne `true` če je A manjši ali enak B, drugače vrne `false`.
- `A < B` - manjše, vrne `true` če je A strogo manjši od B, drugače vrne `false`.

Konkreten primer uporabe pogojnega stavka je lahko:
```gd
extends Node2D

@export
var stevilo_srckov: int = 5

func _ready() -> void:
	if stevilo_srckov <= 0:
		print("Igre je konec")
```

Če sedaj urejate izvoženo spremenljivko `stevilo_srckov` v urejevalniku in projekt zraven poganjate, boste lahko videli, da se pri vrednostih, ki niso pozitivne, izpiše "Igre je konec".

Poglejmo si še en, malo bolj kompleksen, primer, ki vsebuje tudi stavek `else`.

```gd
extends Node2D

@export
var stevilo: int = 0

func _ready() -> void:
	if stevilo % 2 == 0:
		print("Število je sodo")
	else:
		print("Število je liho")
```

Ta kos kode bo preveril, ali je vrednost v spremenljivki `stevilo` liha ali soda. To bo dosegel s pomočjo operatorja % (ostanek pri deljenju), ki bo pri lihem številu vrnil celoštevilsko vrednost `1` in pri sodem `0`. To število nato primerjamo z `0` z uporabo operatorja `==` (je enako), ki vrne `true`, če sta leva in desna stran enaki, in `false`, če nista.

Postopek bo torej potekal takole:
1. V spremenljivko `stevilo` je nastavljena vrednost iz urejevalnika vozlišč.
2. Pognala se je koda v ```gd _ready()``` in vstopili smo v pogojni stavek.
  1. Izvedli bomo kodo v \<pogoj> torej ```gd stevilo % 2 == 0```.
  2. Najprej se bo izvedel levi del torej ```gd stevilo % 2```, ki bo vrnil `0`, če je število sodo, in `1`, če je liho.
  3. Nad rezultatom levega dela in desnim delom, ki je tokrat fiksno `0`, se bo izvedel operator `==`, ki bo vrnil `true`, če je leva stran `0`, in `false`, če je leva stran karkoli drugega (v našem primeru je lahko samo še 1).
3. Glede na to, ali je bil \<pogoj> `true` ali `false` se bo izvedel bodisi \<potem>: ```gd print("Število je sodo")``` bodisi \<drugače>: ```gd print("Število je liho")```

#box-task[Poskusite pisati različne številke v polje "Stevilo" in opazujte rezultat. Premislite, na kakšne drugačne načine bi še lahko uporabili pogojni stavek.]

#todo[Obravnavaj še logične operatorje AND, OR, NOT]

=== Več o zamikih<indents>


Morda ste opazili, da sta 8. in 10. vrstica v zgornji kodi zamaknjeni še bolj, kot smo vrstice zamikali do sedaj. Ta zamik je zelo pomemben, saj GDScript (podobno kot recimo programski jezik Python) pripadnost kode ureja z zamiki vrstic (pripadnost tu pomeni, ali je neka vrstica recimo del funkcije ali ne, oziroma v našem primeru ali je del stavka `if` ali ne). Pripadnost kode lahko hitro pogledamo, tako da se po kodi pomikamo navzgor in najdemo prvo vrstico, ki je zamaknjena en nivo manj kot trenutna.

Ko rečemo, da je nekaj zamaknjeno za "en nivo" to pomeni, da je od levega roba odmaknjeno za en tabulator. Takšna predstava je za nas čisto dovolj. Če želite o tem izvedeti malo več, preberite spodnji odsek "Za napredne uporabnike". Če rečemo, da je zamaknjen za "dva nivoja", je zamaknjen za dva tabulatorja in tako dalje. Če vmes dodajamo še kakršnekoli presledke ali uporabimo preveč tabulatorjev, nam bo Godot javil napako.

To, da kos kode pripada konstruktu, pomeni, da se bo izvedel samo v primeru, da se bo izvedel konstrukt, ki mu pripada. Če na primer del kode pripada stavku `if`, se bo izvedel samo če je trditev v tem stavku pravilna. Če pripada stavku `else`, se bo izvedel samo, če se bo izvedel stavek `else`. Če pripada funkciji `_ready`, se bo izvedel samo, če se izvede funkcija `_ready`.

Kako točno to deluje je najlažje predstaviti na primeru:

```gd
var odgovor: int = 42 # Brez zamika, pripada skripti

func _ready() -> void: # Brez zamika, pripada skripti
  if stevilka == 42: # Zamaknjen za 1 nivo, pripada funkciji _ready
    print("Odgovor je pravilen") # Zamaknjen za 2 nivoja, pripada stavku if
  else: # Zamaknjen za 1 nivo, pripada funkciji _ready
    print("Odgovor je napačen") # Zamaknjen za 2 nivoja, pripada stavku else
  print("Odgovor je obdelan") # Zamaknjen za 1 nivo, pripada funkciji _ready
```

#box-info(
  title: [#advanced-topic-heading[Za napredne uporabnike]],
  [
    GDScript podpira zamikanje vrstic s presledki ali tabulatorji. Izbira enega ali drugega je načeloma dokaj osebna stvar, Godot pa privzeto uporablja tabulatorje. Če želite to nastavitev spremeniti, se podajte v nastavitve urejevalnika (pod "Editor", nato "Editor Settings"). Pod kategorijo "Text Editor" boste v podkategoriji "Behaviour" našli nastavitev "Indent", kjer lahko zamikanje spremenite na npr. štiri presledke, kar je tudi pogosto.

    Če zamikanje spremenite, je pomembno le, da v eni datoteki uporabite izključno en način zamikanja vrstic, torej ali samo presledke ali samo tabulatorje, drugače skripte ne bodo delovale (na to vas bo opozoril tudi Godot).
  ],
)

== Funkcije<functions>

V zgornjih izsekih kode smo kar nekajkrat napisali nekaj v stilu:
```gd
print("Vrednost stevilke je: " + str(stevilka))
```

Programerji smo po naravi lena bitja, zato imajo programski jeziki konstrukte, ki nam omogočajo, da iste kode ne ponavljamo.

En najbolj uporabnih konstruktov, s tega vidika, so funkcije. Funkcije nam omogočajo, da nek kos kode poljubno ponavljamo, ne da bi morali isto kodo ponovno napisati.

Poglejmo si, kako bi iz zgornjega primera naredili funkcijo:
```gd
func izpisi_stevilko(stevilka: int):
	print("Vrednost stevilke je: " + str(stevilka))
```

```gd stevilka: int``` v prvi vrstici je posebna vrsta spremenljivke, ki ji rečemo parameter funkcije. Brez parametrov, bi bile funkcije precej omejene, saj bi lahko delale samo z globalnimi spremenljivkami. Tudi tak način dela je popolnoma v redu in pogosto bomo tudi mi napisali funkcijo, ki ne bo prejemala parametrov in bo delala samo z globalnimi spremenljivkami. Je pa velikokrat bolje narediti funkcijo, ki deluje z uporabo parametrov, saj nam omogoča, da jo kličemo z vrednostmi, ki niso na voljo globalno.

Narejeno funkcijo bi potem lahko uporabili takole:
```gd
extends Node2D

@export
var stevilo: int = 0

func _ready() -> void:
	izpisi_stevilko(stevilo)
	stevilo = stevilo + 5
	izpisi_stevilko(stevilo)

func izpisi_stevilko(stevilka: int):
	print("Vrednost stevilke je: " + str(stevilka))
```

Kodi na vrstici 7 in vrstici 9 pravimo *klic* funkcije, funkciji, iz katere kličemo, kar je v tem primeru ```gd _ready()```, pa v tem primeru pravimo *klicatelj*.

#box-info(
  title: "Kaj lahko pošljem v funkcijo?",
  [Kot parameter funkcije bi lahko poslali katerokoli vrednost, ki ustreza podatkovnemu tipu `int`. Ker GDScript nima močnega sistema za podatkovne tipe, bi lahko parameter `stevilka` pustili tudi neoznačen. V tem primeru bi nam GDScript dovolil poslati katerokoli vrednost, a bi se napaka potem lahko zgodila nekje znotraj same funkcije, ker določenega tipa morda ne bi pričakovala.

    Zgornjo funkcijo bi na primer lahko spremenili v:
    ```gd
    func izpisi_vrednost(vrednost):
    	print("Vrednost je: " + str(vrednost))
    ```

    Takšna funkcija bi sprejela katerokoli vrednost in bi tudi pravilno delovala v vseh primerih, kjer je `vrednost` mogoče spremeniti v niz (s klicem ```gd str()```). Takšne splošno namenske funkcije tudi obstajajo znotraj Godot projekta in so včasih uporabne, čeprav imajo parametri ponavadi vseeno kakšno drugo omejitev.
  ],
)

Naredimo še en primer funkcije brez parametrov:
```gd
func pozdravi_svet():
	print("Pozdravljen svet!")
```

=== Vračanje vrednosti

Funkcije lahko neko vrednost tudi "vrnejo". To pomeni da na točki, kjer smo funkcijo klicali, po končanem klicu dobimo vrednost, ki je rezultat kode izvajane v tej funkciji.

#box-task[Prepišite primer z naslovom (iz #ref(<exported-variables>, supplement: "poglavja")) v funkcijo, ki kot parametre prejme podatke o prejemniku in na izhod napiše naslov.]

#box-task[
  Poskusimo združiti vse, kar smo se naučili o GDScriptu do sedaj.

  Naredite nov prizor z novim korenskim vozliščem tipa #node2d-type-name("Node2D"). Izdelajte novo GDScript datoteko z imenom `kalkulator.gd` in jo pripnite na novo vozlišče.

  V tej datoteki izdelajte manjši kalkulator. Podpira naj operacije seštevanja, odštevanja, množenja, deljenja in ostanka pri deljenju celih števil.

  Obe števili in operacija naj bodo izvožene spremenljivke, ki se jih da urejati v urejevalniku vozlišč. Izbira operacije naj bo predstavljena kot celo število, kjer 0 pomeni seštevanje, 1 odštevanje, 2 množenje, ...

  Rezultat izpišite na izhod v obliki:
  #codly-disable()
  ```
  <število1> <operacija> <število2> = <rezultat>
  ```
  Primer:
  ```izhod
  6 * 7 = 42
  ```
  #codly-enable()

  Na koncu skripte je v #ref(<example-calculator-implementation>, supplement: "poglavju") primer takšnega programa, ki si ga lahko ogledate če se vam kje zatakne, a *najprej poskusite sami!*
]

== Sestavljeni tipi <composite-types>

Do sedaj smo večinoma delali samo z enostavnimi tipi kot so `bool`, `int` ali `float`, ki so sestavljeni iz samo ene vrednosti, oziroma s tipi, ki svojo kompleksnost pred nami precej dobro skrivajo (kot je tip `String`). Obstaja pa še mnogo drugih bolj kompleksnih ali _sestavljenih_ tipov.

#box-info(title: [#advanced-topic-heading[Za napredne uporabnike]], [
  Nekateri drugi programski jeziki med seboj ločujejo koncept sestavljenega tipa in razreda, Godot te ločitve nima. Praktično vse, razen osnovnih primitivnih tipov, je razred.

  O razredih bomo še nekaj malega povedali v #ref(<classes-and-extends>, supplement: "poglavju"), a se vanje podrobneje ne bomo spuščali, saj je to izven obsega te poletne šole.
])

Posebnost sestavljenih tipov je, da sami v sebi vsebujejo mnogo spremenljivk in pogosto tudi funkcije. Poglejmo si primer na vgrajenem sestavljenem tipu `Vector2`.

#box-info(title: "O tem podrobneje kasneje", [
  Več o vgrajenih funkcijah, spremenljivkah in tipih bomo povedali v #ref(<GodotAPI>, supplement: "poglavju"). Trenutno samo verjemite, da `Vector2` obstaja in ga lahko uporabljamo.
])

`Vector2` predstavlja dvodimenzionalni vektor. Sestavljata ga dve spremenljivki, spremenljivka x (x ali vodoravna komponenta vektorja) in y (y ali navpična komponenta vektorja).

Izdelava sestavljenih tipov zgleda podobno kot klic funkcije. Za ime sestavljenega tipa v navadna oklepaja napišemo parametre iz katerih bo tip potem sestavljen. V primeru `Vector2` najprej napišemo x in nato y komponento vektorja.

Spremenljivkam sestavljenega tipa pravimo _lastnosti_. Poglejmo si primer izdelave `Vector2`, ki mu lastnost `x` nastavimo na 6 in lastnost `y` na 7.

```gd
# x=6, y=7
var test = Vector2(6, 7)
```

Večino vgrajenih sestavljenih tipov zna Godot tudi spremeniti v niz (torej tudi enostavno izpisati na izhod). `Vector2` tu ni izjema:

```gd
func _ready() -> void:
	var vektor = Vector2(6, 7)
	print(vektor)
```

```izhod
(6.0, 7.0)
```

Če želimo lastnost sestavljenega tipa spremeniti po izdelavi, oziroma lastnost prebrati, to storimo z operatorjem `.` (pika). Na to kar nam ta operator vrne, lahko gledamo kot na navadno spremenljivko, ki jo lahko beremo in nastavljamo. Če razširimo zgornji primer:

```gd
var vektor = Vector2(6, 7)
print(vektor)
vektor.x = 42
print(vektor)
print(vektor.y)
```
```izhod
(6.0, 7.0)
(42.0, 7.0)
7.0
```

=== Klic funkcij sestavljenih tipov

Kot smo že omenili, lahko sestavljeni tipi definirajo tudi funkcije. Funkcijam na sestavljenih tipih pravimo _metode_. 
Posebnost metod je, da imajo do sestavljenega tipa, na katerih jih kličemo, dostop same po sebi. Ni jim ga potrebno podati kot parameter. To nam omogoča, da je koda bolj berljiva, saj je takoj očitno nad čim operacijo izvajamo.


Poglejmo si primer:
```gd
var vektor = Vector2(3, 4)
# Opazite, da funkciji length spremenljivke vektor nismo poslali kot parameter
# (nismo napisali length(vektor)), ker jo je kot metoda sestavljenega tipa Vector2D
# prejela kar sama.
var dolzina = vektor.length()
print("Dolžina vektorja " + str(vektor) + " je: " + str(dolzina))
```
```izhod
Dolžina vektorja (3.0, 4.0) je: 5.0
```

#box-warning[
  Metode niso nek magičen tip funkcije, ki vse potrebne parametre same najdejo iz okolja. Vse, kar metoda prejme avtomatsko, je vrednost sestavljenega tipa, na katerem je klicana (vrednost spremenljivke na kateri smo za klic uporabili `.` operator). V našem zgornjem primeru je to spremenljivka `vektor`.

  Tudi metode (precej pogosto) zahtevajo parametre za svoje delovanje. Primer lahko hitro najdemo že na `Vector2`, ki definira več deset metod, ki zahtevajo dodatne parametre. Ena od teh je metoda ```gd dot(with: Vector2)```, ki kot parameter zahteva še en `Vector2` in nato med seboj (vrednostjo, ki jo sama dobi ob klicu) in drugim vektorjem, ki ga dobi kot parameter, izračuna skalarni produkt.

  ```gd
  var vektor = Vector2(0, 1)
  var vektor2 = Vector2(1, 0)
  var skalarni_produkt = vektor.dot(vektor2)
  print("Skalarni produkt med vektorjem " + str(vektor) +  " in vektorjem " + str(vektor2) + " je: " + str(skalarni_produkt))
  ```
  ```izhod
  Skalarni produkt med vektorjem (0.0, 1.0) in vektorjem (1.0, 0.0) je: 0.0
  ```
]


== Zanke in seznami

Še eno nujno orodje v programerjevi bitki proti ponavljanju kode so zanke. Zanke nam omogočajo enostavno ponavljanje kode, ki bi se zagnala večkrat zaporedno.

Na primer:
```gd
# Štetje do 10
print("1")
print("2")
print("3")
# <še 6 ponovitev>
print("10")
```

Zdaj si predstavljajte, da bi morali šteti do 100, ali 1000, ali pa v bolj realnem primeru, izvesti operacijo nad vsakim ogliščem 3D modela. Na primer, model na #ref(<boulder-example>, supplement: [sliki]) je sestavljen iz 124 tisoč trikotnikov.

#screenshot(
  path: "assets/poly-haven/boulder_01.webp",
  width: 50%,
  caption: [Model kamna, ki ima 124 tisoč trikotnikov. \ (Vir: Poly Haven, Licenca: CC0)],
) <boulder-example>

Ker takšnega Sizifovega dela ne želi nihče opravljati, imamo tudi za to programske konstrukte. Zgodnji primer bi torej lahko napisali kot:
```gd
var i = 1
while(i <= 10):
  print(i)
  # operator += je samo okrajšava za i = i+1, torej i=i+1 je ekvivalentno i+=1
  i += 1
print("Končali smo s štetjem.")
```

Zgoraj smo uporabili `while` zanko. `while` lahko beremo kot `izvajaj kodo, dokler je pogoj izpolnjen` in se jo piše kot:
```gd
while(<pogoj-za-izvajanje>):
  <koda-izvedena-vsako-ponovitev>
```
Kjer je `<pogoj-za-izvajanje>` koda, katere rezultat je tipa `bool` in je `<koda-izvedena-vsako-ponovitev>` poljubna koda, ki jo želimo izvesti vsako ponovitev zanke.

Zanka se bo izvajala, dokler bo `<pogoj-za-izvajanje>` enak `true`.

Oglejmo si zgornji primer korak za korakom:
1. Spremenljivka `i` je nastavljena na `1`.
2. Vstopimo v zanko. \
  2.1. `<pogoj-za-izvajanje>` se izvede, v našem primeru je to ```gd i <= 10```, dokler bo `i` manjši ali enak 10, bo torej naš pogoj `true` v vseh ostali primerih (torej če bo večji od 10) pa bo `false`. V primeru da pogoj ne drži (`false`) skočimo na točko 3.
  #box-warning[Ni nujno, da se `<koda-izvedena-vsako-ponovitev>` sploh kdaj izvede! Če je pogoj za izvajanje `false`, še pred prvo ponovitvijo, potem se zanka ne bo izvedla nikoli in se bo takoj začela izvajati koda, ki je za zanko.]

  2.2. Izvede se koda znotraj zanke. Na izhod se izpiše vrednost znotraj `i` in takoj za tem se `i` poveča za 1.

  2.3. Skočimo nazaj na točko 2.1.

3. Izstopimo iz zanke in nadaljujemo z izvajanjem ostale kode (napisane po zanki). V našem primeru je to `print` na vrstici 6.

#box-task[Napišite skripto, ki izvozi spremenljivki ```gd besedilo: String``` in ```gd st_ponovitev: int```, ter nato na izhod izpiše `besedilo` `st_ponovitev`-krat.]

=== Seznami

Seznam nam predstavlja zaporedje elementov. Seznami v GDScriptu, v nasprotju z nekaterimi drugimi bolj strogimi jeziki, dovolijo, da ima vsak element drugačen podatkovni tip.

Seznam naredimo tako, da spremenljivki dodelimo podatkovni tip `Array`, oziroma tako, da izdelamo nov `Array` in ji ga dodelimo. `Array` izdelamo tako da med znaka `[` in `]` naštejemo vse njegove elemente.

```gd
var seznam: Array # Izdela prazen seznam.
var seznam2 = [] # Enako kot zgoraj: izdela prazen seznam.
var seznam_z_nekaj_elementi = [6, 7, 42] # Izdela seznam, ki vsebuje 6, 7 in 42.

# Seveda lahko spremenljivki seznama eksplicitno dodelimo tip
# in jo hkrati tudi izdelamo z že nekaj začetnimi elementi.
var seznam3: Array = [6, 7, 42]

# Godot pusti izdelavo seznama, v katerem je vsak element drugačnega tip
# je pa to grda praksa, ki jo odsvetujemo.
var katastrofa = [42, "pozdravljen", false, -6.7]
```


#box-info(
  title: "Priporočilo",
  [Čeprav nam GDScriptovi seznami dovolijo, da so podatkovni tipi elementov precej "pisani" (vsak element je lahko drugačen), se to šteje kot zelo slaba praksa in se ji poskusite izogibati. GDScript vas bo pred tem do neke mere varoval, če mu boste to eksplicitno povedali.

    ```gd
    # Vedno pusti karkoli.
    var prost_seznam: Array

    # V nekaterih primerih pusti samo celoštevilski tip.
    var strog_seznam: Array[int]
    ```

    Priporočeno je da se uporablja stil na vrstici 5!
  ],
)

Seznami so sestavljen tip in vsebujejo metode za delo z njimi. Element lahko na primer dodamo s klicem metode ```gd append(value: Variant)```. Funkcija `append`, po slovensko "pripni", doda element na konec seznama. Poglejmo si primer:

```gd
var seznam: Array[int] = [1, 2]
print(seznam)
seznam.append(3)
print(seznam)
```
```izhod
[1, 2]
[1, 2, 3]
```

Element lahko iz seznama dobimo z operatorjem `[]`. Vanj pošljemo _indeks_ (oziroma mesto) iz katerega želimo pridobiti element. GDScript začne šteti pri 0, tako da nam bo indeks 0 vrnil prvi element, indeks 1 drugi element, 2 tretji in tako dalje.

```gd
var seznam: Array[int] = [1, 2, 3]
print(seznam[1])
```
```izpis
2
```

Pogosta operacija, ki jo izvajamo nad seznami, je tudi, da naredimo nekaj z vsakim elementom. Verjetno lahko vidite, kako so tu lahko zanke še posebej uporabne.

#box-task[
  Poskusite sami razmisliti, kako bi z zanko naredili nekaj z vsakim elementom seznama. Poskusite na primer vsak element izpisati na izhod. V pomoč naj vam bo metoda ```gd size()```, ki vam pove kako dolg je nek seznam.

  Če imate pri tem težave si lahko pogledate primer v #ref(<array-looping-example>, supplement: "poglavju").
]

Ker je obdelava vsakega elementa v seznamu nekaj, kar se v programiranju počne zelo pogosto, nam GDScript nudi lažji način, da dosežemo isto, v obliki `for .. in` zanke.

Zgleda nekako takole:

```gd
for <ime-elementa> in <ime-seznama>:
	<kos-kode-v-kateri-obdelujemo-element>
```

`<ime-elementa>` je ime ki si ga sami izmislimo, in skozi katerega bomo znotraj zanke dostopali do posameznega elementa. Godot bo za nas na tej točki v bistvu izdelal spremenljivko z imenom `<ime-elementa>`, ki bo uporabna samo znotraj zanke. `<ime-seznama>` je ime seznama iz katerega bomo elemente vlekli. `<kos-kode-v-kateri-obdelujemo-element>` pa je koda, ki jo napišemo, in bo pognana za vsak element v seznamu v spremenljivki `<ime-seznama>`.

Zgornjo nalogo bi lahko s tem konstruktom rešili takole:

```gd
var seznam: Array[int] = [1, 2, 3]
for element in seznam:
	print(element)
```

Godot zna izvoziti tudi spremenljivke, katerih podatkovni tip je seznam. Če naredimo to, bomo v urejevalniku vozlišč opazili poseben vmesnik.

```gd
@export
var seznam: Array[int]
```

#screenshot(
  path: "assets/gd-script/exported-array.png",
  width: 50%,
  caption: [Uporabniški vmesnik za urejanje izvoženega seznama.],
)

S kliki na `Add Element` (Dodaj element) in ostale dele vmesnika, lahko potem dodajamo, brišemo in urejamo elemente v seznamu.

#screenshot(
  path: "assets/gd-script/exported-array2.png",
  width: 50%,
  caption: [Uporabniški vmesnik za urejanje izvoženega seznama.],
)

#box-info(title: "Kaj pa gnezdeni seznami?", [
  Godot za časa pisanja ne podpira gnezdenih tipiranih seznamov (gnezden seznam je seznam v seznamu). Če poskusimo izdelati gnezden tipiran seznam bomo dobili napako.

  ```gd
  # Deluje
  var seznam: Array[int]

  # Deluje
  var seznam2: Array[Array]

  # NE deluje
  var seznam3: Array[Array[int]]

  # Prav tako ne deluje (čeprav so programsko seznami lahko gnezdeni globlje kot
  # dva nivoja, bi bil drugi seznam v tem primeru eksplicitno tipiran).
  var seznam4: Array[Array[Array]]
  ```
])



#box-task[
  Uredite kalkulator, ki ste ga naredili v #ref(<functions>, supplement: "poglavju") tako, da ne bo več izvažal spremenljivk številka 1 in 2, ampak bo izvozil eno spremenljivko tipa ```gd Array[int]``` in nato izvedel izbrano operacijo na vseh elementih.

  Na primer, če bi mu v urejevalniku nastavili izvoženo spremenljivko `stevilke` na [1, 2, 3, 4] in mu naročili naj izvede operacijo seštevanje (0), bi izpisal:
  #codly-disable()
  ```
  1 + 2 + 3 + 4 = 10
  ```

  Če bi mu v urejevalniku nastavili izvoženo spremenljivko `stevilke` na [20, 10, 5] in mu naročili naj izvede operacijo odštevanje (1), bi izpisal:

  ```
  20 - 10 - 5 = 5
  ```
  #codly-enable()

  Dovolj je, če kalkulator podpira samo seštevanje in odštevanje, a se lahko poigrate in poskusite dodati tudi druge operacije.

  Če se med reševanjem naloge zataknete, si lahko pomagate s primerom v #ref(<example-calculator-with-arrays-implementation>, supplement: "poglavju"), a *naprej poskusite sami!*
]

== Uporaba Godot API (vgrajene funkcije, spremenljivke in tipi)<GodotAPI>

Vse, kar smo naredili do sedaj, se da narediti tudi v praktično kateremkoli drugem programskem jeziku. Prišel pa je čas, da se skozi GDScript začnemo pogovarjati z dejanskim pogonom. Kot je bilo omenjeno že prej, je GDScript namenski jezik, ki je bil narejen samo za uporabo v pogonu Godot in ima nekaj unikatnih in specializiranih konstruktov samo za komuniciranje s tem pogonom.

O teh specializiranih konstruktih bomo malo več povedali kasneje, najprej pa osredotočimo samo na to, kako lahko kličemo vgrajene funkcije Godot API in kako Godot kliče naše funkcije.

#box-info(title: [Kaj je _API?_], [
  _API_ ali _Application Programming Interface_ (slov. APV oziroma aplikacijski programski vmesnik) je nabor pravil in dogovorov, ki dvema različnima kosoma programske opreme omogoča, da komunicirata med seboj. Ko govorimo o Godot API, se večinoma nanašamo na vgrajene funkcije, ki nam jih Godot daje na voljo in preko katerih lahko uporabljamo funkcije pogona.
])

=== Klic naših funkcij

Ponovno si poglejmo začetno predlogo, ki nam jo Godot naredi, ko naredimo novo GDScript skripto.

```gd
extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

```

Če ste prebrali angleški opis, ki ga doda Godot, vam je verjetno že deloma jasno, kaj se tu dogaja.
```gd func _ready()``` je rezervirano ime funkcije, ki se jo lahko definira v vsaki skripti, ki razširja tip `Node` (več o razširjanju kasneje).

Če definiramo tako funkcijo, jo bo Godot klical, ko bo to vozlišče vstopilo v drevo vozlišč. Do sedaj smo to funkcijo izkoriščali, da smo zaganjali kodo ob zagonu igre. Kar se v resnici zgodi ob zagonu je, da Godot zažene naš prizor, v katerem so vozlišča in nato za vsako vozlišče pogleda ali definira ```gd _ready()```. Če ga najde, to funkcijo pokliče.

#box-task[
  V svoj prizor dodajte še nekaj vozlišč tipa #node2d-type-name("Node2D"). Na vsako pripnite skripto. Kako te skripte poimenujete, trenutno ni pomembno.  Ime lahko pustite tudi takšno, kot vam ga ponudi Godot. V vsaki od teh skript, v funkciji ```gd _ready()``` na izhod izpišite nekaj drugega in opazujte, kakšen je izpis ob zagonu igre.

  Ko prizor nehate preizkušati, vozlišča, ki ste jih naredili tudi izbrišite. To lahko dosežete tako, da vozlišče izberete kliknete #kbd("Delete") in v novem oknu izbris potrdite s klikom na gumb "Delete".
]

Obstaja še nekaj funkcij, ki delujejo podobno. Funkcija ```gd _process(delta: float)``` je na primer klicana vsakič, ko Godot izdeluje naslednjo upodobljeno sličico (to, kar se nam izriše na zaslon; angl. _frame_). V tem primeru nam Godot v parameter funkcije `delta` zapiše, koliko časa je preteklo, odkar je bila narejena prejšnja upodobljena sličica (v sekundah). Kar nekaj takih funkcij si bomo pogledali kasneje v programu, zaenkrat pa si zapomnite samo delovanje funkcij ```gd _ready()``` in ```gd _process(delta: float)```.

#box-info(title: [Spet sličica? A ni to angl. _sprite_?], [
  Ko govorimo o upodobljenih sličicah (angl. _frame_) se znotraj vsaj tega dokumenta nanašamo na sličice, ki jih Godot med tekom riše in prikazuje na zaslon. Če je igra dobro narejena, jih prikaže vsaj 60 na sekundo, torej približno vsakih $16.67$ milisekund.

  Teh sličic ne mešajte s sličicami s področja sredstev (angl. _sprite_), na primer plahtami sličic (angl. _spritesheet_). V tem drugem primeru gre za sredstva, uvožena v igro v procesu razvoja.
])

#figure(
  align(
    center,
    cetz.canvas({
      import cetz.draw: line, set-style

      let default-background-color = rgb("#353232")
      let green = rgb("#3bc20a")
      let blue = rgb("#2ba2da")
      let red = rgb("#e9130b")

      let node(name, background-color: default-background-color, style: "normal") = {
        box(
          fill: background-color,
          inset: 5pt,
          radius: 4pt,
          text(
            fill: white,
            weight: "bold",
            style: style,
            size: base-font-size - 1pt,
            name,
          ),
        )
      }

      // Draws a triangle mark at both ends of the line.
      set-style(mark: (end: "straight"))

      cetz.tree.tree(
        spread: 0.2,
        grow: 0.54,
        (
          node("Vozlišče je izdelano", background-color: green),
          (
            node("Vozlišče vstopi v drevo (klic _ready())", background-color: blue),
            (
              node("Vozlišče je v izvajanju (redni klici _process())", background-color: blue),
              (
                node("Vozlišče je odstranjeno iz drevesa in uničeno", background-color: red),
              ),
            ),
          ),
        ),
      )
    }),
  ),
  caption: [Zelo osnoven prikaz življenjskega cikla vozlišča.],
) <simple-node-lifecycle>

#box-info(title: [#advanced-topic-heading[Za napredne uporabnike]], [
  Dejanska zgodba življenjskega cikla vozlišča je v resnici mnogo bolj kompleksna kot zgornja poenostavitev. Možnih stanj je mnogo več in vozlišče lahko prosto prehaja med njimi, tudi v drugo smer! Na primer: vozlišče, ki je bilo umaknjeno iz drevesa, se lahko ponovno vrne vanj. #ref(<node-lifecycle>, supplement: [Slika]) prikazuje mal bolj podroben prikaz življenjskega cikla (a še vedno ne popolnega):

  #v(8pt)

  #{
    let default-background-color = rgb("#353232")
    let green = rgb("#3bc20a")
    let gray = rgb("#746f6f")
    let blue = rgb("#2ba2da")
    let red = rgb("#e9130b")

    let node(name, background-color: default-background-color, style: "normal") = {
      block(
        above: 0pt,
        below: 0pt,
        fill: background-color,
        inset: (
          x: 6pt,
          y: 8pt,
        ),
        radius: 4pt,
        align(
          center,
          text(
            fill: white,
            weight: "bold",
            style: style,
            size: base-font-size - 1pt,
            name,
          ),
        ),
      )
    }

    let node-details = (value) => {
      text(
        size: base-font-size - 2pt,
        weight: "bold"
      )[
        #set par(leading: 5pt)
        #value
      ]
    };

    figure(
      align(
        center,
        fletcher.diagram(
          node-inset: 2pt,
          spacing: 1.5em,
          fletcher.node(
            (0, 0),
            node(
              [
                Vozlišče je izdelano.
                #node-details[
                  (klic `PackedScene.instantiate()`)
                ]
              ],
              background-color: green
            )
          ),
          fletcher.edge("-|>"),
          fletcher.node(
            (0, 1),
            node(
              [
                Vozlišče vstopi v drevo.
                #node-details[
                  (povratni klic `_enter_tree()`)
                ]
              ],
              background-color: gray
            )
          ),
          fletcher.edge("-|>"),
          fletcher.node(
            (0, 2),
            node(
              [
                Vsi otroci vozlišča vstopijo v drevo, \
                vozlišče je pripravljeno za izvajanje.
                #node-details[
                  (povratni klic `_ready()`)
                ]
              ],
              background-color: blue,
            )
          ),
          fletcher.edge("-|>"),
          fletcher.node(
            (0, 3),
            node(
              [
                Vozlišče je v izvajanju.
                #node-details[
                  (povratni klici `_process()`, \ `_physics_process()`, ...)
                ]
              ],
              background-color: blue,
            )
          ),
          fletcher.edge("-|>"),
          fletcher.node(
            (0, 4),
            node(
              [
                Vozlišče izstopi iz drevesa. \
                #text(
                  weight: "regular",
                  [Vozlišče še vedno obstaja in se \ lahko teoretično vrne v drevo.]
                )
                #node-details[
                  (povratni klic `_exit_tree()`)
                ]
              ],
              background-color: gray,
            )
          ),
          fletcher.edge(
            (0, 4),
            (1, 4),
            (1, 2),
            (0, 2),
            "-|>"
          ),
          fletcher.edge("-|>"),
          fletcher.node(
            (0, 5),
            node(
              [
                Vozlišče je uničeno in se ne more več vrniti v drevo.
              ],
              background-color: red
            )
          ),
        )
      ),
      caption: [Bolj podroben prikaz življenjskega cikla vozlišča.],
    )
  } <node-lifecycle>

  V zgornji figuri zelena in rdeča predstavljata začetek in konec cikla, siva predstavlja stanja kjer vozlišče obstaja nepripeto v drevo (takrat ni "živo"), modra pa stanja v katerih se vozlišče aktivno izvaja.
])

=== Klic Godotovih funkcij <calling-godot-functions>

Klic funkcij, ki nam jih nudi Godot, je v bistvu zelo preprost. Kličemo jih na čisto enak način, kot bi klicali naše lastne funkcije. Glavni problem vgrajenih funkcij je v bistvu njihova ogromna količina. V praksi ni mogoče poznati vseh (avtorja tega učbenika jih recimo skupaj zagotovo na pamet poznata manj kot 5 %), zato se je pogosto potrebno zanašati na Godotovo dokumentacijo. Le-to lahko najdemo na #link("https://docs.godotengine.org/en/stable"). Godot dokumentacija je orjaška in sprva precej strašljiva, zato se je je najbolje lotiti po manjših kosih. Branje dokumentacije je umetnost, ki jo boste izpilili z leti svojih programerskih dogodivščin in vam bo prišla še mnogokrat prav.

Poskusimo zdaj poklicati neko vgrajeno funkcijo. Godot na podskupini tipov #node2d-type-name("Node2D") nudi vgrajeno funkcijo ```gd void rotate(radians: float)```, dokumentacijo zanjo lahko najdemo na: \ #link("https://docs.godotengine.org/en/stable/classes/class_node2d.html#class-node2d-method-rotate").

#box-info(title: "Kaj so že radiani?", [
  Radiani so enota, ki jo uporabljamo pri merjenju kotov. Velja pretvorba $pi = 180 degree$, torej $pi$ (pi) radianov je $180 degree$ ali iztegnjen kot.
])

Ob klicu funkcije bo Godot vozlišče zavrtel za `radians` radianov. Če želimo vozlišče počasi in konstantno vrteti, ga moramo torej vsako sličico malo obrniti. Spomnimo se funkcije ```gd _process(delta: float)```, ki smo jo omenili malo prej in jo Godot kliče vsakič ko izdeluje novo sličico. To znanje lahko potem združimo v navidez zelo preprost kos kode:

```gd
extends Sprite2D


func _process(delta: float) -> void:
	rotate(delta)
```

Če tako skripto pripnemo na vozlišče tipa #node2d-type-name("Sprite2D") in projekt poženemo, lahko vidimo kako se vozlišče počasi vrti.

#box-task[Naredite novo vozlišče tipa #node2d-type-name("Sprite2D"), mu nastavite sličico in ga premaknite na sredino zaslona. Najprej se morate seveda vrniti v okolje 2D s klikom na "2D" v vrstici za izbiro okolja. Nato se vrnite v urejevalnik besedil in nanj pripnite skripto, ki vsebuje zgodnji kos kode. Zaženite trenuten prizor in opazujte kaj se dogaja z vašo sličico.]

=== Uporaba vgrajenih spremenljivk <using-godot-properties>

Definiranje funkcij, ki jih Godot kliče in klicanje Godotovih funkcij ni edini način komunikacije s pogonom. Godot nam med drugim nudi tudi dostop do vgrajenih spremenljivk, ki jih lahko beremo ali pa v njih tudi pišemo.

Primer take vgrajene spremenljivke je `position`, ki jo najdemo na tipu vozlišča #node2d-type-name("Node2D") in njegovih potomcih.

#box-info(title: [Uradna dokumentacija])[
  Pogosto je fino prebrati tudi dokumentacijo, ki nam jo ponuja že sam pogon Godot. Tokrat lahko dokumentacijo o vozlišču Node2D in polju `position` najdemo na: \ https://docs.godotengine.org/en/stable/classes/class_node2d.html#class-node2d-property-position
]

Poglejmo si primer uporabe:

```gd
func _process(delta: float) -> void:
  # delto smo tu množili s 100, ker je delta sama po sebi zelo majhno število
  # in bi se drugače naše vozlišče premikalo zelo počasi
  position += Vector2(0, delta * 100)
```

`position` na #node2d-type-name("Node2D") Godotu interno predstavlja _lokalno_ pozicijo vozlišča, relativno na njegovega starša. S tem, da to vgrajeno spremenljivko spreminjamo, Godotu posodabljamo to vrednost in mu posredno sporočamo, kje na zaslonu naj to vozlišče nariše. Ker mu vsako upodobljeno sličico `y` koordinato vektorja `position` malo povečamo, se naše vozlišče skozi čas počasi pomika navzdol. (Spomnimo se da koordinatno izhodišče `(0, 0)`, Godot privzeto postavlja v zgornji levi kot, torej `y` narašča navzdol in `x` desno).

#box-info(title: "+= na Vector2D?", [
  Nekateri sestavljeni tipi nam omogočajo da z uporabo "navadnih" aritmetičnih in logičnih operatorjev (+, -, \*, ...) izvajamo operacije nad njimi. Eden od teh je tudi `Vector2D`, pri katerem + in - predstavljata seštevanje in odštevanje vektorjev po komponentah. Informacije o operatorjih, ki jih lahko nad sestavljenim tipom uporabljate, si lahko seveda preberete na Godot dokumentaciji pod odsekom "Operator descriptions". (Za `Vector2D` je to: https://docs.godotengine.org/en/stable/classes/class_vector2.html#operator-descriptions)

  Spomnimo se tudi da je `+=` samo okrajšava za `= vrednost +` torej:

  ```gd
  position += Vector2(0, delta * 100)
  # je enako kot
  position = position + Vector2(0, delta * 100)
  ```
])

#box-task[Poskusite sami najti dokumentacijo o vgrajeni spremenljivki `global_position` in razmislite kakšna je razlika med njo in med spremenljivko `position`.]

#box-info(title: "Pohitritev iskanja dokumentacije", [
  Če delamo znotraj vgrajenega urejevalnika besedil (kar tekom poletne šole počnemo), lahko kadarkoli, medtem ko na tipkovnici držimo tipko `Ctrl`, kliknemo na nek vgrajeni tip, funkcijo ali spremenljivko. Če to naredimo, se nam bo odprla vgrajena dokumentacija, ki nam jo Godot nudi znotraj pogona in po kateri lahko tudi brskamo. To je priročen in lahek način branja dokumentacije, ki deluje tudi brez dostopa do interneta, in preko katerega si lahko na hitro odgovorimo na kakšno vprašanje glede Godot API-ja. Moramo pa za takšno početje vsaj poznati ime Godot konstrukta, ki ga iščemo.

  #screenshot(
    path: "assets/gd-script/builtin-docs.png",
    width: 100%,
    caption: [Primer vgrajene dokumentacije za `Vector2D`.],
  ) <builtin-docs>
])

== Razredi in razširitve <classes-and-extends>

Razredi so zelo kompleksno področje programiranja, o katerih je bilo napisanih že kar nekaj zajetnih in zloglasnih knjig. Za nas razredi niso spet tako pomembni in se v njihove podrobnosti tekom te poletne šole ne bomo spuščali. Resno se nas tiče samo en del, ki ga bomo na hitro omenili, in to so razširitve.

=== Razširitve

V #ref(<gdscript-and-nodes>, supplement: "poglavju") smo na hitro omenili prvo vrstico vsake GDScript datoteke in sicer stavek `extends`.

Kaj ta vrstica v resnici naredi je, da pove Godotu kateri razred ta datoteka razširja. S tem izdelamo nov (zaenkrat neimenovan) razred, ki je podedoval vse lastnosti razreda ki ga razširja.

To za nas ni pomembno samo za to, da se ognemo napake omenjene v #ref(<gdscript-and-nodes>, supplement: "poglavju"), ampak tudi zato, ker nam ta razred pove do katerih Godotovih vgrajenih funkcij (in še nekaj drugih Godotovih konstruktov) imamo dostop.

#box-info(title: "Poenostavitev", [
  Razrede lahko za lažjo predstavo za čas poletne šole enačite s tipi vozlišč. Od tu naprej se bo namesto "razred" uporabljal izraz "tip vozlišča".
])

GDScript skripta, ki razširja #node2d-type-name("Node2D") ima, na primer, dostop do manj funkcij kot skripta, ki razširja #node2d-type-name("Sprite2D"). Do tega pride, ker je #node2d-type-name("Sprite2D") potomec #node2d-type-name("Node2D"). Osnovno hierarhijo tipov vozlišč ste spoznali že v #ref(<basic-node-types>, supplement: "poglavju"), velja pravilo, da ima otrok nekega tipa vozlišča vedno vse funkcionalnosti svojega starša in mogoče še kakšne dodatne.

Če želimo lahko novi tip vozlišča, ustvarjen z GDScript datoteko, tudi poimenujemo. To storimo tako, da na vrh datoteke napišemo:

```gd
class_name VrteciSprite
extends Sprite2D
```

V tem primeru smo naredili nov tip vozlišča imenovan `VrteciSprite`. Če bomo izdelovali novo vozlišče, nam ga bo Godot celo ponudil v oknu za izbiro tipa. Znotraj poletne šole bomo to funkcionalnost nekajkrat uporabili za lažje dokumentiranje kode in razlago, a se tudi v to podrobnost ne bomo preveč spuščali.

Več o tem kakšne funkcionalnosti nam kateri tip vozlišča nudi, si lahko preberemo v Godotovi dokumentaciji. Seznam vseh tipov vozlišč (v abecednem vrstnem redu) je, na primer, dostopen na: https://docs.godotengine.org/en/stable/classes/index.html#nodes. Med njimi lahko, v morju ostalih tipov, prepoznate že znana #node2d-type-name("Node2D") in #node2d-type-name("Sprite2D").

#pagebreak(weak: true)
= Premikanje in uporabniški vnos <movement-and-input>

Zdaj lahko zapremo prizor, v katerem smo preizkušali GDScript, in se vrnemo nazaj na prizor, kjer nas čakajo dinozaver in kaktusi. Prizor, v katerem smo se igrali med učenjem osnov GDScripta, lahko po želji izbrišete ali pa pustite, če se vam zdi, da vam bo koda v njemu še kdaj prišla prav.

Iz prizora brišite vozlišča tipa #node2d-type-name("Sprite2D"), dokler vam ne ostane samo dinozaver in en kaktus. Vaš prizor bi potem moral izgledati približno tako kot na #ref(<user-input-starting-point>, supplement: "sliki"). Ne pozabite preimenovati vozlišča, ki vsebuje kaktus na `KaktusSlicica`.

#screenshot(
  path: "assets/user-input/starting-point.png",
  width: 100%,
  caption: [Poenostavljen prvotni prizor.],
) <user-input-starting-point>

Trenutno je prizor precej dolgočasen in statičen. Naredimo najprej, da se ob zagonu projekta kaktus počasi pomika proti nam.

#box-task[
  Na vozlišče `KaktusSlicica` pripnite skripto `kaktus.gd`, ki ob zagonu kaktus premika proti dinozavru (levo po zaslonu). Pri izdelavi skripte si pomagajte s #ref(<using-godot-properties>, supplement: "poglavjem").

  Ne pozabite, da je Godotovo privzeto koordinatno izhodišče (0, 0) _levo zgoraj_. X in Y torej rasteta desno in navzdol, kar lahko razumemo tudi kot: če večamo X, se premikamo desno, če večamo Y, se premikamo navzdol.

  Če imate z izdelavo skripte še vedno težave, si lahko ogledate #ref(<moving-cactus-example>, supplement: "poglavje"), vseeno pa kot vedno *najprej poskusite sami!* Zahtevana skripta je tokrat res preprosta, tako da verjamemo v vaš uspeh!
]

Kaktus bi zdaj moral uspešno drseti proti nam. Naš dinozaver pa na žalost še vedno nima možnosti umika. Tudi nanj bi lahko pripeli skripto, ki bi ga premikala proč od kaktusa, vendar to ni cilj naše igre. Z dinozavrom mora upravljati igralec sam.

== Uporabniška dejanja

V Godotu lahko uporabniški vnos obdelujemo na več načinov. Na tej delavnici se bomo osredotočili le na enega. Če želite o uporabniškem vnosu izvedeti več, si oglejte vsebine v #ref(<additional-reading>, supplement: "poglavju").

=== Urejanje uporabniških dejanj

Mi se bomo uporabniškega vnosa lotili skozi Godotov sistem uporabniških dejanj. Uporabniško dejanje lahko izdelamo skozi Godotov vmesnik.

To naredimo tako, da najprej kliknemo na "Project", nato "Project Settings", s čimer odpremo nastavitve projekta (ne nastavitev urejevalnika), in nato v novem oknu kliknemo na zavihek "Input map".

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/user-input/project-settings.png",
        width: 35%,
        caption: [Navigacija do nastavitev projekta.],
      ) <project-settings>
    ],
    box(width: 0.5cm),
    [
      #screenshot(
        path: "assets/user-input/input-map.png",
        width: 55%,
        caption: [Navigacija do sistema uporabniških dejanj.],
      ) <input-map>
    ],
  ),
)

Novo dejanje dodamo tako, da v polje "Add New Action" (dodaj novo dejanje) napišemo ime svojega dejanja in pritisnemo na gumb "Add" (dodaj), kot je prikazano na #ref(<add-action>, supplement: "sliki").

Naredimo novo dejanje in ga poimenujmo "skok".

#screenshot(
  path: "assets/user-input/add-action.png",
  width: 70%,
  caption: [Dodajanje dejanja.],
) <add-action>

Dejanje smo uspešno izdelali, dodati mu moramo samo še prožilce. Uporabniška dejanja so lahko: pritisk tipke na tipkovnici, premik miške, pritisk gumba na igralnem ploščku itd. Godotov sistem uporabniških dejanj nam omogoča, da ima eno dejanje več prožilcev. To je še posebej uporabno, ko izdelujemo igro za več platform in moramo hkrati podpreti različne vrste uporabniškega vnosa (npr. miška in tipkovnica, igralni plošček, VR krmilniki ...) saj tako v kodi ni potrebno ročno preverjati vseh možnih prožilcev.

V naši igri bo dinozaver skakal bodisi s pritiskom na preslednico (angl. _space_) ali pa s pritiskom na tipko "puščica gor" (angl. _up arrow_). Dodajmo torej ta dva prožilca na akcijo "skok".
// TODO (Gorazd): Te puščice gor/dol magar zapišita z znakcem.

Prožilec na akcijo dodamo s pritiskom na gumb s simbolom "+" desno od imena akcije, kot prikazuje #ref(<add-trigger>, supplement: "slika").

#screenshot(
  path: "assets/user-input/add-trigger.png",
  width: 70%,
  caption: [Dodajanje prožilca.],
) <add-trigger>


To nam odpre okno za izbor prožilca. Izberemo ga lahko tako, da se pomaknemo do želenega prožilca skozi uporabniški vmesnik. V primeru tipke presledek najprej odpremo odsek "tipke tipkovnice" (angl. _Keyboard Keys_) in med njimi najdemo preslednico (angl. _Space_). Ko kliknemo nanjo, nam bo Godot ponudil še dodatne možnosti. Te lahko trenutno ignoriramo, saj jih tekom delavnice ne bomo uporabljali. S pritiskom na tipko "OK" prožilec nato dodamo v akcijo.

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/user-input/add-trigger-menu.png",
        width: 45%,
        caption: [Meni za dodajanje prožilca.],
      )<add-trigger-menu>
    ],
    box(width: 0.5cm),
    [
      #screenshot(
        path: "assets/user-input/add-trigger-manually.png",
        width: 45%,
        caption: [Ročna navigacija do tipke preslednice.],
      )<add-trigger-manually>
    ],
  ),
)

Obstaja še enostavnejši način za dodajanje prožilcev. Na ta način bomo dodali prožilec "puščica gor". Zopet pritisnite gumb "+" desno od imena akcije, da se odpre meni za dodajanje prožilca. Opazili boste, da je prvo polje ("Listening for Input") označeno (kot je vidno tudi na #ref(<add-trigger-menu>, supplement: "sliki")). Če zdaj pritisnete tipko na tipkovnici, vam bo Godot sam našel to tipko. Če ste pritisnili tipko "puščica gor", bi moralo v polju pisati nekaj v smislu: "Up or Up (Physical) or Up (Unicode)". V srednjem meniju, kjer smo prej tipko ročno izbirali, bi morala biti tipka Up sedaj tudi označena. To je prikazano tudi na #ref(<add-trigger-with-filter>, supplement: "sliki"). Nato samo enako kot prej kliknemo na gumb "OK" in prožilec je dodan.

#screenshot(
  path: "assets/user-input/add-trigger-with-filter.png",
  width: 45%,
  caption: [Dodajanje prožilca s pritiskom na tipko.],
) <add-trigger-with-filter>

Zavihek "Input Map" bi moral zdaj izgledati nekako takole:

#screenshot(
  path: "assets/user-input/finished-input-map.png",
  width: 80%,
  caption: [Meni "Input Map", potem ko smo izdelali akcijo skok in dodali prožilce.],
) <finished-input-map>

Nastavitve projekta lahko zdaj zapremo in se vrnemo v urejevalnik. Čas je, da narejeno akcijo tudi uporabimo.

=== Uporaba uporabniških akcij

Na vozlišče `DinozaverSlicica` pripnite novo skripto "dinozaver.gd" in jo odprite.

Kot smo že omenili, obstaja več načinov na katere bi sedaj lahko uporabili našo akcijo. Tekom te delavnice bomo to dosegli s pomočjo vgrajenega tipa #variable-name("Input"). Tip #variable-name("Input") nam omogoča dostop do raznih funkcij, s katerimi lahko dostopamo do Godotovega sistema za uporabniški vnos.

Poskusimo torej zaznati ali je akcija "skok" pritisnjena. To lahko dosežemo z uporabo vgrajene funkcije ```gd bool is_action_pressed(action: String)```. V parametru `action` pošljemo ime akcije, za katero želimo preveriti, ali je pritisnjena, funkcija pa nam nato vrne `true` če je akcija pritisnjena, oziroma `false`, če ni.

#box-info(title: [#advanced-topic-heading[Za napredne uporabnike]], [
  Vgrajena metoda ```gd bool is_action_pressed(action: String)``` ima v resnici drugačen podpis, in sicer: ```gd bool is_action_pressed(action: StringName, exact_match: bool = false)```. Parameter `action` je posebna vrsta niza, imenovana `StringName`, prejema pa tudi nezahtevan parameter `exact_match`, s katerim lahko upravljamo, kako strog je Godot, ko išče našo akcijo.

  Za namene te delavnice lahko `StringName` enačimo s `String`, `exact_match` pa prav tako ne bomo nikoli uporabili, tako da se lahko zadovoljimo s poenostavljenim podpisom ```gd bool is_action_pressed(action: String)```.
])

Poglejmo si, kako lahko to funkcijo uporabimo:
```gd
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("skok"):
		print("Skok!")
```

#box-info(title: "_physics_process?", [
  ```gd _physics_process(delta: float)``` je zelo podobna funkcija kot ```gd _process(delta: float)```, torej tudi ta se kliče v rednih intervalih. Edina razlika med njima je, da se `_physics_process` (slov. funkcija za fizikalne procese) kliče, ko Godot osvežuje interno stanje fizikalnega sveta v nasprotju s `_process`, ki se kliče takrat, ko Godot izdeluje novo upodobitveno sličico. Fizikalni svet se osvežuje na fiksni interval, zato je klic `_physics_process` veliko bolj predvidljiv kot `_process`, katerega klicni interval je odvisen primarno od zmožnosti računalnika.

  Načeloma se držimo pravila, da vse delo, ki vključuje Godotove sisteme fizike in sistem za vnos (ki je pogosto tesno povezan s sistemi za fiziko), opravljamo v `_physics_process`. Vse ostalo delo, ki potrebuje redno izvajanje, pa v funkciji `_process`.

  `_physics_process` boste pogosto srečali tudi v #ref(<physics>, supplement: "poglavju").
])

Zgornja koda se bo, ker je znotraj funkcije `_physics_process`, izvajala redno. Klic na `is_action_pressed` nam bo torej vsakič preveril, ali je akcija "skok" aktivna. Če je (takrat klic funkcije vrne `true`), bomo na izhod napisali "Skok!", sicer (ko klic vrne `false`) pa ne bomo naredili ničesar.

Če zgornjo kodo kopirate v datoteko "dinozaver.gd" in projekt poženete, lahko to opazujete tudi sami.

#box-info(title: "Funkcijo kličemo kar na imenu tipa?", [
  Razlaga, zakaj v tem primeru funkcijo kličemo preko imena tipa, je zapletena in se vanjo ne bomo spuščali.

  Dotika se namreč vsega od statičnih metod, ki so same po sebi sicer precej enostaven konstrukt, pa vse do arhitekturnih odločitev izdelave Godota/GDScripta in komunikacije med različnimi programskimi jeziki, kar pa niso več enostavna poglavja. Poleg tega je vse to precej slabo dokumentirano tudi na uradni Godotovi dokumentaciji in vam zares ne bi preveč pomagalo.

  #box-divider()

  Poenostavljeno rečeno gre za to, da #variable-name("Input") v sebi hrani zbirko funkcij, ki se ukvarjajo z uporabniškim vnosom. Da lahko kličemo določeno funkcijo, ki jo ima sistem #variable-name("Input"), moramo Godotu povedati, pod katero skupino se nahaja, torej pod #variable-name("Input"), zato `Input.moja_funkcija`.
])

#box-task[
  Sami dosezite, da se dinozaver med držanjem preslednice ali puščice navzgor (torej akcije "skok") premika navzgor.

  Pomagajte si s kodo, ki smo jo ravnokar napisali, in kodo, ki premika kaktus.
]

Če ste bili pri tem uspešni, lahko sedaj do neke mere dinozavra nadzirate sami. Ste pa verjetno opazili, da to ni željen končni rezultat. Dinozaver se mora po skoku tudi vrniti nazaj, kar je precej bolj zapletena operacija kot pa samo linearno premikanje v eno smer. Na srečo nam Godot nudi pomoč tudi pri tem v obliki sistemov za fiziko.


#pagebreak(weak: true)
= Fizika <physics>

V prejšnjem poglavju smo dodali interaktivnost z uporabo Godotovega sistema akcij. Naš dinozaver se zdaj premika, a smo ugotovili, da nam manjka en ključni del: gravitacija in trki. Naš dinozaver namreč ob pritisku na presledek ne skoči, temveč samo poleti navzgor. To bomo v tem poglavju popravili z uporabo fizikalnih teles in trkalnikov.

#box-task[
  Odstranite skripto `dinozaver.gd`, ki ste jo imeli od #ref(<movement-and-input>, supplement: [poglavja]) nameščeno na vozlišču dinozavra #node2d-type-name("Sprite2D") (torej tistem vozlišču, ki se zdaj imenuje `DinozaverSlicica`), saj te skripte ne bomo več potrebovali in nam bo drugače v napoto.

  Vrnite se v okolje 2D. Od sedaj naprej smo prepričani, da ste že izurjeni v premikanju med okolji po potrebi, zato tega v navodilih ne bo več eksplicitno napisanega.
]

== Kaj so fizikalna telesa?
Do zdaj smo uporabljali večinoma vozlišča tipa #node2d-type-name("Node2D") in #node2d-type-name("Sprite2D"), ki ne podpirajo fizike, zato jih bomo zamenjali oziroma ovili (angl. _wrap_) z vozlišči, ki to podpirajo. Preden nadaljujemo, si na hitro podrobneje oglejmo en del drevesa tipov vozlišč na sliki #ref(<physics-node-type-structure>, supplement: [sliki]). Tu vidimo le majhen del poddrevesa, vidnega v prejšnjem drevesu na #ref(<partial-node-type-structure>, supplement: [sliki]) (tokrat smo osredotočeni na tipe v #node2d-type-name("Node2D") in #resource-type-name("CollisionObject2D")).

#figure(
  align(
    center,
    cetz.canvas({
      import cetz.draw: line, set-style

      let default-background-color = rgb("#353232")
      let line-color = rgb("#cacaca")

      let grayed-bg-color = rgb("#746f6f")
      let three-d-bg-color = rgb("#db3f3f")
      let two-d-bg-color = rgb("#4474db")
      let collisionobj-bg-color = rgb("#2194b1")
      let control-bg-color = rgb("#24b635")

      let node(name, background-color: default-background-color, style: "normal") = {
        box(
          fill: background-color,
          inset: 5pt,
          radius: 4pt,
          text(
            fill: white,
            weight: "bold",
            style: style,
            size: base-font-size - 1pt,
            name,
          ),
        )
      }

      cetz.tree.tree(
        spread: 0.1,
        grow: 0.5,
        draw-edge: (parent, child) => {
          let (a, b) = (parent.group-name, child.group-name)
          line((a, 0, b), (b, 0, a), stroke: (
            paint: line-color,
            thickness: 1.5pt,
          ))
        },
        (
          node("Node"),
          (
            node("CanvasItem", background-color: grayed-bg-color, style: "italic"),
            (
              node("Node2D", background-color: two-d-bg-color),
              // node("AnimatedSprite2D", background-color: two-d-bg-color),
              // node("Camera2D", background-color: two-d-bg-color),
              // node("Sprite2D", background-color: two-d-bg-color),
              (
                node("CollisionObject2D", background-color: grayed-bg-color),
                (
                  node("PhysicsBody2D", background-color: grayed-bg-color),
                  node("StaticBody2D", background-color: collisionobj-bg-color),
                  node("CharacterBody2D", background-color: collisionobj-bg-color),
                  node("RigidBody2D", background-color: collisionobj-bg-color),
                ),
                node("Area2D", background-color: collisionobj-bg-color),
              ),
            ),
          ),
        ),
      )
    }),
  ),
  caption: [Delna drevesna struktura nekaterih \ osnovnih tipov vozlišč v #resource-type-name("CollisionObject2D").],
) <physics-node-type-structure>

V tem poglavju nam bodo zanimivi sledeči štirje novi tipi vozlišč:
- #node2d-type-name("StaticBody2D"), ki predstavlja nepremično telo v 2D prostoru in podpira fiziko,
- #node2d-type-name("RigidBody2D"), ki predstavlja telo v 2D prostoru, na katerega samodejno vplivajo fizikalni procesi in
- #node2d-type-name("CharacterBody2D"), ki predstavlja programsko upravljano telo v 2D prostoru, na katerega prav tako vplivajo fizikalni procesi, kot sta gravitacija in trki. Takšno telo je pogosto na nek način upravljano s strani igralca, lahko pa je tudi strogo programsko, kot na primer nek neigralski lik (angl. _NPC_ oziroma _non-player character_).

Zaenkrat se bomo osredotočili na #node2d-type-name("CharacterBody2D") za lika dinozavra in #node2d-type-name("StaticBody2D") za uporabo pri tleh, v tem vrstnem redu. Zamenjava dinozavra za #node2d-type-name("CharacterBody2D") nam bo pomagala dodati gravitacijo v svet, #node2d-type-name("StaticBody2D"), s katerim bomo ustvarili tla, pa bo povzročil, da dinozaver zaradi gravitacije ne bo padel skozi tla, temveč se bo ustavil pri njih.


== Uporaba `CharacterBody2D`

#box-task[
  V glavnem prizoru ustvarite novo vozlišče tipa #node2d-type-name("CharacterBody2D") in ga poimenujte `DinozaverLik`. Nato v strukturi prizora z miško primite vozlišče s sličico dinozavra (`DinozaverSlicica`) in vozlišče preuredite tako, da bo `DinozaverSlicica` otrok vozlišča `DinozaverLik`.

  #screenshot(
    path: "assets/physics/godot_physics_characterbody2d-and-sprite-structure.png",
    width: 40%,
    caption: [Vozlišče `DinozaverLik` z otrokom `DinozaverSlicica`.],
  ) <physics_characterbody2d-with-warning-and-sprite>


  Da se izognemo nepričakovanim posledicam, sedaj izberite vozlišče `DinozaverSlicica`, nato pa na desni v podoknu "Inspector" razširite lastnost "Transform", kjer boste zagledali, da je vrednost lastnosti "Position" neničelna. Spomnite se, da smo v prejšnjih poglavjih omenili, da je vrednost lastnosti `position` relativna; če torej to vrednost pustimo, bomo imeli probleme pozneje, saj premikanje vozlišča `DinozaverLik` ne bo več imelo pravilnih posledic.

  Zaradi tega kliknite na gumb za ponastavitev vrednosti `position` (prekinjen krog s puščico), kot ga vidite na #ref(<dino-sprite-position-reset>, supplement: [sliki]).

  #screenshot(
    path: "assets/physics/godot_physics_dino-sprite-position-reset.png",
    width: 40%,
    caption: [Vrednost lastnosti `position` na vozlišču `DinozaverSlicica`.]
  ) <dino-sprite-position-reset>

  Kaktus in dinozaver (oziroma njuni vozliči `DinozaverLik` (in ne `DinozaverSlicica`) ter `KaktusSlicica` sedaj premaknite nekam v sredino zaslona.
]

Na #ref(<physics_characterbody2d-with-warning-and-sprite>, supplement: [sliki]) lahko vidimo pravilno novo strukturo vozlišč našega dinozavra, a lahko desno od imena vozlišča `DinozaverLik` opazimo znak za opozorilo! Če miško premaknemo čez opozorilo, nam Godot razloži, kaj je problem, kot vidimo na #ref(<physics_characterbody2d-no-collision-warning>, supplement: [sliki]):

#screenshot(
  path: "assets/physics/godot_physics_characterbody2d-no-collision-warning.png",
  width: 80%,
  caption: [Opozorilo na vozlišču tipa #node2d-type-name("CharacterBody2D"), da nismo določili površine trkalnika.],
) <physics_characterbody2d-no-collision-warning>

Opozorilo nam pravi, da vozlišče tipa #node2d-type-name("CharacterBody2D") potrebuje tudi trkalnik, kar ima smisel! Namreč Godot ne more samodejno zaznati, na kateri del dinozavra naj vpliva fizika, zato mu moramo to povedati sami.

#box-task[
  Ustvarite novo vozlišče tipa #resource-type-name("CollisionPolygon2D"), ga preimenujte na `DinozaverPovrsina` in ga postavite za otroka vozlišča `DinozaverLik`.

  Nato enkrat kliknite na vozlišče `DinozaverPovrsina`, da izberete vozlišče in izberite orodje za izbiro (angl. _Select Mode_), ki ga najdete pod ikono miške v orodni vrstici urejevalnika 2D (kot vidimo na #ref(<dino-sprite-in-2d-editor>, supplement: [sliki])) oziroma pod bližnjico `Q`. Sedaj začnimo ustvarjat trkalnik našega dinozavra tako, da kliknemo nekam na rob dinozavra in s tem ustvarimo prvo točko večkotnika. Kjer bomo kliknili, se bo pojavil majhen romb, ki prikazuje dodano točko. Sedaj se premaknimo do naslednje točke ob robu našega dinozavra in zopet kliknimo. Ustvarila se bo nova točka večkotnika, ki bo s prejšnjo povezana z ravno črto. Nadaljujmo ta proces, dokler ne obhodimo celotnega dinozavra; zadnji klik naredimo na prvo točko, ki smo jo ustvarili (prvi romb), in s tem zaključimo večkotnik in zagledamo površino trkalnika, kot jo vidimo na #ref(<physics_characterbody2d-dino-collision>, supplement: [sliki]):

  #screenshot(
    path: "assets/physics/godot_physics_dino-with-collision.png",
    width: 50%,
    caption: [Izgled dinozavra po stvaritvi njegovega večkotnega trkalnika.],
  ) <physics_characterbody2d-dino-collision>
]

Zdaj smo dodali večkotnik, ki predstavlja površino trkalnika, kjer dinozaver "obstaja", torej kaj vse zaobjema njegovo telo. Da ne bomo ponesreči dodajali novih točk, v strukturi prizora na levi kar izberimo neko drugo vozlišče, recimo `DinozaverLik`.

== Uporaba `StaticBody2D` <physics_staticbody2d-usage>
Preden našemu dinozavru dodamo skok, moramo definirati še tla, pri katerih se bo ustavil. Če tal ne definiramo, bo namreč naš dinozaver preprosto konstantno padal navzdol brez ovir in bi v kratkem izginil iz našega zaslona.

#box-task[
  V glavnem prizoru ustvarite novo vozlišče tipa #node2d-type-name("StaticBody2D") in ga poimenujte `Tla`. Opozorilo, ki ga boste videli na vozlišču, je enako kot na #ref(<physics_characterbody2d-no-collision-warning>, supplement: [sliki]): definirati moramo tudi trkalno površino.

  To storite tako, da, kot prej, za otroka vozlišča `Tla` dodate vozlišče tipa #resource-type-name("CollisionShape2D") in ga poimenujte `TlaPovrsina`. Tokrat smo izbrali #resource-type-name("CollisionShape2D") namesto #resource-type-name("CollisionPolygon2D"), ker so tla bolj preproste oblike in zato ne potrebujemo podpore za kolizijo z večkotnikom, ampak nam bodo preproste oblike več kot zadoščale. Izberite vozlišče `TlaPovrsina` in na desni, pod podrobnostmi vozlišča, kliknite na spustni meni pri lastnosti "Shape" (glej #ref(<physics_staticbody2d-new-collision>, supplement: [sliko])) ter izberite #resource-type-name("RectangleShape2D").

  #screenshot(
    path: "assets/physics/godot_physics_collision-shape-new-select.png",
    width: 36%,
    caption: [Spustni meni za ustvarjanje nove oblike preprostega trkalnika.],
  ) <physics_staticbody2d-new-collision>

  Po tej izbiri se nam bo v urejevalniku pojavil majhen kvadraten moder objekt, ki predstavlja trkalnik kvadratne oblike, ki smo ga ravnokar ustvarili. Začetna pozicija trkalnika nam skoraj zagotovo ne bo ustrezala, zato *vozlišče `Tla` premaknite pod dinozavra*, nato pa zopet izberite vozlišče `TlaPovrsina` in trkalno površino raztegnite na želeno širino z uporabo rdečih vogalnih gumbov (ki jih lahko vlečete), kot vidimo na #ref(<physics_scene-dino-with-floor-collision>, supplement: [sliki]):

  #screenshot(
    path: "assets/physics/godot_physics_dino-and-floor-collision.png",
    width: 70%,
    caption: [Vozlišče `DinozaverLik` z otrokom `DinozaverSlicica`.],
  ) <physics_scene-dino-with-floor-collision>
]

Če prizor poženemo, bomo ugotovili, da se ne dogaja nič posebej novega: dinozaver je še vedno pri miru, tal pa pravzaprav niti ne vidimo. To je pričakovan rezultat, ki ga bomo rešili v naslednjem poglavju. Pripravljeni smo, da dinozavru dodamo skakanje!


== Skok in skriptiranje `CharacterBody2D`

Morda se sprašujete, zakaj se dinozaver kljub temu, da smo ga pretvorili v vozlišče tipa #node2d-type-name("CharacterBody2D"), ki podpira fiziko, ne premika. Razlog je, da je vozlišča #node2d-type-name("CharacterBody2D") treba voditi ročno skozi skripto GDScript.
V glavi moramo imeti dve pomembni lastnosti teh vozlišč:
- Spremenljivka `velocity`, ki je samodejno prisotna v skriptah, ki razširjujejo #node2d-type-name("CharacterBody2D"), nam omogoča, da nastavljamo hitrost lika in Godotu prepustimo, da samodejno izračuna potreben premik, namesto da bi morali to računati sami.
- Funkcija `move_and_slide`, ki jo prav tako lahko uporabljamo le v skriptah, ki razširjujejo tip vozlišča #node2d-type-name("CharacterBody2D"), bo storila ravno to. Klicali jo bomo v funkciji `_physics_process`, kjer bomo s tem simulirali fiziko našega dinozavra za majhen korak. Poleg tega bo ta funkcija poskrbela, da ne bomo padli skozi trkalnike!


#box-task[
  Ustvarimo novo skripto na vozlišču `DinozaverLik` (to je tisto vozlišče, ki je tipa #node2d-type-name("CharacterBody2D")) in jo poimenujmo `dinozaver_lik.gd`. Poskusimo tokrat izklopiti polje "Template", saj bo naša koda precej drugačna od kode, ki jo Godot za nas zgenerira sam. Skripta, ki jo bomo zagledali, bo vsebovala le:

```gd
extends CharacterBody2D
```
]

// #box-warning[Tokrat prvič sami dodajamo vrstico extends. Pazite da pravilno razširja #node2d-type-name("CharacterBody2D") saj bomo drugače dobili napako omenjeno v #ref(<gdscript-and-nodes>, supplement: "poglavju").]

Preden zapišemo fizikalne interakcije, pod `extends` definirajmo eno spremenljivko: kako visok naj bo skok:

```gd
# [...]

@export
var impulz_za_skok: float = 1000.0
```

#box-info(
  title: "Kaj naj bi bilo #[...]?",
  [
    S takšnimi oznakami programerji pogosto označujemo da je tam še nek kos kode, ki pa je za trenuten primer nepomembna ali pa je bil ta kos kode že napisan malo pred tem in ga ne želimo ponavljati (kot smo že omenili smo precej lena bitja in ne maramo odvečnega pisanja). Če torej znotraj tega dokumenta kdaj naletite na takšno oznako vedite, da ne izpuščamo nič, kar bi bil za vas pomembno, oziroma kar naj bi bilo tam že poznate.
  ],
)

Sedaj ustvarimo funkcijo `_physics_process`, kjer bomo definirali naše fizikalne interakcije. Želimo, da se dogajata dva procesa:
- Če nismo na tleh, želimo našo hitrost (lastnost `velocity`) zmanjševati sorazmerno s časom in gravitacijo.
- Če smo na tleh in igralec pritisne na akcijo "skok", želimo dodati vertikalni fizikalni impulz, kar bo povzročilo, da bo dinozaver skočil.
- Vsak korak moramo klicati `move_and_slide`, ker želimo vsak korak simulirati fiziko našega dinozavra. Klic `move_and_slide` je unikaten vozlišču #node2d-type-name("CharacterBody2D") in ga na navadnih fizikalnih objektih (kot je na primer #node2d-type-name("RigidBody2D") ni potrebno klicati). Za razlago zakaj je temu tako, bi se zopet morali spuščati v arhitekturne odločitve izdelave pogona Godot, zato bomo razlago tokrat izpustili.

#box-warning[
  `move_and_slide` se, kot del sistemov fizike, zanaša na to da je vedno klican znotraj `_physics_process` in ne bo pravilno deloval če je klican kjerkoli drugje. Več o tem si seveda lahko preberete znotraj Godotove dokumentacije:
  
  https://docs.godotengine.org/en/4.7/classes/class_characterbody2d.html#class-characterbody2d-method-move-and-slide.
]

Iz teh zahtev dobimo sledečo skripto:

```gd
extends CharacterBody2D

@export
var impulz_za_skok: float = 800.0


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        # Nismo na tleh, torej moramo dodati silo gravitacije,
        # da bomo sčasoma padli nazaj dol.
        velocity += get_gravity() * delta
    else:
        # Smo na tleh, kar pomeni, da moramo v primeru
        # pritiska gumba odreagirati s skokom.
        if Input.is_action_just_pressed("skok"):
            # Do sedaj smo uporabljali primarno
            # velocity += Vector2D(0, -impulz_za_skok)
            # a to ni edini način, da posodobimo eno samo komponento
            # tega vektorja. Naredimo lahko namreč tudi:
            velocity.y = -impulz_za_skok

    # Vedno moramo dinozavra tudi ročno simulirati.
    move_and_slide()
```

Če zdaj našo igro poženemo, bomo ugotovili, da se dinozaver ustavi pri nevidnih tleh, ob kliku na presledek pa dinozaver skoči v zrak, ter se sčasoma upočasni in pade nazaj na nevidna tla. Čestitke, imamo osnovno premikanje!


== Območja in trkalniki

Kljub napredku ugotavljamo, da nam manjka še ena podrobnost: če se zabijemo v kaktus, gremo kar skozenj, igre pa ni konec. To želimo spremeniti.

V prejšnjih poglavjih smo uporabili #node2d-type-name("CharacterBody2D") in #node2d-type-name("StaticBody2D"), na katerih smo definirali trkalno površino, kar je povzročilo, da se npr. dinozaver zdaj ustavi na tleh, namesto da bi padel skozenj. Ampak poleg takih trkalnikov, poznamo tudi t.i. nevidne trkalnike, ki jim bomo rekli trkalna območja. Trkalna območja se definirajo z uporabo vozlišča `Area2D`, a funkcionirajo rahlo drugače kot telesa: namesto da bi sebe ali druga telesa ustavili ob trku, preprosto zaznajo, kdaj neko telo, ki podpira trke, vstopi v njihovo trkalno območje.

To nam bomo omogočilo, da na kaktusih definiramo trkalna območja in, ko zaznamo, da se je dinozaver zaletel vanj, končamo igro.

#box-task[
  Odprite okolje 2D in v njegovem urejevalniku premaknite poljuben kaktus, ki ste ga predhodno dodali v prizor, na neko mesto, kjer ga bo vaš dinozaver pri premiku v desno lahko zadel. Na ta kaktus bomo sedaj dodali trkalno območje in na njem testirali.

  #box-divider()

  Na izbrano vozlišče kaktusa dodajte najprej podvozlišče tipa `Area2D` z imenom `KaktusTrkalnoObmocje`, nato pa temu novemu vozlišču dodajte še podvozlišče tipa #resource-type-name("CollisionPolygon2D") z imenom `KaktusPovrsina`. Izbranemu kaktusu definirajte površino trkalnika, kot smo se to naučili v #ref(<physics_staticbody2d-usage>, supplement: [poglavju]), da bo kaktus zgledal podobno, kot na #ref(<physics_cactus-with-collision>, supplement: [sliki]).

  #screenshot(
    path: "assets/physics/godot_physics_cactus-with-collision.png",
    width: 26%,
    caption: [Kaktus, pokrit z `Area2D` in večkotno trkalno površino.],
  ) <physics_cactus-with-collision>
]

Če igro spet poženemo, bomo ugotovili, da se ni spremenilo prav nič, dinozaver se niti ne ustavi pri kaktusu, temveč gre kar skozenj. Razlog za to je, da smo ustvarili trkalno območje, a Godotu nismo povedali, kaj naj se zgodi, ko dinozaver vstopi vanj (torej kaj naj se zgodi, ko se dinozaver zadane v kaktus). A preden lahko ta problem popravimo, moramo narediti kratek ovinek in se naučiti o skupinah in signalih.

=== Skupine

Vsakemu vozlišču lahko poleg njegovega imena, tipa in lastnosti določimo tudi nabor skupin, v katere spada. Skupine so definirane preprosto poimensko, omogočajo pa nam, da pozneje v kodi za dano vozlišče preverimo, ali spada v skupino z določenim imenom. Na primer, ker bomo želeli beležiti trke z dinozavrom, bomo želeli ob trku dejansko preveriti, ali smo trčili z dinozavrom ali z nečim drugim.

Pripadnost določeni skupini bomo pozneje v kodi preverili s funkcijo

```gd
vozlisce.is_in_group("ime_skupine")
```

#box-task[
  V strukturi prizora izberite vozlišče `DinozaverLik`, nato pa na desni strani, kjer imate privzeto izbrano okno s podrobnostmi vozlišča (ali pa signale), izberite zavihek "Groups". V kolikor zavihka s tem imenom ne vidite, desno od zavihkov "Inspector" in "Signals" kliknite na puščico v desno, in sedaj izberite željen zavihek "Groups". Zagledali boste prazen seznam skupin (glej #ref(<physics_groups_empty>, supplement: [sliko])), pri čemer lahko opazite, da se skupine delijo na dva nivoja: na skupine, ki so skupne celotni igri, in na skupine, ki obstajajo le znotraj trenutnega prizora. Nas bodo primarno zanimale le globalne skupine.

  Kliknite na gumb za ustvarjanje nove skupine levo od iskalnika in ustvarite novo *globalno* skupino z imenom "dinozaver" (glej #ref(<physics_groups_creation>, supplement: [sliko])). Po kliku na gumb "OK" boste v seznamu skupin zagledali novo skupino (glej #ref(<physics_groups_with-dino-group>, supplement: [sliko])), pred njo pa kljukico, kar nakazuje na to, da izbrano vozišče, torej `DinozaverLik`, pripada tej skupini.

  Če na levi v strukturi prizora izberete drugo vozlišče, boste opazili, da skupina na desni še vedno obstaja, a zdaj te kljukice ni, ker to drugo vozlišče ne pripada skupini "dinozaver", kar je pravilno.

  #screenshot(
    path: "assets/physics/godot_groups_creating-for-dinozaver.png",
    width: 46%,
    caption: [Okno za ustvarjanje nove skupine.],
  ) <physics_groups_creation>

  #align(
    center,
    stack(
      dir: ltr,
      [
        #screenshot(
          path: "assets/physics/godot_groups_empty.png",
          width: 35%,
          caption: [Prazno okno skupin.],
        ) <physics_groups_empty>
      ],
      box(width: 1cm),
      [
        #screenshot(
          path: "assets/physics/godot_groups_with-dinozaver-group.png",
          width: 35%,
          caption: [Okno skupin s skupino "dinozaver".],
        ) <physics_groups_with-dino-group>
      ],
    ),
  )


]

=== Signali

#todo[Malo razširi poglavje o signali v stilu poglavja osnove GDScript (Andrej)]

Dve poglavji nazaj smo ustvarili trkalno območje (vozlišče `Area2D`), a se ob vstopu nekega telesa, na primer dinozavra, vanj ne zgodi nič. Razlog za to je, da `Area2D` ob vstopu telesa odda signal, na katerega se moramo mi povezati, če želimo na ta dogodek odreagirati.

Signali so v osnovi dogodki, na katere se lahko prijavimo tako, da na ta dogodek povežemo določeno funkcijo. To je mogoče storiti ali preko urejevalnika ali z uporabo skriptiranja, ampak zaenkrat se bomo osredotočili na povezovanje signalov preko urejevalnika. Definiramo lahko tudi poljubne signale, a več o tem kasneje.

#box-task[
  Na vozlišče `Igra` dodajte prazno skripto `igra.gd` (če želite, lahko od tu naprej ob dodajanju skript vklapljate možnost "Template" (predloga) po želji).

  V strukturi prizora izberite vozlišče `KaktusTrkalnoObmocje` (`Area2D`) in nato na desni strani med zavihki, kjer imate izbran zavihek s skupinami ("Groups") ali podrobnostmi vozlišča ("Inspector"), izberite zavihek "Signals". Zagledali boste nabor signalov, ki jih izbrano vozlišče oddaja, med njimi pa je tudi signal `body_entered`, ki se sproži takrat, ko določeno telo vstopi v to trkalno območje.

  Dvokliknite na signal `body_entered`. Zagledali boste pojavno okno, kot ga vidite na #ref(<signals_body-entered-new-dialog>, supplement: [sliki]). Povežite se na vrhnje vozlišče `Igra` in v polje "Receiver Method" vnesite `_ko_je_kaktus_zadet`: to je ime funkcije, ki se bo v skripti vozlišča `Igra` sprožila, ko neko telo vstopi v trkalno območje kaktusa.

  #screenshot(
    path: "assets/physics/godot_area_body-entered-signal-dialog.png",
    width: 70%,
    caption: [Pojavno okno za povezovanje signala `body_entered`.],
  ) <signals_body-entered-new-dialog>
]

V začetku bo funkcija videti takole (takšno jo privzeto ustvari Godot):

```gd
func _ko_je_kaktus_zadet(body: Node2D) -> void:
    pass # Replace with function body.
```

mi pa bomo vsebino prilagodili. Želimo namreč, da se ob vsakem trku preveri, ali smo trčili v dinozavra, in če je temu tako, v konzolo izpišemo "Trčili smo v dinozavra! Konec igre!". Argument funkcije `body` v tem primeru kaže na
telo (oziroma primerek vozlišča), ki se je zadelo ob kaktus.

```gd
func _ko_je_kaktus_zadet(body: Node2D) -> void:
    if body.is_in_group("dinozaver"):
        print("Trčili smo v dinozavra! Konec igre!")
```


Če igro poženemo in počakamo, da dinozaver prileze do kaktusa in se zabije vanj, bomo v tistem trenutku v konzoli na dnu urejevalnika zagledali naše sporočilo o koncu igre, kot je vidno na #ref(<signals_ko-je-kaktus-zadet-print>, supplement: [sliki]):

#screenshot(
  path: "assets/physics/godot_kaktus-area-triggered-print.png",
  width: 70%,
  caption: [Konzola ob pogonu igre s funkcijo `_ko_je_kaktus_zadet` in `print`.],
) <signals_ko-je-kaktus-zadet-print>

Uspešno! Dinozaver sicer še vedno potuje skozi kaktus, a razlog za to je le, da nismo igre v tistem trenutku kar končali. Zaenkrat bomo za konec igre gledali kar v konzolo, v prihodnjih poglavjih pa se bomo naučili še o preostalih konceptih, s katerimi bomo potem ta izpis v konzolo spremenili v dejanski konec igre.


#pagebreak(weak: true)
= Animacije

Do sedaj smo razvili nekaj osnovnih funkcionalnosti premikanja in proženja ter fizikalnih lastnosti, a so vsi liki, ki jih imamo, popolnoma nepremični. Dinozaver namreč drsi po tleh brez animacije, ptič lebdi v zraku itd. Čas je, da to spremenimo z uporabo animacij.

== Plahte sličic <about-spritesheets>
Na tej točki se posvetimo eni podrobnosti, ki je namenoma do tega trenutka nismo omenjali: kaj točno je datoteka `res://sredstva/chromium-dino/200-offline-sprite.png` in kako točno smo iz tega dobili sličico dinozavra, kot je `res://sredstva/dinozaver/dinozaver_1.tres`.

Datoteka `200-offline-sprite.png` je *plahta sličic* (angl. _spritesheet_). To pomeni, da je v eni večji datoteki več manjših sličic, zloženih ena ob drugi. Če na primer odpremo raziskovalec datotek našega operacijskega sistema in z ogledovalnikom slik odpremo to datoteko ter malo približamo, bomo videli, da je notri precej različnih dinozavrov, kaktusov, ptičev ter drugih elementov igre (glej #ref(<dino-game-original-spritesheet>, supplement: [sliko])).

#screenshot(
  path: "assets/game-assets/200-offline-sprite.png",
  width: 90%,
  caption: [Plahta sličic `200-offline-sprite.png`.],
) <dino-game-original-spritesheet>

Sličice so zložene ena ob drugi in zapakirane v eno samo datoteko s končnico `.png`. Razlog za to je, da želimo čim bolj zmanjšati količino posameznih datotek, ki jih moramo naložiti v delovni spomin. Ta pristop pri igri, ki je tako majhna, kot je naša, ni nujno potreben, a je to kljub vsemu dobra praksa. Tako pakiranje pomeni, da lahko naložimo eno samo datoteko z vsemi teksturami, in nato iz te teksture za uporabo povlečemo manjše kose po potrebi.

Točno to smo tudi naredili v paketu sredstev (angl. _asset pack_), ki smo vam ga dali. Datoteka `res://sredstva/dinozaver/dinozaver_1.tres` na primer le vzame to plahto sličic in na podlagi koordinat ven izvleče željen del, ki vsebuje dinozavra. To storimo tako, da v Godotovem raziskovalcu v poljubni mapi ustvarimo vir (angl. _resource_) tipa `AtlasTexture`. A preden razložimo to, naredimo kratek ovinek in razložimo, kaj viri sploh so.


=== Viri
Vir (angl. _resource_) je objekt, ki je konceptualno podoben vozliščem, v smislu da je virov, tako kot vozlišč, ogromno različnih tipov, a se od vozlišč razlikuje po uporabnosti. Viri so namreč samostojni (ni nujno, da obstajajo v prizoru) in predstavljajo podatke različnih tipov, od tekstur do animacij in senčilnikov. Nekaj osnovnih tipov virov lahko vidimo na #ref(<resource-type-tree-basic>, supplement: [sliki]).

Vire lahko shranimo na disk na podoben način kot prizore, le da imajo viri končnico `.tres`, med tem ko imajo prizori končnico `.tscn`. Ni pa nujno, da vire shranimo kot samostojne datoteke! Ko smo na primer na #ref(<physics_staticbody2d-new-collision>, supplement: [sliki]) kliknili na #resource-type-name("RectangleShape2D"), smo prav tako ustvarili vir, le da je bil ta vir tokrat vgrajen v #resource-type-name("CollisionShape2D"), v katerem se je ta vir nahajal, namesto da bi bil samostojno shranjen na disk.


#figure(
  align(
    center,
    cetz.canvas({
      import cetz.draw: line, set-style

      let default-background-color = rgb("#353232")
      let line-color = rgb("#cacaca")

      let disabled-bg-color = rgb("#887474").lighten(30%).desaturate(80%)
      let texture-bg-color = rgb("#887474")
      let shape-bg-color = rgb("#cca230")
      let sprite-bg-color = rgb("#b044db")
      let script-bg-color = rgb("#1b7fad")

      let node(name, background-color: default-background-color, style: "normal", weight: "bold") = {
        box(
          fill: background-color,
          inset: 5pt,
          radius: 4pt,
          text(
            fill: white,
            weight: weight,
            style: style,
            size: base-font-size - 1pt,
            name,
          ),
        )
      }

      cetz.tree.tree(
        spread: 0.1,
        grow: 0.5,
        draw-edge: (parent, child) => {
          let (a, b) = (parent.group-name, child.group-name)
          line((a, 0, b), (b, 0, a), stroke: (
            paint: line-color,
            thickness: 1.5pt,
          ))
        },
        (
          node("Resource"),
          (
            node("Texture", style: "italic", background-color: disabled-bg-color, weight: "medium"),
            (
              node("Texture2D", style: "italic", background-color: disabled-bg-color, weight: "medium"),
              node("AnimatedTexture", background-color: texture-bg-color),
              node("AtlasTexture", background-color: texture-bg-color),
              node("PlaceholderTexture2D", background-color: texture-bg-color),
            ),
          ),
          (
            node("Shape2D", style: "italic", background-color: disabled-bg-color, weight: "medium"),
            node("RectangleShape2D", background-color: shape-bg-color),
          ),
          node("SpriteFrames", background-color: sprite-bg-color),
          (
            node("Script", style: "italic", background-color: disabled-bg-color, weight: "medium"),
            node("GDScript", background-color: script-bg-color),
          ),
        ),
      )
    }),
  ),
  caption: [Delna drevesna struktura nekaterih osnovnih tipov virov (angl. _resource_).],
) <resource-type-tree-basic>


=== Vir `AtlasTexture`
Kot omenjeno v #ref(<about-spritesheets>, supplement: [poglavju]), je funkcionalnost vira `AtlasTexture` to, da iz atlasa (plahte) izvleče manjši del teksture. Točno tako so sestavljene vse sličice dinozavra v mapi `res://sredstva/dinozaver`, vsi kaktusi v `res://sredstva/kaktusi` itd. Pomembno je povedati, da je ta proces:
- nedestruktiven, torej originalna plahta sličic ostane taka, kot je, in da
- tak pristop ponavadi ne zahteva dodatnega kopiranja tekstur, s čimer prihranimo na delovnem spominu.

#box-task[
  Za vajo se naučimo še mi ustvarjati lastne vire `AtlasTexture`: v mapi `res://sredstva` ustvarite novo mapo `test`. V njej nato z desnim klikom odprite kontekstni meni in v kaskadnem meniju "Create New" kliknite na "Resource".

  Prikazalo se vam bo okno z drevesno strukturo tipov virov na podoben način kot drevesna struktura tipov vozlišč, ki smo jo spoznali v #ref(<basic-node-types>, supplement: [poglavju]). Kot je vidno na #ref(<new-resource-atlastexture>, supplement: [sliki]), izberite tip vira `AtlasTexture`, ki se v drevesu nahaja pod `Texture` in `Texture2D` ter kliknite na gumb "Create". Vir poimenujte `test.tres`, shranjen pa naj bo v mapo `res://sredstva/test`.

  #screenshot(
    path: "assets/animation/godot_animation_atlastexture-type-dialog.png",
    width: 80%,
    caption: [Pojavno okno za ustvarjanje novega vira (tokrat `AtlasTexture`).],
  ) <new-resource-atlastexture>

]

Na desni strani urejevalnika pod podrobnostmi (zavihkom "Inspector") boste zagledali podrobnosti novega vira. Če zavihek trenutno ni izbran, ga izberite, če pa slučajno zavihka "Inspector" na desni ne vidite, preverite, ali je morda skrit: kliknite na okrogel gumb za premik v levo. Od sedaj naprej zaupamo v vas, da se znate pomikati po the zavihkih, in teh namigov ne bomo eksplicitno pisali več.

Če slučajno vmes uredite neko drugo vozlišče ali vir, lahko podrobnosti vašega vira ponovno urejate tako, da v Godotovem raziskovalcu datotek poiščete `test.tres` in dvokliknete nanj.

#screenshot(
  path: "assets/animation/godot_animation_atlastexture_empty.png",
  width: 40%,
  caption: [Prazen vir `AtlasTexture`.],
) <empty-atlastexture>

Zanimali nas bosta dve nastavitvi tega vira: atlas in površina. Atlas je večja tekstura, iz katere vlečemo, torej bo to v našem primeru plahta sličic `res://sredstva/chromium-dino/200-offline-sprite.png`. Površina pa je nabor štirih vrednosti: začetne točke $(X, Y)$ ter širine in višine podteksture, ki jo želimo potegniti ven. Vrednosti je sicer mogoče vpisati ali popraviti ročno, a se večinoma zatekamo k gumbu "Edit Region", ki nam omogoča vizualno izrezovanje.

#box-task[
  V polje `<empty>` ob parametru "Atlas" potegnite plahto sličic `res://sredstva/chromium-dino/200-offline-sprite.png`, nato pa iz nje s pomočjo orodja "Edit Region" izrežite poljuben del, recimo kaktus. Primer izrezovalnega orodja lahko vidite na #ref(<atlastexture-region-editor-cactus>, supplement: [sliki]).

  V orodju pred urejanjem nastavite "Snap Mode" na "Pixel Snap", saj želimo izrezovati natanko po robovih pikslov.
  Izbiro regije je mogoče narediti tako, da po sliki povlečemo z miško, med tem ko držimo levi klik. Pomagajte si tudi z oranžnimi ročkami, ki vam omogočajo natančnejše spremembe, ter s približevanjem.

  #screenshot(
    path: "assets/animation/godot_atlastexture_region-editor_cactus.png",
    width: 80%,
    caption: [Urejanje površine izvlečene teksture.],
  ) <atlastexture-region-editor-cactus>
]


== Vozlišče `AnimatedSprite2D` in vir `SpriteFrames`

Do zdaj smo za prikaz sličic uporabljali vozlišča tipa #node2d-type-name("Sprite2D"), a sedaj želimo tem nepremičnim sličicam dodati animacijo, zato moramo uporabiti #node2d-type-name("AnimatedSprite2D"). Obstoječe uporabe #node2d-type-name("Sprite2D") bomo počasi zamenjali z #node2d-type-name("AnimatedSprite2D").

#box-task[
  Vozlišče `DinozaverSlicica` (ki je tipa #node2d-type-name("Sprite2D")) zamenjajte z novim vozliščem #node2d-type-name("AnimatedSprite2D"), ki ga poimenujte `DinozaverAnimacija`.
]

Če igro sedaj poženemo, bomo ugotovili, da dinozavra ni več videti. To je zato, ker smo izbrisali staro nepremično sličico dinozavra, nismo pa definirali še novih animacij. To lahko storimo tako, da v strukturi prizora izberemo vozlišče `DinozaverAnimacija`, na desni strani pod podrobnostmi pa nato lahko pod parametrom "Sprite Frames" kliknemo na spustni meni in ustvarimo nov vir tipa `SpriteFrames`. Primera okna pred stvaritvijo vira lahko vidimo na #ref(<animation_animatedsprite2d_inspector-empty>, supplement: [sliki]), po stvaritvi vira pa na #ref(<animation_animatedsprite2d_inspector-new>, supplement: [sliki]).

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/animation/godot_animatedsprite2d_inspector-empty.png",
        width: 35%,
        caption: [Podrobnosti vozlišča #node2d-type-name("AnimatedSprite2D") \ brez animacije.],
      ) <animation_animatedsprite2d_inspector-empty>
    ],
    box(width: 1cm),
    [
      #screenshot(
        path: "assets/animation/godot_animatedsprite2d_inspector-new.png",
        width: 35%,
        caption: [Podrobnosti vozlišča #node2d-type-name("AnimatedSprite2D") \ z novo animacijo.],
      ) <animation_animatedsprite2d_inspector-new>
    ],
  ),
)

Kliknite na polje, kjer sedaj namesto `<empty>` piše `SpriteFrames`. Kot vidimo na #ref(<animation_animatedsprite2d_inspector-new>, supplement: [sliki]), se je sedaj polje pobarvalo v modro. Če na polje kliknemo še enkrat, lahko sprostimo našo izbiro.

#box-task[
  Prepričajte se, da je nov vir `SpriteFrames`, ki smo ga ravnokar ustvarili, tudi izbran.
]

Kadar je `SpriteFrames` aktiven (oziroma izbran), se bo na dnu urejevalnika, kjer je bila ponavadi konzola, prikazalo novo okno v zavihku, imenovanem "SpriteFrames". Privzeto se bo ta zavihek kar odprl, ko izberemo vir desno zgoraj, ta nov urejevalnik, ki ga vidimo na #ref(<animation_animatedsprite2d_editor>, supplement: [sliki]), pa nam bo omogočal, da ustvarimo animacije iz posameznih sličic.

#screenshot(
  path: "assets/animation/godot_animatedsprite2d_bottom-section-editor.png",
  width: 95%,
  caption: [Urejevalnik `SpriteFrames`.],
) <animation_animatedsprite2d_editor>

Na levi strani urejevalnika animacij vidimo seznam animacij po imenu. Trenutno je prikazana le privzeta animacija z imenom "default". S klikom na gumbe v orodni vrstici nad tem seznamom lahko ustvarjamo in brišemo dodatne animacije, vir `SpriteFrames` namreč podpira poljubno različnih animacij, pri čemer moramo vsaki animaciji dodeliti svoje ime.

Na desni strani urejevalnika animacij vidimo (trenutno prazen) seznam sličic, ki pripadajo izbrani animaciji na levi. Sem noter bomo dodajali posamezne sličice animacije.

#box-task[
  Preimenujte privzeto animacijo iz "default" na "tek" (to storite tako, da kliknete na ime animacije in vtipkate novo ime). Sedaj na levi v Godotovem raziskovalcu datotek poiščite datoteki `dinozaver_3.tres` in `dinozaver_4.tres` (v mapi `res://sredstva/dinozaver`) ter ju potegnite na desno stran urejevalnika "SpriteFrames". Končni rezultat mora zgledati podobno kot na #ref(<animation_animatedsprite2d_editor_with-run>, supplement: [sliki]).

  #screenshot(
    path: "assets/animation/godot_animatedsprite2d_spriteframes-editor-with-run-animation.png",
    width: 95%,
    caption: [Urejevalnik `SpriteFrames` z animacijo `run`.],
  ) <animation_animatedsprite2d_editor_with-run>
]

Prepričajmo se, da animacija deluje pravilno: če še niste, na vrhu urejevalnika preklopite na okolje 2D, nato pa spodaj v urejevalniku `SpriteFrames` kliknite na gumb za predvajanje v orodni vrstici (tik nad prvo sličico). Sedaj bi morali v zgornjem 2D okolju zagledati, kako dinozaver teče. Po želji lahko prilagodite hitrost animacije tako, da spremenite vrednost `5.0 FPS` na večjo ali manjšo vrednost.

Ampak kljub temu, da animacijo vidimo v urejevalniku, bomo ob zagonu igre opazili, da dinozaver še vedno ni animiran! Razlog za to je, da moramo ob zagonu igre z uporabo GDScript povedati, katero animacijo hočemo predvajati (v našem primeru "tek"). Vozlišča tipa #node2d-type-name("AnimatedSprite2D") imajo namreč na voljo funkcijo `.play("ime-animacije")`, s katero začnemo predvajati dano animacijo.

=== Klicanje metod drugih vozlišč

Imamo le majhen problem... naša skripta, ki upravlja z dinozavrom, je prilepljena na vozlišče `DinozaverLik`, ne na `DinozaverAnimacija`, torej privzeto nima dostopa do funkcij vozlišča z animacijami!
Le kako torej uporabiti njeno funkcijo? Da odgovorimo na to vprašanje, si moramo ogledati dva načina pridobivanja
referenc na sosednja vozlišča: operator `$` in funkcijo `get_node`.

Ta operator in funkcija sta dva načina za rešitev istega problema. Začnimo z operatorjem `$`; le-ta nam omogoča, da mu podamo relativno pot do vozlišča, do katerega želimo dostopati, in vrnil nam bo referenco na to vozlišče. V glavo naše skripte, zunaj vseh funkcij, lahko postavimo sledečo kodo:
```gd
# [extends, @export, ...]

@onready
var animacije: AnimatedSprite2D = $DinozaverAnimacija

# [ostale funkcije, _ready, _physics_process, ...]
```

oziroma, drugače, z uporabo funkcije `get_node`, ki naredi enako:

```gd
# [extends, @export, ...]

@onready
var animacije: AnimatedSprite2D = get_node("DinozaverAnimacija")

# [ostale funkcije, _ready, _physics_process, ...]
```


Pozneje v kodi lahko sedaj dostopamo do spremenljivke `animacije` in kličemo njene funkcije, torej vse funkcije, ki obstajajo na vozliščih tipa #node2d-type-name("AnimatedSprite2D").


#box-info(title: [Ummm... `@onready`?])[
  Morda ste opazili, da smo uporabili oznako `@onready` pred definicijo spremenljivke. Razlog, za to je, da moramo
  izvedbo navadne kode
  ```gd
  var animacije: AnimatedSprite2D = $DinozaverAnimacija
  ```

  zamakniti, dokler vozlišče že obstaja v drevesni strukturi, saj lahko šele takrat poiščemo njene sosede. \ *Zgornja koda potemtakem ne bo delovala.*

  #box-divider()

  #advanced-topic-heading[Za napredne uporabnike]

  ```gd
  @onready
  var animacije: AnimatedSprite2D = $DinozaverAnimacija
  ```

  zgornja koda je praktično ekvivalentna, kot če bi spremenljivko deklarirali brez vrednosti, nato pa ročno uporabili operator `$` v `_ready`:
  ```gd
  var animacije: AnimatedSprite2D = null

  func _ready() -> void:
    animacije = $DinozaverAnimacija
  ```

  oziroma

  ```gd
  var animacije: AnimatedSprite2D = null

  func _ready() -> void:
    animacije = get_node("DinozaverAnimacija")
  ```

  kar spet naredi isto stvar.
]


== Tek dinozavra

Končno razumemo vse potrebno, da našega dinozavra spravimo v tek. V skripti vozlišča `DinozaverLik` v funkcijo `_ready` dodajmo sledečo kodo (če funkcije `_ready` še nimate, jo ustvarite):
```gd
# [spremenljivko "animacije" smo definirali že zgoraj]
func _ready() -> void:
    # To bo ob zagonu igre sprožilo predvajanje animacije z imenom "tek".
    animacije.play("tek")
```

Če zdaj poženemo našo igro, bomo ugotovili, da dinozaver teče, čestitke!


#box-task[
  Čaka vas malo več samostojnega dela! Vaš cilj je, da dodate animacijo za skok. Dinozaver naj torej predvaja animacijo za tek, ko pa pritisnemo presledek in dinozaver skoči, naj se predvaja animacija za skok. Ko dinozaver pristane nazaj na tla, se mora animacija preklopiti spet nazaj na tek.

  V osnovi to pomeni sledeči spremembi:
  - dodajanje nove animacije z imenom "skok" v vir `SpriteFrames` na vozlišču `DinozaverAnimacija` ter
  - zaznava, kdaj dinozaver skoči in kdaj pristane, in ob teh dogodkih temu primeren preskok na ustrezno animacijo za tek ali skok.

  // #box-divider()
  #v(base-font-size)

  Namigi:
  - Pomagajte si s funkcijo `is_on_floor`.
  - Pomagajte si z dodatno binarno spremenljivko (tipa `bool`), ki hrani `True` ali `False` glede na to, ali je bil dinozaver prejšnjo iteracijo v zraku.
]


#pagebreak(weak: true)

= Proceduralna generacija

Naša igra zdaj zgleda že precej dobro. Dinozaver veselo teče in skače, mu pa še vedno manjka resen izziv, saj za preskok enega kaktusa domov ne bo prinašal lovorik.

Na tej točki bi lahko ročno izdelali 200 kaktusov in jih postavili na primerne razdalje. To se vam morda zdi smešno a kar nekaj iger je dejansko izdelanih prav tako, torej ročno. Takšne tehnike sicer za našega dinozavra ne bi bilo smiselno uporabiti, a obstaja zelo velika verjetnost, da so bili svetovi v igrah, ki jih igrate, sestavljeni ročno.

Obstaja pa tudi drug pristop k izdelavi svetov in nivojev (angl. _level_) in sicer proceduralno. Proceduralno generiranje naši igri nudi neskončno veliko vsebine, saj je računalnik zmožen s pravim algoritmom nov svet oziroma nivo izdelati astronomsko hitreje kot človek. Če ste igralci iger ste verjetno naleteli tudi na igre s proceduralnimi svetovi (bodisi med raziskovanjem jam v najbolj prodajani uspešnici Minecraft, ki proceduralno generira svoje celotne svetove, ali pa ste na hodnikih šole igrali Subway Surfers, ki proceduralno skupaj lepi vnaprej ročno narejene kose železniških prog, v navidezno neskončen nivo.).

Ko izdelujete svojo igro je odločitev med ročno ali proceduralno izdelavo vprašanje vas in vizije igre. Zelo pogosto se tudi oba pristopa med sabo kombinira.

Naša igra dinozaver je po naravi en navidezno neskončni nivo, zaradi česar ji je proceduralnost v samem DNK, poglej si torej kako lahko ustvarimo navidezno neskončen nivo kaktusov.

== Priprava prizora

Najprej pripravimo prizor, da bomo lahko nato avtomatsko dodajali kaktuse. Na tej točki morate nekaj odločitev sprejeti tudi sami.

#box-task[
  V svojem projektu dinozavra in tla premaknite tako, da vam bo njuna pozicija vizualno ustrezala. Poskusite imeti čim manjšo razdaljo med dinozavrom in tlemi, je pa vseeno nekaj majhnega pustite da ne bo prišlo do problemov s trkalniki ob zagonu projekta. Kaktus, ki je trenutno v projektu, premaknite desno iz zaslona in ga vertikalno poravnajte s tlemi. Ob zagonu projekta bi se moral kaktus počasi prikazati na desni strani zaslona in počasi potovati proti dinozavru. Dinozaver in kaktus bi morala biti relativno drug na drugega pravilno poravnana s tlemi. Primer takšne urejene scene je tudi na #ref(<cleaned-scene-example>, supplement: "sliki").

  Pri urejanju ne pozabite na orodje za premikanje, ki ga lahko vklopite s klikom na tretjo ikono v orodni vrstici ali s pritiskom W na tipkovnici, ki vam med drugim omogoča tudi, da vozlišče premikate samo po eni osi naenkrat.

  #screenshot(
    path: "assets/procedural-generation/cleaned-scene-example.png",
    width: 95%,
    caption: [Primer urejene scene.],
  ) <cleaned-scene-example>
]

== Priprava kaktusa

Kaktusa takšnega, kot je trenutno izdelan, ne moremo lepo podvajati, zato je čas da se malo bolj spoznamo z Godotovim sistemom prizorov.

Prizore smo do sedaj uporabljali zato, da smo poganjali različne dele projekta ločeno (kot na primer ko smo v #ref(<gdscript-basics>, supplement: "poglavju") naredili ločen prizor v katerem smo se lahko igrali z osnovami GDScripta). Prizori pa niso zmožni samo tega in so v bistvu izjemno močno orodje in eden od temeljev na katerih stoji Godotova arhitektura.

Prizore lahko med tem ko je naša igra pognana poljubno izdelujemo in pripenjamo v drevo. Večkrat lahko izdelamo tudi _isti_ prizor, kar bomo s pridom izkoristili pri izdelavi naših kaktusov.

Kaktus moramo torej najprej spremeniti v svoj prizor. Na srečo ima Godot zelo priročno orodje ravno za naš primer. Z desnim klikom na katerokoli vozlišče, se nam bo prikazal kontekstni meni zanj. Znotraj tega menija lahko najdemo možnost "Save Branch as Scene..." (shrani vejo kot prizor). Spomnimo se da veja v tem kontekstu pomeni vozlišče na katerega smo kliknili skupaj z vsemi otroki, ki mu pripadajo.

Naredimo to torej za vozlišče `KaktusSlicica`. Znotraj mape `res://prizori` naredite novo mapo `res://prizori/kaktusi`. Nato vozlišče `KaktusSlicica` shranite kot sceno. Poimenujte jo `velik_kaktus.tscn` in jo shranite v mapo `res://prizori/kaktusi`. Ostale nastavitve v oknu za izbiranje lahko pustite takšne kot vam jih izpolni Godot.

#align(
  center,
  stack(
    dir: ltr,
    [
      #screenshot(
        path: "assets/procedural-generation/save-branch-as-scene.png",
        width: 35%,
        caption: [Shrani vejo kot prizor.],
      ) <save-branch-as-scene>
    ],
    box(width: 0.25cm),
    [
      #screenshot(
        path: "assets/procedural-generation/save-branch-as-scene-dialog.png",
        width: 65%,
        caption: [Okno za shranjevanje novega prizora.],
      ) <save-branch-as-scene-dialog>
    ],
  ),
)

Godot vam bo zdaj v prizoru `game.tscn` celotno vejo, ki jo je shranil kot nov prizor, zamenjal z novim prizorom. Da je vozlišče v raziskovalcu vozlišč v bistvu prizor, nam nakazuje nov gumb z ikono prizora, označen na #ref(<scene-node>, supplement: "sliki"). Če ta gumb kliknemo, nam bo Godot tudi odprl prizor, ki mu pripada.

#screenshot(
  path: "assets/procedural-generation/scene-node.png",
  width: 65%,
  caption: [Okno za shranjevanje novega prizora.],
)<scene-node>

Sedaj odprite novo narejeni prizor, in ovijte vozlišče `KaktusSlicica` z vozliščem tipa #node2d-type-name("Node2D"). Poimenujte ga `VelikKaktus`.

#box-info(title: [Ne vidim možnosti "Add parent node" (dodaj starševsko vozlišče)], [
  Če imate težave z ovijanjem/dodajanjem starša vozlišču `KaktusSlicica`, si lahko pomagate z "Make scene root" (naredi (trenutno vozlišče) koren prizora).

  Kateremukoli vozlišču v prizoru torej dodajte novega otroka tipa #node2d-type-name("Node2D"), nanj kliknite z desnim klikom miške in izberite to možnost.
])

Nato premaknite vozlišče `KaktusSlicica` tako, da bo njegov spodnji rob na rdeči/vijolični črti ($Y = 0$). Primer rezultata si lahko ogledate na #ref(<adjusted-cacti>, supplement: "sliki").

#box-warning[
  Bodite pozorni da premikate vozlišče `KaktusSlicica` (prvi otrok) in ne `VelikKaktus` (korensko vozlišče). Korenska vozlišča prizorov se ponavadi pušča na koordinatnem izhodišču (0, 0), saj jih, ko je prizor pripet v drevo, njihov starš pogosto spremeni.

  Če boste slučajno ponesreči premaknili korensko vozlišče, vas bo Godot na to opozoril z opozorilno ikono poleg imena korenskega vozlišča.
]

#screenshot(
  path: "assets/procedural-generation/adjusted-cacti.png",
  width: 65%,
  caption: [Primer popravljenega prizora `velik_kaktus.tscn`.],
)<adjusted-cacti>


Na našem kaktusu (specifično vozlišču `KaktusSlicica`) je še vedno stara skripta, ki ga je premikala levo. To bomo od zdaj naprej počeli drugje (višje v drevesu), zato to skripto odstranite.

== Izdelava krovnega prizora

Še vedno želimo, da se naš kaktus premika v levo. Na vozlišče `VelikKaktus` bi lahko pripeli novo skripto, ki bi to počela, a to ne bi bilo praktično. Problem bi nastal, ko bi želeli dodati drugačne kaktuse, saj bi morali za vsakega posebej nato izdelovati/pripenjati skripto, ki bi ga premikala levo (in izvajala vse ostale operacije, ki jih kaktus izvaja).

Zaradi tega bomo naredili krovni prizor, ki se bo dinamično odločal kateri kaktus prikazuje in bo skrbel za vse naloge kaktusa, od premikanja do obdelave trkov.

#box-task[
  V mapi `res://prizori/kaktusi` naredite nov prizor in ga poimenujte "kaktus.tscn". Korensko vozlišče naj bo kar #node2d-type-name("Node2D") poimenujte ga "Kaktus". Izdelajte skripto "kaktus.gd" in jo pripnite na prej izdelano korensko vozlišče "Kaktus", ter jo odprite. Godotovo predlogo za skriptno datoteko po želji pustite vklopljeno ali izklopljeno.
]

Da bo lahko naš krovni prizor kaktus izdelal, more najprej vedeti kje ga lahko najde. Na tej točki imamo zopet kar nekaj možnosti pristopa, vsaka od njih s svojimi prednostmi in slabostmi. Za voljo prikaza drugih načinov se bomo tokrat odločili za ročni pristop z uporabo `load` in `preload`, a bi bila uporaba izvoženih spremenljivk tudi popolnoma sprejemljiva, če ne celo boljša.

Funkcija ```gd Resource load(path: String)``` je vgrajena funkcija dostopna povsod znotraj GDScript skript in nam omogoča, da med tekom programa iz diska naložimo nov vir. Viri so vse vrste datotek, ki jih Godot razpoznava kot vire. Slike, zvočne datoteke in celo GDScript datoteke, se vse štejejo kot "vir". V našem primeru želimo naložiti prizor, torej `.tscn` datoteko.

To bi lahko dosegli s takšnim kosom kode:

```gd
var kaktus_prizor: PackedScene

func _ready() -> void:
  # Funkcija "load" prejme niz z potjo do vira v formatu res://
  # in nato naloži ta vir iz diska.
  kaktus_prizor = load("res://prizori/kaktusi/velik_kaktus.tscn")
```

#box-info(
  title: "PackedScene?",
  [
    `PackedScene` je vgrajen Godotov podatkovni tip, ki predstavlja "kompakten" prizor. To je enaka oblika prizora, kot ga ima Godot tudi spravljenega na disku, torej brez kakršnihkoli informacij, ki bi bile odvečne med shranjevanjem in so potrebne samo med izvajanjem.
  ],
)

Zgornja koda deluje popolnoma pravilno in bi jo lahko kot takšno tudi uporabili. A ker že vnaprej vemo točno kateri prizor nalagamo, lahko vse skupaj malo pohitrimo. Godot vsebuje tudi funkcijo ```gd  Resource preload(path: String)```, ki je skoraj identična funkciji `load`. Edina razlika je, da `preload` zahteva, da je niz (torej pot do vira) konstanten, kot argument ji torej ne moremo podati na primer spremenljivke, ali nekega kosa kode. V zameno za to omejitev pridobimo hitrost. Funkcijo `preload` Godot namreč izvede vnaprej, še preden sploh pride do njenega klica, in na točki kjer kličemo `preload` samo vrne že pripravljen vir. To tudi pomeni, da te kode ni potrebno več izvesti v funkciji `_ready` oziroma pod direktivo `@onready`.

Zgornja koda bi torej sedaj izgledala takole:
```gd
# Ker se preload izvede že med nalaganjem skriptne datoteke, lahko na to
# kar vrne gledamo, kot da je navadna vrednost in jo kar takole dodelimo
# spremenljivki.
var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")
```

#box-task[Zgornjo kodo kopirajte v skripto `kaktus.gd`.]


Kaktus imamo torej naložen, a je kakor ste verjetno opazili, podatkovnega tipa `PackedScene`, ki ga še ne moremo dodati v drevo vozlišč. Da prizor iz `PackedScene` spravimo nazaj v drevo vozlišč, kot smo ga naredili znotraj `velik_kaktus.tscn`, moramo na njem klicati funkcijo ```gd Node instantiate()```. Kot lahko vidite že iz podpisa nam funkcije vrne `Node`, torej vozlišče. V našem primeru bo to prav vozlišče `VelikKaktus` tipa #node2d-type-name("Node2D"), ki smo ga naredili v `velik_kaktus.tscn`. Pomembno je vedeti, da vozlišče vsebuje tudi vse svoje potomce, tako da zdaj v rokah pravzaprav držimo celotno drevo vozlišč narejeno znotraj tega prizora.

#box-info(
  title: [#advanced-topic-heading[Za napredne uporabnike]],
  [
    Funkcija `instantiate` ima v bistvu podpis ```gd  Node instantiate(edit_state: GenEditState = 0) const```, a si oznake `const` nismo ogledali in za nas niti ni pomembna, neobveznega argumenta `edit_state` pa prav tako ne bomo uporabljali.
  ],
)

Vsa vozlišča tipa `Node` (in njegovi potomci), vsebujejo funkcijo `add_child` s katero lahko neko vozlišče temu vozlišču dodamo kot otroka in ga skozi to tudi pripnemo v večje drevo vozlišč. To pomeni, da lahko zgornji primer razširimo v:

```gd
var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")

func _ready() -> void:
  # Kaktus tu pretvorimo iz zapakiranega prizora v drevo vozlišč.
  var kaktus: Node2D = kaktus_prizor.instantiate()
  # Tu ga dodamo kot svojega otroka.
  add_child(kaktus)
```

Če prizor `kaktus.tscn` trenutno poženete ne boste videli ničesar, saj se bo kaktus izdelal na koordinatnem izhodišču (0, 0) in potem rasel navzgor, tako da bo cela slika izven zaslona. Začasno ga torej premaknimo, da bomo lahko videli ali naša koda deluje.

```gd
var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")

func _ready() -> void:
  # Kaktus tu pretvorimo iz zapakiranega prizora v drevo vozlišč.
  var kaktus: Node2D = kaktus_prizor.instantiate()
  # Tu ga dodamo kot svojega otroka.
  add_child(kaktus)
  # To dodajte samo začasno da lahko vidimo ali koda pravilno deluje.
  kaktus.position = Vector2(400, 400)
```

Če ste navodilom sledili pravilno, bi morali ob zagonu `kaktus.tscn`, na zaslonu zdaj videti popolnoma dinamično ustvarjen kaktus.

== Izdelava kaktusov na fiksni interval

Pripravljeno imamo že kar dosti, zato je čas, da vse skupaj povežemo.

Vrnimo se torej nazaj v prizor `igra.tscn` in odprimo GDScript skripto na korenskem vozlišču (`igra.gd`). Naša trenutna želja je kaktuse ustvarjati na fiksen interval. To bomo dosegli s precej intuitivnim razmislekom. Če želimo v vsakdanu nekaj storiti čez, recimo 5 sekund, preštejemo do 5 in nato to naredimo. Računalnik tu ni nobena izjema (mogoče edino v tem da šteje mnogo bolj natančno). Izdelajmo si torej enostaven števec.


```gd
var cas: float = 0

func _process(delta):
	cas += delta
```

Zdaj želimo samo še dodati kaktus ko preteče določena količina časa. Dodajmo še to:

```gd
# To spremenljivko izvažamo, ker jo bomo verjetno kasneje urejali med
# preizkušanjem igre.
#
# Predstavlja nam na vsake koliko sekund naj dodamo kaktus.
@export
var interval_kaktusov: float = 1

var cas: float = 0
var cas_zadnjega_dodajanja: float = 0

func _process(delta):
	# Spomnimo se da delta predstavlja čas v sekundah od zadnje sličice.
	# Spremenljivka cas nam torej šteje čas v sekundah.
	cas += delta

	# Preverjamo ali je razlika med cas in cas_zadnjega_dodajanja, presegla 
    # interval dodajanja. Ker je razlika med njim v bistvu količina casa ki je 
    # pretekla odkar smo zadnjic dodali kaktus, bo to doseglo naše želeno dodajanje
    # na nek interval.
	if (cas - cas_zadnjega_dodajanja > interval_kaktusov):
		print("dodaj kaktus") # tu bomo dodali kodo, ki bo dodala naš kaktus
		cas_zadnjega_dodajanja = cas
```

Če popravite skripto `igra.gd` tako, da bo vsebovala zgornjo kodo, bi morali na izhod, na intervalu ene sekunde, izpisovati "dodaj kaktus". Kako iz prizora na disku v drevo dodati nova vozlišča, smo ravnokar spoznali. Dodajmo torej še dejansko dodajanje kaktusov.

```gd
#[...]

var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/kaktus.tscn")

func _process(delta):
	#[...]
	if (cas - cas_zadnjega_dodajanja > interval_kaktusov):
		var kaktus: Node2D = kaktus_prizor.instantiate()
		add_child(kaktus)
		cas_zadnjega_dodajanja = cas
```

Če spet popravite skripto `igra.gd`, bi se moral po zagonu na zaslonu z zamikom ene sekunde prikazati kaktus. Nov se bo sicer naredil vsako sekundo, a se bo pojavil na istem mestu in ga ne vidimo. Dodajmo torej nazaj premikanje kaktusov, da se ne bodo več prekrivali.

#box-task[
  Znotraj `kaktus.tscn` (*NE `velik_kaktus.tscn`*) in `kaktus.gd` dodajte premikanje kaktusov po osi X kot ga že poznamo. Vrstico, ki ga ob izdelavi premakne na (400, 400), zaenkrat pustite saj začetne točke še nismo popravili in bo drugače nam neviden.

  V pomoč vam je spet lahko primer v #ref(<moving-cactus-example>, supplement: "poglavju").
]

Zdaj bi morali ob zagonu `igra.tscn` videti kaktuse, ki se počasi premikajo levo po zaslonu. Nov kaktus se sedaj, če niste spreminjali izvožene vrednosti, izdela vsako sekundo.

Popravimo še začetno točko naših kaktusov, da bomo lahko umaknili premik iz `kaktus.gd`.

#box-info(
  title: [Zakaj ne samo popravimo premika v `kaktus.gd`?],
  [
    Čeprav bi z "metodo ostrega pogleda" (ugibanjem), lahko popravljali vrednost v premiku znotraj `kaktus.gd` dokler nam začetna vrednost ne bi ustrezala, bi to deloval samo na kratki rok. Takoj ko bi želeli znotraj prizora nekaj spremeniti bi se nam vse porušilo in zopet bi se morali vrniti k ugibanju.
  ],
)

V prizor `igra.tscn` dodajte novo vozlišče tipa #node2d-type-name("Node2D") in ga premaknite tako, da bo njegov spodnji del poravnan s kaktusom, ki smo ga pred tem premaknili izven zaslona (#ref(<cleaned-scene-example>)). To pomožno vozlišče, ki ga poimenujte `IzvorKaktusov` (poleg tega naj bo tudi otrok korenskega vozlišča), bo služilo samo temu, da bo skripti `igra.gd` povedalo, kje naj izdeluje nove kaktuse.

Dodajmo zdaj še ta zadnji kos sestavljanke v skripto `game.gd`. Ne pozabite tudi umakniti vrstice, ki je naš kaktus premaknila na (400, 400), iz skripte `kaktus.gd`, saj premik zdaj ni več potreben.

```gd
#[...]

# @onready je tu nujen, saj funkcija get_node v katero se razširi simbol $
# ne more preiskovati drevesa preden smo vanj pripeti.
#
# spremenljivko izvor_kaktusov bi lahko tudi povsod kjer je uporabljena
# zamenjali z $IzvorKaktusov, a je takšna koda kot smo jo tu napisali
# mi lepša in lažje vzdrževana (v primeru sprememb je potreben samo
# en popravek)
@onready
var izvor_kaktusov = $IzvorKaktusov

func _process(delta):
	#[...]
	if (cas - cas_zadnjega_dodajanja > interval_kaktusov):
		var kaktus: Node2D = kaktus_prizor.instantiate()
		# Novemu kaktusu globalno pozicijo nastavimo na enako pozicijo
		# kot jo ima naš izvor kaktusov. Ker smo to naredili pred klicem
		# add_child bo efektivno izdelan na tej lokaciji.
		kaktus.global_position = izvor_kaktusov.global_position
		add_child(kaktus)
		cas_zadnjega_dodajanja = cas
```

Če projekt poženete, bi morali na zaslonu videti nekaj podobnega #ref(<cactus-line>, supplement: "sliki"). Preverite, da vam skakanje dinozavra še vedno deluje, saj ga med izdelavo tega dela ne bi smeli pokvariti. Smo pa tekom preobrazbe projekta izgubili en kos funkcionalnosti: morda ste opazili, da se ob trkih s kaktusi, sporočila o trkih ne izpisujejo več na izhod. Popravimo sedaj še to.

#screenshot(
  path: "assets/procedural-generation/cactus-line.png",
  width: 65%,
  caption: [Igra po implementaciji fiksne izdelave kaktusov.],
) <cactus-line>

V skripto `kaktus.gd` dodajte funkcijo, ki bo klicana ob trku. Lahko je tudi enaka, kot je bila prej:
```gd
func _ko_je_kaktus_zadet(body: Node2D) -> void:
    if body.is_in_group("dinozaver"):
        print("Trčili smo v dinozavra! Konec igre!")
```

Nazadnje smo signal na našo funkcijo vezali s pomočjo Godotovega vmesnika. To je priročen in enostaven način, če so vsi faktorji znani že pred zagonom projekta.

Ko smo to delali nazadnje smo _ob času zagona projekta_ vedeli:
- Točno katero vozlišče preverja svoje trke in kako ga lahko najdemo (to vozlišče je bilo `Area2D` znotraj `VelikKaktusSlicica`)
- Kdo je tisti ki bo to poslušal (to je bilo vozlišče `Igra` skozi `igra.gd`)

Tokrat:
- Vemo da bo to poslušalo vozlišče `Kaktus` skozi `kaktus.gd`.
- *NE* vemo pa katero vozlišče bo preverjalo svoje trke, saj se vozlišče `Area2D` znotraj `VelikKaktus` ustvari dinamično, šele po zagonu projekta.

To ni nepremostljiva ovira, vse kar pomeni je, da moramo začeti tudi signal vezati dinamično.

Kot vedno, je tu tudi obvezno opozorilo, da je možnih pristopov več. V večjem projektu, ki bi imel bolj dinamične in raznolike kaktuse, bi verjetno vseeno uvedli skripto na korenskem vozlišču specifičnih kaktusov (kot je "VelikKaktus"), in potem nanjo povezovali trke, prek nje pa potem še višje. Ker pa je naš projekt precej enostaven, kaktusi pa so si med sabo različni samo po velikostih in sličicah, se bomo držali pravila, da imajo vsi kaktusi enako strukturo in poimenovanja, ter ročno vezali signal za trkanje.

Naša zahtevana struktura bo potemtakem:
#context {
  let raw-tree = "KorenskoVozlišče (npr. VelikKaktus)
  | SličicaKaktusa (npr. KaktusSlicica)
   | KaktusTrkalnoObmocje*
    | OblikaTrkalnika (npr. CollisionPolygon2D)
  "

  let file-tree = dtree(raw-tree)
  file-tree
}
\* - ime vozlišča mora popolnoma ustrezati imenu v shemi

Naš `velik_kaktus.tscn` se takšne strukture že drži, v mislih pa jo bomo morali imeti, ko bomo izdelovali druge kaktuse.

Začnimo torej poslušati enak signal, kot smo ga poslušali prej. To bo signal `body_entered` na `Area2D`. Najprej moramo najti `KaktusTrkalnoObmocje` (ki je tipa #node2d-type-name("Area2D")) znotraj našega drevesa vozlišč. Do sedaj smo za takšno iskanje uporabljali funkcijo `get_node` (in njeno okrajšavo `$`), obstaja pa tudi funkcija `find_child`, ki nam v tem primeru omogoča več svobode. Če bi na primer uporabili `get_node` bi moralo biti tudi ime vozlišča `SličicaKaktusa` fiksno in med `KaktusTrkalnoObmocje` in `KorenskoVozlišče` ne bi smelo biti nobenega drugega vozlišča kot `SličicaKaktusa`.

Dovolj razlage! Napišimo spet nekaj kode. Poglejmo si tokrat kar celotno datoteko naenkrat:

```gd
extends Node2D

var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")

func _ready() -> void:
	# Kaktus tu pretvorimo iz zapakiranega prizora v drevo vozlišč.
	var kaktus: Node2D = kaktus_prizor.instantiate()

	# Ker je kaktus tu že pretvorjen v drevo vozlišč lahko na njem normalno
	# kličemo metode kot je find_child.
	#
	# S spodnjima klicem najdemo vozlišče imenovano KaktusTrkalnoObmocje. Ker vemo
	# da smo si vse pripravili kot je treba, zaupamo, da je res tudi
	# podatkovnega tipa Area2D in kot tak vsebuje signal body_entered.
	var kaktusov_trkalnik: Area2D = kaktus.find_child("KaktusTrkalnoObmocje")
	# S klicem funkcije connect lahko signalu ročno dodamo funkcijo
	# ki se bo izvedla ko se bo sprožil signal.
	kaktusov_trkalnik.body_entered.connect(_ko_je_kaktus_zadet)
	# Tu ga dodamo kot svojega otroka.
	add_child(kaktus)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += Vector2(-delta * 100, 0)

# To funkcijo na vrstici 18 povežemo na signal body_entered. To pomeni da
# se bo izvedla ko se bo sprožil ta signal.
func _ko_je_kaktus_zadet(body: Node2D):
	if body.is_in_group("dinozaver"):
		print("Dinozaver je trčil v kaktus!")
```

Skripta je že sama precej dobro pokomentirana. Pojdimo pa zdaj še enkrat čez celotni proces:

1. Še preden s skripta začne izvajati se skozi `preload` v kaktus_prizor naloži zapakiran prizor `velik_kaktus.tscn`.
2. Vozlišče kaktus se doda v drevo vozlišč, sproži se klic `_ready` v katerem se:
  1. Zapakirana scena shranjena v kaktus_prizor se razpakira in pretvori v drevo vozlišč.
  2. Znotraj tega drevesa najdemo vozlišče z imenom "Area2D" in nanj začnemo, ker zaupamo lastnim pravilom, gledati kot na tip vozlišča `Area2D`.
  3. Na signal `body_entered` od vozlišča v `kaktusov_trkalnik` (kjer je naš `Area2D`), dodamo poslušalca. To je naša lokalna funkcija `ko_ovira_zadane_dinozavra`.
  4. Vozlišče (in s tem vse njegove otroke, torej celotno drevo vozlišč) znotraj `kaktus` pripnemo nase in s tem v glavno drevo vozlišč, s klicem funkcije `add_child`.
3. Vozlišče se začne izvajati. V funkciji `_process` se začnemo premikati levo.
4. Ko/če se kaktus zadane v drug trkalnik, se bo sprožila funkcija `ko_ovira_zadane_dinozavra`.

Praktično smo že končali, manjka nam samo še en majhen detajl, kaktusi se nam izdelujejo v nedogled se pa nikoli ne izbrišejo. Godot ni sposoben namesto nas vedeti, kdaj mora objekte počistiti, in bo vse kaktuse izvajal v nedogled, kar bo čez čas začelo upočasnjevati naš računalnik. Dodajmo torej zelo enostavno čiščenje.

V funkcijo `_process` dodajte:

```gd
# S tem if stavkom zaznamo, kdaj je kaktus globoko
# izven pogleda (na levi) in ga v tem primeru odstranimo,
# ker ga ne potrebujemo več.
if global_position.x < -200:
	# Funkcija queue_free() samega sebe najprej odstrani iz drevesa vozlišč in
	# nato uniči. Podrobnosti njenega delovanja nam ni potrebno razumeti.
	queue_free()
```

Na tej točki se lahko še malo poigrate z nastavitvami, kot je interval kaktusov na skripti `igra.gd`. Spomnite se, da smo to spremenljivko izvozili, tako da jo lahko urejate kar iz urejevalnika. Lahko se poigrate tudi s hitrostjo kaktusov, kar lahko urejate v funkciji `_process` znotraj skripte `kaktus.gd`. Smiselno bi jo bilo tudi izvoziti, da jo lahko med testiranjem lažje spreminjamo.

#box-task[
  Uredite skripto `kaktus.gd` tako, da bo se bo dalo hitrost kaktusov urejati znotraj urejevalnika.

  Relevantni del kode za to je:
  ```gd
  func _process(delta: float) -> void:
    # Številka 100 tu določa hitrost kaktusov.
    position += Vector2(-delta * 100, 0)
  ```
]


Zdaj ko smo izpilili še to podrobnost: Čestitke! Uspešno ste izdelali enostavno proceduralno generacijo nivoja.


== Dodajanje variacij med kaktusi

Trenutno se nam po zaslonu premika samo en tip kaktusa kar je malo dolgočasno. Dodajno še enega in naredimo, da se igra _naključno_ odloča med tem katerega bo uporabila.

#box-task[
  Podvojite prizor `velik_kaktus.tscn` (desni klik na prizor znotraj raziskovalca datotek in klik na možnost "Duplicate" (podvoji)). Novi prizor poimenujte `velik_kaktus_2.tscn`.

  Znotraj novega prizora:
  - Popravite ime korenskega vozlišča na `VelikKaktus2`.
  - Zamenjajte sličico znotraj `KaktusSlicica` na neko drugo sličico _velikega_ kaktusa. Na primer `velik_kaktus_3.tres`.
  - Popravite #resource-type-name("CollisionPolygon2D") tako, da bo zopet približno objemal obris kaktusa.

  #box-warning[
    Pri vsem tem pazite, da je kaktus na dnu še vedno lepo poravnan z osjo $Y = 0$ (rdeča/vijolična črta), drugače kaktus, ko ga bomo proceduralno izdelovali, ne bo lepo poravnan s tlemi!
  ]

  #screenshot(
    path: "assets/procedural-generation/duplicated-cactus.png",
    width: 65%,
    caption: [Primer podvojenega kaktusa.],
  ) <duplicated-cactus>
]

Zdaj imamo lepo pripravljena dva kaktusa, pa uporabimo še novega.

Odprite skripto `kaktus.gd` znotraj `kaktus.tscn`. Trenutno zgleda približno takole:

```gd
extends Node2D

var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")

@export
var hitrost_kaktusov: float = 250

func _ready() -> void:
	# Kaktus tu pretvorimo iz zapakiranega prizora v drevo vozlišč.
	var kaktus: Node2D = kaktus_prizor.instantiate()

	# Ker je kaktus tu že pretvorjen v drevo vozlišč lahko na njem normalno
	# kličemo metode kot je find_child.
	#
	# S spodnjima klicem najdemo vozlišče imenovano Area2D. Ker vemo
	# da smo si vse pripravili kot je treba zaupamo, da je res tudi
	# podatkovnega tipa Area2D in kot tak vsebuje signal body_entered.
	var kaktusov_trkalnik: Area2D = kaktus.find_child("Area2D")
	# S klicem funkcije connect lahko signalu ročno dodamo funkcijo
	# ki se bo izvedla ko se bo sprožil signal.
	kaktusov_trkalnik.body_entered.connect(ko_ovira_zadane_dinozavra)
	# Tu ga dodamo kot svojega otroka.
	add_child(kaktus)

#[...]
```

Deli, ki nas zanimajo, so izdelovanje kaktusov in ne njihovo upravljanje, tako da smo vse izven funkcije `_ready` trenutno izpustili, saj drugih delov tudi ne bomo spreminjali.

Najprej moramo v novi skripti sploh dobiti dostop do novega kaktusa. Čisto intuitivno bi lahko dodali samo novo spremenljivko `kaktus_prizor2` takole:
```gd
var kaktus_prizor: PackedScene = preload("res://prizori/kaktusi/velik_kaktus.tscn")
var kaktus_prizor2: PackedScene = preload("res://prizori/kaktusi/velik_kaktus_2.tscn")
```
a je to precej grd način dela, saj bi morali nato za vsak nov kaktus, ki ga bomo v prihodnosti morda še dodali, zopet izdelovati novo spremenljivko. To bi našo skripto napolnilo z oštevilčenimi spremenljivkami, med katerih se je precej lahko zgubiti.

Spomnimo so podatkovnega tipa ki smo ga že uporabljali, ko smo želeli več podobnih vrednosti shraniti znotraj ene spremenljivke. Verjetno ste na tej točki že uganili s čim si bomo pomagali, pretvorimo torej te dve spremenljivki v seznam:

```gd
var kaktus_prizori: Array[PackedScene] = [
	preload("res://prizori/kaktusi/velik_kaktus.tscn"),
	preload("res://prizori/kaktusi/velik_kaktus_2.tscn")
]```

Ob zagonu moramo zdaj samo vzeti naključen element seznama, ga izdelati in tako je naključna generacija narejena. Znotraj Godota je zopet več načinov, kako se lahko lotimo naključne generacije. Za nas trenutno najlažja, bo uporaba funkcije ```gd int randi_range(from: int, to: int)```. Z njo lahko generiramo naključno število, ki bo na intervalu `[from, to]`, torej od vključno `from` do vključno `to`.

V našem primeru si z njo lahko pomagamo takole:
```gd
#[...]

var kaktus_prizori: Array[PackedScene] = [
	preload("res://prizori/kaktusi/velik_kaktus.tscn"),
	preload("res://prizori/kaktusi/velik_kaktus_2.tscn")
]

#[...]

func _ready() -> void:
	# S funkcijo "randi_range" izberemo naključni indeks, ki bo znotraj
	# razpona elementov v "kaktus_prizori". -1 je potreben saj funkcija
	# "size()" vrne število elementov, indeksi pa začnejo šteti pri 0 ne pri 1.
	#
	# (Če bi imeli torej seznam ["A", "B", "C"], bi seznam.size() vrnil 3,
	# možni indeksi pa so samo 0->"A", 1->"B", 2->"C". 3 je že izven
	# razpona.
	var nakljucni_indeks = randi_range(0, kaktus_prizori.size() - 1)

	# Iz seznama kaktus_prizori vzamemo element na indeksu
	# "nakljucni_indeks" in ga iz zapakiranega prizora pretvorimo v drevo
	# vozlišč.
	var kaktus: Node2D = kaktus_prizori[nakljucni_indeks].instantiate()

	#[...]

```

Če projekt sedaj zaženete, bi morali videti nekaj podobnega #ref(<random-cactus-line>, supplement: "sliki").

#screenshot(
  path: "assets/procedural-generation/random-cactus-line.png",
  width: 65%,
  caption: [Igra po implementaciji naključne izdelave kaktusov.],
) <random-cactus-line>

#box-task[
  V igro sami dodajte še en majhen kaktus (na primer na osnovi `mali-kaktus_1.tres`). Še vedno bodite pozorni, da bo nov kaktus v svojem prizoru poravnan s tlemi (rdečo/vijolično črto).
]

#box-task[
  Zdaj ko smo spoznali osnove naključnosti, se lahko poskusite poigrati tudi z dinamičnim in naključnim spreminjanjem intervala med kaktusi. Funkcija `randi_range` bi vam tudi pri tem morala zadostovati.

  Razmislite tudi o tem, da dele te kode izvozite za urejanje v urejevalniku. Izvozili bi lahko na primer dve spremenljivki, ki bi ju potem uporabili kot parametra `to` in `from` v funkciji `randi_range`.
]

Osnovno delovanje igre smo zdaj dokončali. Dinozaver ima svoj izziv in hkrati tudi vse kar potrebuje da ga s skoki premaga. Še vedno pa se ob trku s kaktusom zgolj izvede izpis na izhod. Želimo, da bi se igra takrat končala, za igralca pa bi bilo dobro, da bi vedel kako dolgo je uspel zdržati. Kako dodati še vse to, si bomo pogledali v naslednjem poglavju.

#pagebreak(weak: true)
= Izdelava uporabniškega vmesnika


== Vozlišča tipa `Control`

Do sedaj smo delali izključno z "modrimi" tipi vozlišč, torej potomci tipa #node2d-type-name("Node2D"). Če se spomnite #ref(<partial-node-type-structure>, supplement: "slike"), obstaja še cela veja vozlišč, ki izhajajo iz tipa #control-type-name("Control") in se jih sploh še nismo dotikali. (Obstaja seveda še cela veja "rdečih" vozlišč, potomcev tipa `Node3D`, ki so narejena za ustvarjanje 3D iger, a se jih tekom te delavnice ne bomo dotikali.)

Vozlišča tipa #control-type-name("Control") so v pogonu z namenom izdelave klasičnega uporabniškega vmesnika. Gre za konstrukte, kot ste jih verjetno navajeni že iz uporabe klasičnih aplikacij (gumbi, vpisna polja, odstavki teksta...). Med drugim pa med potomci tipa #control-type-name("Control") najdemo tudi razne zaboje, s katerimi lahko ostala vozlišča pametno urejamo (jih postavimo v sredino, uredimo vertikalno/horizontalno, dodamo zamike, ...).

== Prizor "Konec igre"

Začnimo z izdelavo prizora, ki ga bomo prikazali ob koncu igre. Znotraj mape `res://prizori/igra` naredite nov prizor `konec_igre.tscn`, *katerega korensko vozlišče naj bo tipa #control-type-name("Control")*. Če ste nov prizor naredili s klikom na gumb "+" lahko to dosežete s klikom na gumb "User Interface" (uporabniški vmesnik) znotraj raziskovalca vozlišč. Če pa ste prizor naredili skozi raziskovalec datotek, pa to dosežete tako, da v oknu za izdelavo prav tako izberete možnost "User Interface". Preverite da ima korensko vozlišče ime "KonecIgre" in ga, če ima drugačno ime, popravite.

Razmislimo kaj mora naš prizor vsebovati. Želimo da:
- Igralcu jasno pove da se je igra končala. To lahko dosežemo s prikazom velikega besedila. Na primer "KONEC IGRE".
- Igralcu prikaže kako dolgo je zdržal. To bi lahko pobrali kar iz naše spremenljivke `cas`, ki se skozi potek igre vztrajno povečuje. Oblika v kateri je trenutno (sekunde od začetka v obliki decimalnega števila) morda ni najbolj primeren a to lahko kasneje popravimo. Želimo torej prikazati neko besedilo v smislu: "Rezultat: `<število-točk>`"
- Igralcu omogoči da ponovno začne igro. Na primer s pritiskom na gumb: "Nova igra".

=== Vozlišče Label

Naredimo najprej najlažji del. To je velik napis "KONEC IGRE". Besedilo lahko na zaslon prikažemo s pomočjo vozlišča tipa #control-type-name("Label"). Korenskemu vozlišču torej dodajte vozlišče tega tipa in ga poimenujte "NapisKonecIgre". Na desni strani, v urejevalniku vozlišč, boste ob kliku na novo vozlišče, opazili en kup novih možnosti, unikatnih vozliščem tipa #control-type-name("Label") in pa tudi vozliščem tipa #control-type-name("Control"). Za nas sta trenutno pomembni dve možnosti. Prva je imenovana "Text" in vanjo lahko napišemo besedilo, ki ga bo vozlišče #control-type-name("Label") prikazovalo. Napišimo torej vanj "KONEC IGRE". V plošči delovnega okolja 2D bi se moralo vozlišče sproti posodabljati in odražati vaše spremembe.

Druga možnost, ki jo bomo uredili je malo zakopana. Najdemo jo pod odsekom `Control->Theme Overrides->Font Sizes` in se imenuje "Font Size", možnost je prikazana tudi na #ref(<font-size-option>, supplement: "sliki").

#screenshot(
  path: "assets/user-interface/font-size-option.png",
  width: 45%,
  caption: [Možnost za spremembo velikosti fonta.],
) <font-size-option>


#box-info(
  title: "Zakaj pod Theme Overrides?",
  [
    Godot ima za stiliziranje vozlišč tipa #control-type-name("Control") v sebi celoten sistem za izdelavo motivov. Motiv je skupina pravil, ki definirajo privzet izgled vseh vozlišč #control-type-name("Control") in njihovih potomcev (kot je na primer #control-type-name("Label")). Vsebujejo barve, velikosti fontov, razmake in še marsikaj drugega.

    Privzeto naš projekt uporablja Godotov motiv, ki na primer definira, naj bo besedilo znotraj vozlišč #control-type-name("Label") belo in velikosti 16px (px stoji za "pixel" in je enota za merjenje velikosti fontov, ki _ponavadi_ pomeni en piksel na fizičnem zaslonu standardne resolucije, to za nas niti ni preveč pomembno.).

    Ker je naš projekt majhen, ni smiselno da bi izdelovali svoj motiv, zato bomo uporabili kar Godotovega. Na nekaterih točkah pa bi vseeno želeli da se naša vozlišča prikazujejo malo drugače, kot jim privzeto diktira motiv. Ker je to pogosta želja, nam Godot omogoča izredne spremembe vrednosti motiva, ki nato veljajo samo za izbrano vozlišče, v obliki odseka "Theme Overrides" (preglasovanje motiva).
  ],
)

Če vrednost spremenite iz 16 na katero drugo številko, boste opazili da se velikost našega besedila spreminja. Želimo da je naše besedilo "KONEC IGRE", precej veliko zato ga nastavite na 128 ali katero drugo, podobno veliko, vrednost.

=== Zaboji

Zdaj bi želeli da je naše besedilo v sredini. Vozlišče bi lahko prijeli in ga povlekli v sredino, a to zaradi nekaj razlogov v tem primeru ni najboljši način. Takšen premik z miško vozlišču #control-type-name("Label") pove, da naj se za fiksno dolžino premakne od koordinatnega izhodišča. To lahko v številki vidimo, če odpremo odsek `Layout->Transform` in opazujemo vrednost pod izvoženo spremenljivko "Position". So primeri kjer želimo neko vozlišče premakniti za fiksno dolžino a v našem primeru to pomeni da:

- Vozlišče verjetno ni pravilno centrirano, saj smo pozicijo ocenjevali na roko.
- Vozlišče ne bo več v sredini če se besedilo kadarkoli spremeni, saj je fiksno odmaknjeno glede na zgornji levi kot, zmanjševati pa se bo začelo od spodnjega desnega kota.
- Vozlišče mogoče ne bo v sredini na zaslonu z drugačno resolucijo, saj je fiksno odmaknjeno in ne vemo kako bo Godot to razdaljo prevajal, ko se bo prilagajal drugačnim zaslonom.

Zaradi teh problemov se računanje lokacije in velikosti (temu procesu se v angleščini reče "layout") takšnih vozlišč ponavadi prepusti pogonu samemu. Tu v zgodbo vstopi #control-type-name("CenterContainer"). To je vozlišče tipa #control-type-name("Control"), ki je samo po sebi nevidno in se uporablja samo za računanje lokacij in pozicij. Njegova dodana vrednost je to, da vse svoje otroke postavi v center prostora, ki ga ima na voljo. Če torej v naše drevo vozlišč dodamo #control-type-name("CenterContainer") in vozlišče `NapisKonecIgre` premaknemo tako, da postane njegov otrok, se ne bo zgodilo prav nič. Najprej moramo namreč povečati naš #control-type-name("CenterContainer") tako, da bo zasedel ves zaslon, saj centrira svoje otroke samo znotraj _prostora ki ga ima na voljo_.

To lahko naredimo tako, da izberemo #control-type-name("CenterContainer") in nato z orodjem za izbiranje (angl. Select tool) povlečemo krogec v spodnjem desnem kotu, do spodnjega desnega kota kamere (kjer se stikata modri črti).

#box-info(
  title: "Kje že najdem orodje za izbiranje?",
  [
    Orodje za izbiranje je prvo v orodni vrstici. Izberete ga lahko s klikom na njegovo ikono ali pa z bližnjico `Q`.
  ],
)

#screenshot(
  path: "assets/user-interface/center-container-drag.png",
  width: 90%,
  caption: [Vizualizirana razširitev #control-type-name("CenterContainer")ja.],
) <center-container-drag>
#screenshot(
  path: "assets/user-interface/after-center-container-drag.png",
  width: 90%,
  caption: [Po razširitvi #control-type-name("CenterContainer")ja.],
) <after-center-container-drag>

// Če naredimo to se UI obnaša malo čudno, tako da dajmo zaenkrat kar izpustiti
//
// Če želimo, da bo naš #control-type-name("CenterContainer") avtomatsko popravljal svojo velikost, glede na velikost zaslona (oziroma okna v katerem Godot prikazuje igro) moramo narediti še en popravek. V zgornjem levem kotu našega zaboja, boste opazili še štiri druge zelen oznake, ki jih lahko premikamo. Te oznake nam prikazujejo, kje ima naše vozlišče tipa #control-type-name("Control") svoja sidra (angl. anchor). V delovanje sider je malo bolj kompleksna tema in se vanjo ne bomo spuščali podrobno. Za nas je pomembno samo to, da lahko dosežemo avtomatsko popravljanje velikosti tako, da sidra postavimo na vse štiri kote zaslona, kot je tudi prikazano na #ref(<anchors>, supplement: "sliki").

// #screenshot(
//   path: "assets/user-interface/anchors.png",
//   width: 90%,
//   caption: [Postavitev sider.],
// ) <anchors>

Napis smo uspešno postavili na sredino zaslona. Dodajmo zdaj število točk, ki jih je igralec nabral tekom igre.

Število točk želimo postaviti pod naš napis "KONEC IGRE". To bo prav tako kos besedila, tako da bomo spet uporabili vozlišče #control-type-name("Label").

Če vozlišče kar dodate kot še en otrok zaboja #control-type-name("CenterContainer"), boste opazili, da je prav tako centrirano na sredino zaslona in se prekriva z besedilom "KONEC IGRE". Poleg tega ga z miško ne morete premikati. Še več: če to poskusite, vam Godot javi napako "Children of a container get their position and size determined only by their parent." (Otrokom zabojnika njihovo lokacijo in velikosti določi starš). Napaka že sama precej dobro opiše, kaj se dogaja. Ko je vozlišče tipa #control-type-name("Control") enkrat znotraj zabojnika, mu lokacijo in velikost določa starš. Novega vozlišča torej ne moremo premikati ročno, ampak mu moramo skozi sistem zabojnikov povedati, kje in kako naj se pozicionira.

Želimo, da so elementi na zaslon poravnani v vertikalno (v stolpec). Za to lahko uporabimo zaboj tipa #control-type-name("VBoxContainer"), v imenu stoji za vertical (vertikalna). Kot otrok #control-type-name("CenterContainer") dodajmo torej vozlišče tipa #control-type-name("VBoxContainer") in vanj premaknimo `NapisKonecIgre` in novo vozlišče tipa #control-type-name("Label"), ki ga poimenujte `Rezultat`. Če želite da je tudi to vozlišče poravnano v sredino ga lahko ovijete v še en #control-type-name("CenterContainer"). V vozlišče `Rezultat` lahko, da si bomo lažje predstavljali kako vse skupaj zgleda, napišete nekaj v smislu "Rezultat: 100". Povečajmo tudi velikost fonta tega vozlišča na 48px. Prizor bi zdaj moral biti podoben #ref(<after-result>, supplement: "sliki").

#screenshot(
  path: "assets/user-interface/after-result.png",
  width: 90%,
  caption: [Izgled prizora po dodanem vozlišču `Rezultat`.],
) <after-result>

Dinamično prikazovanje števila točk bomo dodali malo kasneje. Najprej dodajmo še gumb, ki bo sprožil ponoven začetek igre.

Vozlišču #control-type-name("VBoxContainer") dodajmo še enega otroka, tokrat tipa #control-type-name("Button"). #control-type-name("Button") kot vsi tipi vozlišč, ki smo jih obravnavali v tem poglavju, prav tako razširja #control-type-name("Control") in se prikaže kot navaden gumb z napisom. V možnost "text" tokrat napišite "Nova igra". Zavijte ga v nov #control-type-name("CenterContainer"), da se bo pravilno poravnal na sredino in mu popravite velikost fonta na 64px. #control-type-name("VBoxContainer") med svoje otroke privzeto da precej malo razmika, tako da sta besedilo "Rezultat: 100" in naš novi gumb precej blizu. To bi lahko uredili skozi možnost "separation" (razmik), ki nam jo nudi #control-type-name("VBoxContainer"), a ker nam je razmik med "KONEC IGRE" in "Rezultat: 100" zadovoljiv, poglejmo raje drugačen način.

Drugi #control-type-name("CenterContainer"), ki nam ga je Godot sam po sebi poimenoval `CenterContainer2`, zavijte z vozliščem tipa #control-type-name("MarginContainer"). Edina naloga #control-type-name("MarginContainer") (ki seveda širi #control-type-name("Control")), je da nam omogoča izdelavo razmikov med njegovimi otroki in okolico. Spremenimo torej možnost "Margin Top" (razmik navzgor), na približno 50. Možnost "Margin Top" zopet najdete pod "Theme Overrides".

S tem je vizualni del našega prizora končan. Prizor naj bi bil zdaj podoben #ref(<finished-interface>, supplement: "sliki").

#screenshot(
  path: "assets/user-interface/finished-interface.png",
  width: 90%,
  caption: [Vizualno končan prizor `konec_igre.tscn`.],
) <finished-interface>

== Voditelj igre

Preden začnemo z dinamičnim urejanjem vmesnika, nas čaka še izdelava precej pomembnega kosa naše igre, in sicer njenega voditelja.

Ko se naša igra konča, želimo namreč njeno celotno delovanje ugasniti in zamenjati na prizor, ki smo ga ravnokar naredili. Ob kliku na gumb "Nova igra" pa narediti ravno obratno in zamenjati nazaj na igro, ki pa se mora začeti od začetka. Zato da lahko delamo take menjave prizorov mora nad le temi bdeti nek višji prizor in jih voditi. Tak prizor je očem neviden in le nadzira stanje igre ter po potrebi menja prizore.

V mapi `res://prizori/igra` izdelajte nov prizor `voditelj_igre.tscn`. Njegovo korensko vozlišče naj bo tipa #node2d-type-name("Node2D") in ima ime `VoditeljIgre`. Nanj pripnite skripto `voditelj_igre.gd`, ki jo prav tako izdelajte.

Najprej si pridobimo prizora, med katerima bomo menjali:
```gd
var igra: PackedScene = preload("res://prizori/igra/igra.tscn")
var konec_igre: PackedScene = preload("res://prizori/igra/konec_igre.tscn")
```

Dodajmo še spremenljivko, v kateri bomo hranili trenutni prizor in funkcijo ki igro zažene. Ker želimo da se ob zagonu igre igra takoj zažene, bomo to funkcijo tudi klicali v funkciji `_ready()`.

```gd
# V tej spremenljivki hranimo trenutni prizor.
var trenutni_prizor: Node = null

func _ready() -> void:
    zacni_igro()

# Ko pokličemo to funkcijo, se začne nova igra z dinozavrom.
func zacni_igro():
    trenutni_prizor = igra.instantiate()
    add_child(trenutni_prizor)
```

Noben kos kode, ki smo jo napisali do sedaj nam ne bi smel biti neznan. Če sedaj poženemo prizor `voditelj_igre.tscn`, bi morali videti enako igro, kot smo je že vajeni.

Zdaj moramo voditelju igre nekako sporočiti, ko dinozaver trči v kaktus, da bo lahko igro končal. Dobro si je zapomniti dve generalni pravili glede pošiljanja informacij navzgor in navzdol po drevesu vozlišč:

1. Če informacije pošiljamo navzdol (starš želi nekaj sporočiti otroku/potomcem), to počnemo s klicem funkcij oziroma nastavljanjem spremenljivk, ki jih definirajo potomci. To smo že večkrat počeli.

2. Če informacije pošiljamo navzgor (otrok želi nekaj sporočiti staršu), to počnemo z uporabo signalov, ki jim lahko starši poljubno poslušajo. Otroci staršev ne kličejo preko funkcij, ker nikoli nimajo garancije, da njihov starš zares obstaja. Spomnimo se da lahko igro testiramo tudi z zagonom prizora `igra.tscn` in ne `voditelj_igre.tscn`. V tem primeru vozlišče `VoditeljIgre` sploh ne obstaja in je korensko vozlišče celotne igre kar `Igra`.

Tudi drugo pravilo smo že enkrat uporabili, znotraj skripte `kaktus.gd`, smo napisali vrstico:
```gd
kaktusov_trkalnik.body_entered.connect(ko_ovira_zadane_dinozavra)
```
kjer smo poslušali signal našega otroka.

Dodajmo zdaj signale na vseh potrebnih mestih za to, da bo dogodek na koncu prispel do voditelja igre.

Najprej dodajmo signal v skripto `kaktus.gd` in popravimo funkcijo `ko_ovira_zadane_dinozavra`, ki mora zdaj prožiti ta signal. `print` lahko zaenkrat pustimo, da bomo lažje reševali probleme če se pojavijo.

```gd
#[...]

signal zadel_dinozavra

#[...]

func _ko_je_kaktus_zadet(body: Node2D):
	if body.is_in_group("dinozaver"):
		print("Dinozaver je trčil v kaktus!")
		zadel_dinozavra.emit()
```

#box-info(
  title: "funkcija emit()",
  [
    S funkcijo ```gd emit()```, lahko ročno prožimo nek signal. Funkcija prejme poljubno število argumentov, ki jih bo potem poslala vsem poslušalcem.
  ],
)

V skripti `igra.gd` lahko sedaj ponovno uporabimo funkcijo ```gd _ko_je_kaktus_zadet()```, ki smo jo začasno zavrgli, ko smo izdelali proceduralno generacijo kaktusov. `igra.gd` ni zadnji poslušalec v verigi, sporočilo želimo spraviti do voditelja igre, tako da bomo tudi tu izdelali nov signal, na katerega bo potem poslušal voditelj.

Za vse to moramo dodati samo:

```gd
#[...]

signal konec_igre

func _process(delta):

  #[...]

  if (cas - cas_zadnjega_dodajanja > interval_kaktusov):
    #[...]

    kaktus.zadel_dinozavra.connect(_ko_je_kaktus_zadet)

    #[...]


func _ko_je_kaktus_zadet() -> void:
  print("Igra je prejela, da je dinozaver zadet!")
  # Voditelj igre potrebuje informacijo o času, da bo lahko prizoru
  # konec_igre.tscn sporočil kako daleč smo prišli.
  konec_igre.emit(cas)
```

Nato lahko v `voditelj_igre.gd` začnemo poslušati temu signalu:

```gd
#[...]

func zacni_igro():
	trenutni_prizor = igra.instantiate()
	trenutni_prizor.konec_igre.connect(_ko_je_konec_igre)
	add_child(trenutni_prizor)


# Ta funkcija je poklicana, ko je igre konec.
# To dosežemo tako, da to funkcijo povežemo
# na signal z imenom "konec_igre".
func _ko_je_konec_igre(rezultat: float):
	print("KONEC!")
```

Če sedaj poženete igro in pustite, da se dinozaver zaleti v kaktus, boste na Godotovem izhodu videli nekaj podobnega:

```izhod
Dinozaver je trčil v kaktus!
Igra je prejela, da je dinozaver zadet!
KONEC!
```

Sedaj lahko umaknemo vse 3 vrstice s `print` in naredimo, da se prizor zamenja.

Popravimo torej `voditelj_igre.gd` takole:

```gd
func _ko_je_konec_igre(rezultat: float):
	remove_child.call_deferred(trenutni_prizor)

	trenutni_prizor.queue_free()
	trenutni_prizor = konec_igre.instantiate()

	add_child(trenutni_prizor)
```

Če igro ponovno poženete, ne boste opazili samo izpisa, ampak se bo ob trku v kaktus pojavil tudi prizor, ki oznanja konec igre!

Usposobimo še gumb "Nova igra". Tokrat zopet pošiljamo informacije navzgor, saj mora za zahtevo po novi igri zopet izvedeti voditelj igre. Na hitro lahko z urejanjem `voditelj_igre.gd` to dosežemo takole:

```gd
#[...]

func zacni_igro():
	# To je potrebno preveriti, saj je možno da se vračamo iz prizora
	# za konec igre in moramo najprej počistiti še ta prizor.
	if trenutni_prizor != null:
		remove_child(trenutni_prizor)
		trenutni_prizor.queue_free()

	trenutni_prizor = igra.instantiate()
	trenutni_prizor.konec_igre.connect(ko_je_konec_igre)
	add_child(trenutni_prizor)



func ko_je_konec_igre(rezultat: float):
	remove_child.call_deferred(trenutni_prizor)

	trenutni_prizor.queue_free()

	# Nato naložimo prizor, ki prikazuje
	# konec igre in točke igralca.
	trenutni_prizor = konec_igre.instantiate()
	# Ta vrstica zahteva, da se naš gumb imenuje "Button"!
	trenutni_prizor.find_child("Button").pressed.connect(zacni_igro)

	add_child(trenutni_prizor)
```

Vozlišča tipa #control-type-name("Button") imajo na sebi signal imenovan `pressed`, ki se sproži ko igralec klikne na gumb. Na vrstici 26 na ta signal povežemo našo funkcijo `zacni_igro`, ki potem igro znova zažene. Ker se prizor `igra` še enkrat izdela na novo, se vse obnaša enako, kot če bi igro ravnokar zagnali.

Dodajmo še, kako dolgo se je igralec uspešno izogibal kaktusom. Čas od začetka igre že prejmemo v našo funkcijo `ko_je_konec_igre` v obliki parametra `rezultat`. Ta parameter smo nastavili s tem, da smo spremenljivko `cas` poslali v funkcijo `emit` znotraj `igra.gd`.
Vozlišču tipa #control-type-name("Label") lahko nastavimo besedilo, ki ga prikazuje tako, da mu nastavimo lastnost (spremenljivko) `text`:

```gd
func _ko_je_konec_igre(rezultat: float):
  #[...]

  # Ta vrstica zahteva, da se naš napis imenuje "Rezultat"!
  trenutni_prizor.find_child("Rezultat").text = "Rezultat: " + str(rezultat)
```

Če dinozavra zopet pošljete v bodečo pogubo, vas bo pričakalo nekaj podobnega #ref(<result-as-float>, supplement: "sliki").

#screenshot(
  path: "assets/user-interface/result-as-float.png",
  width: 90%,
  caption: [Prizor za konec igre, kjer je rezultat decimalno število.],
) <result-as-float>

Ko Godot pretvarja decimalno število v niz z ```gd str(rezultat)```, napiše vsa decimalna mesta ki jih ima na voljo. To zgleda precej grdo, saj bi si zagotovo želeli, da je naš rezultat celo število. Zelo enostavna rešitev je, da rezultat v sekundah enostavno pomnožimo z 100 in nato pretvorimo v celoštevilsko spremenljivko, kar bo odrezalo decimalni del a vseeno ohranilo kar nekaj natančnosti:

```gd
func _ko_je_konec_igre(rezultat: float):
	#[...]

	var lep_rezultat: int = rezultat * 100

	# Ta vrstica zahteva, da se naš napis imenuje "Rezultat"!
	trenutni_prizor.find_child("Rezultat").text = "Rezultat: " + str(lep_rezultat)
```

In s tem smo končali enostaven zaslon za konec igre.

#box-task[
  Malo se poigrajte s prizorom `konec_igre.tscn`. Poskusite spremeniti kakšno barvo, zamenjati velikost pisave, spremeniti lokacije elementov...

  Naredite ga takšnega da bo všeč vam. Pri tem si seveda lahko pomagate tudi z drugimi vozlišči, ki so potomci tipa #control-type-name("Control"). Vsa so dobro razložena na Godotovi dokumentaciji.
]

#box-task[
  Poskusite dodati besedilo na prizor `igra.tscn` v katerem boste v živo prikazovali koliko točk je nabral igralec.
]


#pagebreak(weak: true)
= Zvok

Do sedaj smo razvili marsikatero vizualno funkcionalnost, od animacij do uporabniškega vmesnika in naključnosti, a ko zaženemo našo igro, se vse dogaja v tišini. To bomo sedaj spremenili -- dodali bomo zvok.

Preden nadaljujemo, si oglejmo zvočne datoteke, ki so prisotne v našem paketu sredstev, ki smo jih uvozili ob začetku razvoja naše igre. Če odpremo mapo `res://sredstva/chromium-dino`, bomo notri našli tri datoteke s končnicami `.wav`: `button-press.wav`, `hit.wav` in `score-reached.wav`.

Dvokliknimo na `button-press.wav` in si oglejmo podrobnosti na desni strani urejevalnika v oknu "Inspector", kot vidimo na #ref(<audio_wav-inspector>, supplement: [sliki]):

#screenshot(
  path: "assets/audio/godot_audio_inspector-preview-single.png",
  width: 26%,
  caption: [Predogled datoteke `button-press.wav` v oknu "Inspector".],
) <audio_wav-inspector>

Če kliknemo na gumb za predvajanje, bomo zaslišali predogled tega zvočnega učinka -- kratek pisk. V tem trenutku se tudi prepričajte, da vaš računalnik pravilno predvaja zvok. Enako lahko storimo tudi s preostalima dvema zvočnima učinkoma.

Da bomo lahko zvok predvajali v igri sami, pa moramo spoznati nov tip vozlišča: `AudioStreamPlayer2D`. Gre za vozlišče, kateremu določimo zvok, nato pa skozi skriptiranje uporabimo njegovo vgrajeno funkcijo `.play()`, da predvajamo izbran zvočni učinek.

#box-task[
  V prizor `igra.tscn` dodajte novo vozlišče tipa `AudioStreamPlayer2D`, ga preimenujte v `ZvokSkok` in ga namestite kot otroka vozlišča `DinozaverLik`. Nato izberite vozlišče `ZvokSkok` in si na desni strani oglejte njegove podrobnosti, primer katerih vidimo na #ref(<audio_audiostreamplayer2d_inspector-empty>, supplement: [sliki]).

  V Godotovem raziskovalcu datotek poiščite datoteko `button-press.wav` in jo potegnite na mesto vrednosti nastavitve "Stream", kot vidimo na #ref(<audio_audiostreamplayer2d_inspector-with-file>, supplement: [sliki]).

  #align(
    center,
    stack(
      dir: ltr,
      [
        #screenshot(
          path: "assets/audio/godot_audio_audiostreamplayer2d_inspector-empty.png",
          width: 20%,
          caption: [Primer nastavitev vozlišča \ `AudioStreamPlayer2D` brez zvočne datoteke.],
        ) <audio_audiostreamplayer2d_inspector-empty>
      ],
      box(width: 1cm),
      [
        #screenshot(
          path: "assets/audio/godot_audio_audiostreamplayer2d_inspector-with-file.png",
          width: 20%,
          caption: [Primer nastavitev vozlišča \ `AudioStreamPlayer2D` z zvokom `button-press.wav`.],
        ) <audio_audiostreamplayer2d_inspector-with-file>
      ],
    ),
  )
]

Če sedaj poženemo igro, se seveda ne bo zgodilo popolnoma nič novega, saj nismo definirali, kdaj se mora zvok sprožiti. Sproženje zvočnih učinkov moramo namreč definirati v skripti našega dinozavra:
```gd
# [...]

@onready
var zvok_skok: AudioStreamPlayer2D = $ZvokSkok

# [...]

func _physics_process(delta: float) -> void:
    # [...]

    # Na mestu, kjer zaznamo skok, dodamo eno samo vrstico, kjer kličemo zvok_skok.play():
    if Input.is_action_just_pressed("skok"):
        # [... preostala koda pri skoku ...]
        zvok_skok.play()

    # [...]
```

To je vse! Ko igro sedaj poženemo in z dinozavrom skočimo, bomo zaslišali zvok! Če želimo, lahko prilagodimo glasnost zvoka in ostalih parametrov z izbiro vozlišča `ZvokSkok` in spremembe nastavitev na desni (glej #ref(<audio_audiostreamplayer2d_inspector-with-file>, supplement: [sliko])).

#box-task[
  Čaka vas malo več samostojnega dela! Vaš cilj je, da dodate dva nova zvočna učinka:
  - zvok `hit.wav` naj se predvaja ob koncu igre,
  - zvok `score-reached.wav` pa naj se predvaja vsakih deset pridobljenih točk.

  #v(base-font-size)

  Prvega izmed teh dveh ciljev lahko dosežete tako, da na isti način kot zgoraj dodate novo vozlišče tipa `AudioStreamPlayer2D`, le da ga dodate v prizor `voditelj_igre.tscn`. Dodelite mu zvočni učinek `hit.wav` in funkcijo `.play()` tega predvajalnika kličite v funkciji `_ko_je_konec_igre`.

  Drugega izmed teh ciljev lahko dosežete tako, da dodate nov `AudioStreamPlayer2D` v prizor `igra.tscn` in nato ta zvočni učinek (`score-reached.wav`) v skripti `igra.gd` prožite v enakomernih intervalih.
]



#pagebreak(weak: true)
= Dodatno delo in priporočeno branje

*Čestitke, prispeli ste do konca knjige!* Upamo, da ste v knjigi našli nekaj uporabne vrednosti, se kaj naučili in da ste zadovoljni s preprosto igro, ki smo jo izdelali skozi knjigo. Kot smo omenili v uvodu, so tematike, ki smo jih predelali, le majhen in zelo nepopoln nabor tehničnega znanja, potrebnega za razvoj konkretnejših iger. Upamo, da vas to ne odvrne od nadaljevanja na tem področju, saj imate že zdaj precej znanja! Kot ste zagotovo videli skozi knjigo, ni nujno, da ste izurjeni v popolnoma vsaki podrobnosti razvoja, ampak zadoščajo le že tiste teme, ki jih potrebujete za projekt, ki si ga zadate. 

*Naše upanje je, da boste s podlago, ki ste jo pridobili, znali samostojno nadaljevati izobraževanje na tem področju. Cilj tega poglavja je, da vam pri tem pomagamo.*


== Ideje za samostojno delo

Prvi izmed načinov, kako izboljšati svoje znanje, je skozi iterativno nadgrajevanje svoje igre, pri čemer se počasi spoznavamo z novimi temami in jih, tako kot skozi to knjigo, takoj integriramo v našo igro. Sledi nekaj tem in idej za nadgradnjo naše igre z dinozavrom.

=== Okolje

Trenutno naš dinozaver lebdi, čeprav ima pod sabo nevidna tla. Poskusite pod njega dodati premikajoča tla. Nekaj nasvetov:
- Paket sredstev v mapi `okolje` vsebuje `tla_1.tres` in `krajsa-tla_1.tres`; pomagajte si z njima. Če želite, lahko uporabite tudi `oblak_1.tres` in dodate oblačke na nebo.
- Pazite, da se tla premikajo z enako hitrostjo kot kaktusi, drugače bo videti, kot da tudi kaktusi deloma drsijo po tleh.
- Premikajoča tla so lahko samo vizualna! S tem mislimo, da jim ni potrebno dodajati trkalnikov, ampak lahko pod dinozavrom pustite samo en neviden statični trkalnik, ki je poravnan z nivojem tal.
- Ko boste dinamično dodajali tla, pazite, da jih na osi $X$ pravilno poravnate s prejšnjimi. Godot vam ne zagotavlja, da se bo trkalnik sprožil takoj, ko se tla zaletijo vanj, ampak so tla lahko že malce znotraj trkalnika, ko se trk sproži. To se zgodi, ker se premik tal zgodi v intervalih, čeprav se morda zdi, kot da lepo drsijo (naše oči niso sposobne zaznavati tako hitrih sprememb kot stopničastih, še posebej kadar ima naš zaslon večjo hitrost osveževanja). Pri tem je lahko za navdih spodnji kos kode:

```gd
# Ta funkcija se sproži ko je kos tal zavržen.
func ko_menjamo_tla(lokacija_starega_kosa):
    # Vemo da je en kos tal dolg 1400 in da imamo trenutno dva kosa.
    # Zato da nov kos tal postavimo na pravilno mesto ga moramo torej
    # zamakniti za 2800.
    lokacija_starega_kosa.x += 2800
    ustvari_tla(lokacija_starega_kosa)

# To funkcijo kličemo ko želimo ustvariti nov kos tal.
func ustvari_tla(lokacija_tal):
    var nova_tla = tla_prizor.instantiate()
    
    nova_tla.hitrost_tal = hitrost_premikanja
    nova_tla.global_position = lokacija_tal
    nova_tla.tla_zavrzena.connect(ko_menjamo_tla)
    
    skupina_tal.add_child(nova_tla)
```

=== Ptiči

V klasični igri dinozaver, kot jo lahko igramo v brskalniku Chrome, nam v oviro niso samo kaktusi, ampak tudi ptiči. Ptiči lahko letijo na treh različnih višinah. Če so na vrhu zaslona, lahko dinozaver mirno teče pod njimi. Če so v sredini, se mora dinozaver pod njimi _skloniti_, da se z glavo ne zadane vanje. Če so na dnu, pa jih mora dinozaver preskočiti. 

V igro dodajte ptiče in dinozavru omogočite, da se sklanja, na primer s pritiskom na puščico navzdol. Nekaj nasvetov ob delu:
- Za izdelavo sklanjanja boste verjetno morali dodati novo uporabniško akcijo.
- Paket sredstev v mapi `ptic` vsebuje `ptic_1.tres` in `ptic_2.tres`. Pomagajte si z njima, ko dodajate ptiče.
- Paket sredstev v mapi `dinozaver` prav tako vsebuje `dinozaver-sklonjen_1.tres` in `dinozaver-sklonjen_2.tres`. Pomagajte si z njima, ko dodajate sklanjanje. Dve sličici sta potrebni zato, ker moramo vzdrževati animacijo sklonjenega teka.
- Na podoben način kot pri kaktusih, kjer smo naključno izbirali sličico kaktusa, izdelajte krovni prizor `ptic.tscn`, v katerem se igra naključno odloča, kako visoko bo izdelala ptiča. Znotraj `igra.gd` z uporabo naključnosti menjajte še med izdelavo kaktusa in izdelavo ptiča.



== Dodatno branje <additional-reading>

Poleg razvoja novih funkcionalnosti je zelo pomembno tudi, da se znajdete v dokumentaciji, ki vam po ponuja Godot. Učinkovito branje dokumentacije je namreč zelo pomemben del programiranja in računalniškega inženirstva na sploh. Ko boste osnove razvoja iger utrdili, boste zelo verjetno ugotovili, da se vam je naučiti vsako naslednjo tehnično podrobnost ali funkcijo, za katero še niste slišali, vedno lažje, saj novo znanje stoji na trdni podlagi.

Predlagamo, da si ogledate dokumentacijo zadnje stabilne različice pogona Godot, ki jo lahko najdemo na sledeči povezavi: https://docs.godotengine.org/en/stable. Ko ste pripravljeni, da si izberete kakšno novo temo, o kateri želite zvedeti več, si lahko na primer ogledate poglavje "#link("https://docs.godotengine.org/en/stable/tutorials/index.html", [Tutorials])"" v tej spletni knjigi.


=== Več o obravnavanih temah
Sledi par tematik, ki smo jih sicer v tej knjigi obravnavali, a v katere se lahko še bolj poglobite, v kolikor vam je tema zanimiva.

Če želite izboljšati svoje znanje v jeziku *GDScript*, si lahko ogledate:
- interaktivni učbenik GDQuest, kjer boste ponovno spoznali veliko osnov, pa tudi še kakšno funkcionalnost jezika GDScript, ki je v tej knjigi nismo obdelali: \ 
  https://school.gdquest.com/courses/learn_2d_gamedev_godot_4/learn_gdscript/learn_gdscript_app
- poglavje "GDScript reference" v uradni dokumentaciji pogona Godot, kjer boste našli popolnoma vse funkcionalnosti, ki vam jih jezik omogoča (v tej knjigi smo se jih naučili le peščico): \
  https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html

Če želite izboljšati svoje znanje na temo *uporabniških dejanj*, si lahko ogledate:
- poglavje "Input handling" v uradni dokumentaciji pogona Godot, kjer boste našli tudi razlago, kako podpreti igralne ploščke (angl. _joystick_), spremeniti izgled ikone za miško itn.: \
  https://docs.godotengine.org/en/latest/tutorials/inputs/index.html


=== Druge zanimive teme
Sledi še par tematik, ki se jih v tej knjigi nismo dotaknili, a so zanimive ali uporabne.

Če želite izvedeti, kako razviti igro na osnovi *ploščic* (angl. _tiles_), si lahko ogledate:
- poglavje "Using TileSets" v uradni dokumentaciji pogona Godot, kjer boste spoznali, kako sestaviti množice ploščic (angl. _tile sets_) z uporabo vira #resource-type-name("TileSet"): \
  https://docs.godotengine.org/en/stable/tutorials/2d/using_tilesets.html
- poglavje "Using TileMaps" v uradni dokumentaciji pogona Godot, kjer boste spoznali, kako uporabiti pripravljene množice ploščic iz prejšnjega koraka in jih uporabiti z vozliščem #node2d-type-name("TileMapLayer"), s katerim sestavite konkreten zemljevid ploščic (angl. _tile map_): \
  https://docs.godotengine.org/en/stable/tutorials/2d/using_tilemaps.html

Pristop na osnovi ploščic je zelo močno orodje, saj vam omogoča, da nivoje pravzaprav kar narišete kocko po kocko, kar se pogosto uporablja pri izdelavi platformerjev (angl. _platformers_).

Znotraj našega projekta smo uporabljali samo privzeto vgrajeno kamero (označeno z zeleno, vijolično in dvema modrima črtama). To smo si lahko privoščili, ker je lokacija naše kamere statična in smo namesto kamere premikali ozadje. To je v teoriji možno narediti v čisto vsakem tipu igre, a je mnogokrat lažje premakniti kamero, kot pa premikati celotno okolje.

Če želite izvedeti, kako bolj napredno upravljati s *kamero* v dveh dimenzijah, si lahko ogledate:
- demonstracijski projekt za platformersko igro, ki je na voljo na na spletu v Godot Asset Library: \
  https://godotengine.org/asset-library/asset/2727
- demonstracijski projekt za igro v izometričnem načinu, ki je na voljo na spletu v Godot Asset Library: \
  https://godotengine.org/asset-library/asset/2718



#pagebreak(weak: true)
= Priloge

V tem poglavju najdemo priloge, na katere se ponavadi navezujemo ob besedilu v knjigi.


== Primer izdelave kalkulatorja <example-calculator-implementation>

```gd
extends Node2D

@export
var stevilo1: int = 0

@export
var stevilo2: int = 0

# @export_range je praktično identičen @export, le da omeji vrednosti, ki jih lahko
# urejevalnik vozlišč vpiše v to spremenljivko. Prva številka je spodnja meja,
# druga številka je zgornja meja in tretja številka je korak.
#
# V tem primeru dovolimo vrednosti od vključno 0 do vključno 4 (interval [0, 4])
# s korakom 1, torej samo diskretne vrednosti (0, 1, 2, 3, 4).
#
# POZOR: Teoretično lahko v spremenljivko še vedno pišemo poljubne vrednosti.
@export_range(0, 4, 1.0)
var operacija: int = 0

func _ready() -> void:
	if operacija == 0:
		var rezultat = stevilo1 + stevilo2
		izpisi_rezultat(stevilo1, "+", stevilo2, rezultat)
	elif operacija == 1:
		var rezultat = stevilo1 - stevilo2
		izpisi_rezultat(stevilo1, "-", stevilo2, rezultat)
	elif operacija == 2:
		var rezultat = stevilo1 * stevilo2
		izpisi_rezultat(stevilo1, "*", stevilo2, rezultat)
	elif operacija == 3:
		var rezultat = stevilo1 / stevilo2
		izpisi_rezultat(stevilo1, "/", stevilo2, rezultat)
	elif operacija == 4:
		var rezultat = stevilo1 % stevilo2
		izpisi_rezultat(stevilo1, "%", stevilo2, rezultat)
	else:
		# Ta koda se načeloma ne bo nikoli izvedla, je pa vseeno lepo skrbeti
		# za vse primere.
		print("Neznana operacija!")

func izpisi_rezultat(
  stevilka1: int,
  operacija: String,
  stevilka2: int,
  rezultat: int
):
	print(str(stevilka1) + " " + operacija + " " + str(stevilka2) + " = " + str(rezultat))

```

== Primer zanke čez vse elemente seznama <array-looping-example>
```gd
extends Node2D

func _ready() -> void:
	var seznam: Array[int] = [1, 2, 3]
	var indeks = 0
	while (indeks < seznam.size()):
		print(seznam[indeks])
		indeks += 1

```

== Primer izdelave kalkulatorja s seznami <example-calculator-with-arrays-implementation>

```gd
extends Node2D

@export
var stevila: Array[int] = []

@export_range(0, 1, 1.0)
var operacija: int = 0

func _ready() -> void:
	# Nimamo nobenega zagotovila, da bo uporabnik stevila res nastavil, tako da
	# je lepo preveriti tudi tak primer.
	if (stevila.size() == 0):
		print("Ne morem računati brez števil!")
		return
	if operacija == 0:
		var rezultat = 0
		for stevilo in stevila:
			rezultat += stevilo
		izpisi_rezultat(stevila, "+", rezultat)
	elif operacija == 1:
		var rezultat = stevila[0]
		var indeks = 1
		while (indeks < stevila.size()):
			var stevilo = stevila[indeks]
			rezultat -= stevilo
			indeks += 1
		izpisi_rezultat(stevila, "-", rezultat)
	else:
		# Ta koda se načeloma ne bo nikoli izvedla, je pa vseeno lepo skrbeti
		# za vse primere.
		print("Neznana operacija!")

func izpisi_rezultat(
  stevila: Array[int],
  operacija: String,
  rezultat: int
):
	var sporocilo = str(stevila[0])
	stevila.remove_at(0)
	for stevilo in stevila:
		sporocilo += " " + operacija + " "
		sporocilo += str(stevilo)
	sporocilo += " = "
	sporocilo += str(rezultat)
	print(sporocilo)
```

== Premikanje kaktusa <moving-cactus-example>
```gd
extends Sprite2D

func _process(delta: float) -> void:
	position += Vector2(-delta * 100, 0)

```


#pagebreak(weak: true)
= Licence <licences>

_Glej tudi kolofon na strani 2._

#v(1em)

Vsebina knjige je ponujena pod licenco *#link("https://creativecommons.org/licenses/by-nc-sa/4.0/deed.en", "Creative Commons BY-NC-SA 4.0")*. Iz te licence je izvzeta koda (tako v knjigi kot v dodatnih materialih): le-ta je namesto tega ponujena pod licenco *#link("https://spdx.org/licenses/MIT.html", "MIT")*:

#copyright-text[
  ```
  MIT License

  Copyright (c) 2026 Andrej Matos in Simon Peter Goričar

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
  ```
]


== Zunanje licence <external-licences>

Vizualna vsebina, ki je prisotna v paketu sredstev in ki je pogosto prikazana na zaslonskih posnetkih (vse, kar je v podmapi `chromium-dino`), izvira iz projekta #link("https://github.com/chromium/chromium", "Chromium") pod licenco #link("https://spdx.org/licenses/BSD-3-Clause.html", "BSD-3-Clause"):

#copyright-text[
  ```
  Copyright 2015 The Chromium Authors

  Redistribution and use in source and binary forms, with or without modification, 
  are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright 
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright 
      notice, this list of conditions and the following disclaimer in 
      the documentation and/or other materials provided with the distribution.
    * Neither the name of Google LLC nor the names of its contributors 
      may be used to endorse or promote products derived from this software 
      without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ```
]
