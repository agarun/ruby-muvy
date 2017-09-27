# muvy

A Ruby movie barcode generator.

## Work In Progress
------

### Notes

* The app does not use [Open3](https://apidock.com/ruby/Open3/popen3) to access FFmpeg, ImageMagick, or youtube-dl. Instead, it requires [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb) (a wrapper for [youtube-dl](https://rg3.github.io/youtube-dl/)), [streamio-ffmpeg](https://github.com/streamio/streamio-ffmpeg) (an [FFmpeg](https://www.ffmpeg.org/) wrapper), and [minimagick](https://github.com/minimagick/minimagick) (an [ImageMagick](https://www.imagemagick.org/script/index.php) wrapper).
