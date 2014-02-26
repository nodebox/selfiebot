Selfiebot
=========
Selfiebot is a drawing robot that draws quick selfie images. This is a Processing sketch that converts the images to G-code using a canny edge detection.

![Demo selfiebot output](https://raw.github.com/nodebox/selfiebot/master/g/selfie.jpg)

Usage
=====
1. Download [Processing](http://processing.org/download/).
2. Download and install the [controlP5 library](http://www.sojamo.de/libraries/controlP5/)
3. Open the sketch and run it.
4. Stand in front of the webcam.
5. Press the spacebar to export the current image to G-code.
6. Import G-code file into Makelangelo software while drawbot is running.
7. Calibrate the pen and start drawing.

Credits
=======
* Original sketch by [TODO](http://www.todo.to.it/)
* [Canny edge detection](http://www.tomgibara.com/computer-vision/canny-edge-detector) algoritm by Tom Gibara.
* Selfiebot uses a [Makelangelo Kit](https://github.com/MarginallyClever/Makelangelo)

License
=======
Selfiebot is released under the [Creative Commons Attribution-NonCommercial-ShareAlike 3.0 license](http://creativecommons.org/licenses/by-nc-sa/3.0/).
