# Hypercube^2

This printer is based on the Hypercube and Hypercube Evolved printer designs, but re-implemented entirely using OpenSCAD so that it is fully parametric and easy to extend/modify.

## Motivation

I was planning to build the Hypercube Evolved, but received the advice: "Use the designs as inspiration for your own." Thus, was born the `Hypercube^2`. I encourage you to fork it yourself.

It's design was guided by the following choices:

- Minimal external parts to simplify building an enclosure around the outside of the frame.
- Robust Z-axis to support both 3D printing and future CNC tools.
- Linear guides for all axes for simplicity and compactness.
- CoreXY design with balanced belts for uniform x/y axis performance and accuracy.
- Belt driven Z-axis lead screws to avoid problems with alignment due to skipping.
- Preference on direct-drive extruder rather than bowden tube.

## Parts Required

As this is a parametric design, the specific parts will depend on how you build the printer. However, based on a 400x400x400 build volume:

- 7x linear rods.
- 4x 1m 2020 struts to cut.
- 8x 1m 2040 struts to cut.

## Instructions

To come...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2017, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.