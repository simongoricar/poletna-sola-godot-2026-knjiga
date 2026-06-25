// This module contains a copied and version of the `html.typ` file from
// frame-it, see <https://github.com/marc-thieme/frame-it/tree/main/src/utils>.
//
// frame-it is licensed under MIT, see <https://github.com/marc-thieme/frame-it/blob/main/LICENSE>:
// 
// MIT License
//
// Copyright (c) 2024 Marc Thieme
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#let wants-html() = {
  "target" in dictionary(std) and target() == "html"
}

#let target-choose(html: auto, paged: auto) = context {
  assert(
    html != auto and paged != auto,
    message: "Please provide options for both `html` and `paged`.",
  )
  if wants-html() {
    if type(html) == function { html() } else { html }
  } else {
    if type(paged) == function { paged() } else { paged }
  }
}

#let elem(tag, body, ..attrs) = {
  assert(attrs.pos() == (), message: "You can only provide named arguments.")
  assert(
    wants-html(),
    message: "You can only use the `elem` function in an HTML context.",
  )
  let body-arg = if type(body) == function { body() } else { body }
  html.elem(tag, attrs: attrs.named(), body-arg)
}

#let elem-ignore(tag, body, ..attrs) = {
  assert(attrs.pos() == (), message: "You can only provide named arguments.")
  if wants-html() {
    let body-arg = if type(body) == function { body() } else { body }
    html.elem(tag, attrs: attrs.named(), body-arg)
  }
}

#let elem-ident(tag, body, ..attrs) = {
  assert(attrs.pos() == (), message: "You can only provide named arguments.")
  if wants-html() {
    let body-arg = if type(body) == function { body() } else { body }
    html.elem(tag, attrs: attrs.named(), body-arg)
  } else {
    body
  }
}

#let span(style, body, ..attrs) = elem(
  "span",
  body,
  style: style,
  ..attrs,
)
#let div(style, body, ..attrs) = elem("div", body, style: style, ..attrs)
#let hr(style, ..attrs) = elem("hr", style: style, ..attrs, none)

#let css(..args) = {
  assert(
    args.pos().map(type) in ((), (dictionary,)),
    message: "CSS function only accepts named arguments or one dictionary.",
  )
  let css-dict = if args.pos().len() == 1 {
    assert(args.named() == (:))
    args.pos().first()
  } else {
    args.named()
  }

  let parse(val) = if type(val) == color {
    val.to-hex()
  } else if type(val) != str {
    repr(val)
  } else {
    val
  }

  for (key, value) in css-dict {
    value = if type(value) == array {
      value.map(parse).join(" ")
    } else {
      parse(value)
    }
    key + ": " + value + "; "
  }
}