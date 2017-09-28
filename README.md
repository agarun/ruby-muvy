# muvy

A Ruby movie barcode generator.

## Work In Progress
------

### Notes

* A simple Ruby experiment! In the `master` branch, the app uses FFmpeg, ImageMagick, and youtube-dl Ruby wrappers. It depends on [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb), [streamio-ffmpeg](https://github.com/streamio/streamio-ffmpeg), and [minimagick](https://github.com/minimagick/minimagick).
* In the `open3` branch, the app uses [Open3](https://apidock.com/ruby/Open3/popen3) to directly access [FFmpeg](https://www.ffmpeg.org/), [ImageMagick](https://www.imagemagick.org/script/index.php) , and [youtube-dl](https://rg3.github.io/youtube-dl/)) from the command-line.

### Features planned
- [ ] Horizontal & vertical lines output
- [ ] Spotmap output ('QR')
- [ ] Carpet output
- [ ] Dominant color algorithm (k-means clustering)
