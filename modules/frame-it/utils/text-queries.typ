// This module contains a copied and version of the `text-queries.typ` file from
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

#let lang-is-left-to-right() = {
  let rtl-langs = (
    "ar",
    "dv",
    "fa",
    "he",
    "ks",
    "pa",
    "ps",
    "sd",
    "ug",
    "ur",
    "yi",
  )
  text.lang not in rtl-langs
}

#let text-is-left-to-right() = if text.dir == auto {
  lang-is-left-to-right()
} else {
  text.dir == ltr
}

#let real-text-direction() = if text-is-left-to-right() { ltr } else { rtl }