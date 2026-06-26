# Načini pisanja
- Datotečne poti so z `pot` (tudi `res://`).
- Imena vozlišč so z `ImeVozlišča`.
- Ime tipa vozlišča je z #node-type-name, #node2d-type-name("ime"), #node3d-type-name("ime"), #control-type-name("ime")
- Ime spremenljivk / lastnosti so z #variable-name("ime").
- Ime navadnega podatkovnega tipa z #data-type-name("ime")
- Podpise funkcije se piše z ```gd func _funkcija(...) -> ...```
- Ime funkcije je s #function-name("ime funkcije")
- Deli uporabniškega vmesnika so z #ui-button


# Napredni TODOji / možne izboljšave

- samodejno linkanje na dokumentacijo, ko je uporabljen #node-type-name

```
// TODO v takih primerih, kjer je ful prostega prostora ker so screenshoti zelo ozki,
// bi bilo fino reflowat besedilo kar ob te screenshote (recimo da je potem ta slika na desni,
// besedilo pa na levi) - glej modul `meander` / funkcijo `grid`/`stack`.
//
// Za pozneje.

// #meander.reflow({
//   import meander: *
//
//   placed(
//     top + right,
//     screenshot(
//       path: "assets/ui-basics/godot-ui_file-browser.png",
//       width: 25%,
//       caption: [Raziskovalec datotek v urejevalniku Godot.]
//     )
//   )
//
//   container()
//   content[
//     Pa kar začnimo z osnovnimi sredstvi (angl. "assets") naše igre! Najprej v korenu našega projekta ustvarimo mapo "sredstva", kjer bomo hranili vsa sredstva (t.j. teksture, zvok, itd.). To storimo tako, da se z miško postavimo na mapo `res://` in naredimo desni klik. Odprl se bo kontekstni meni, kjer lahko ustvarimo podmapo, kar storimo tako, da gremo pod kaskadni meni "Create New" in nato kliknemo na "Folder" ter vpišemo ime naše nove mape, torej "sredstva".
//   ]
// })
```

```
// TODO (Gorazd): Opažam, da ponekod najprej pišeta angleške izraze, ponekod pa najprej slovenske. To je smiselno poenotiti. Ker Godotovega vmesnika še nimamo v slovenščini, predlagam vedno najprej angleški zapis, ko se prvič pojavi v besedilu, pa v oklepaju tudi slovensko razlago.
```