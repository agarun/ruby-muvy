![muvy-header](https://i.imgur.com/Akc3Fh9.png)

**muvy** is a simple Ruby movie barcode generator.  
You can feed it a youtube video, phone gallery, or any locally stored video files. It pulls most of the frames out, moves around the colors, and throws them back together in a neat montage.

------
* [Install](#install)
  * [Notes](#notes)
  * [Getting Started](#getting-started)
* [Usage](#usage)
  * [Basics](#basics)
  * [Options](#options)
  * [Features](#features)
* [Examples](#examples)
* [Links](#links)
------

## Install

### Notes

* Currently version 0.2.0, with many [features still planned](#features).

### Getting Started

#### macOS
If you don't already have FFmpeg and ImageMagick installed (you can use `ffmpeg -v` or `convert -v` in terminal to check if you do), you can download all of them with [Homebrew](https://brew.sh/).   

With Homewbrew, just bring up a terminal session and type:  
```sh
$ brew install ffmpeg
$ brew install imagemagick
$ gem install muvy
```

#### Windows
1. You can [download Ruby here](https://rubyinstaller.org/).  
2. Then you can grab [FFmpeg here](http://ffmpeg.zeranoe.com/builds/)..  
3. ..and then download [ImageMagick here](https://www.imagemagick.org/script/download.php#windows).   
4. After installing everything, make sure you can access `ffmpeg -v` or `convert -v` on the command line. If you can't, you likely have to update your existing PATH environment variable [like this](https://video.stackexchange.com/questions/20495/how-do-i-set-up-and-use-ffmpeg-in-windows).  
5. Then, you can install any gem like so:  
```sh
$ gem install muvy
```


## Usage

### Basics

| Type   | Command: `muvy [Type] [Options]`                                    | Support                                                                                       |
|--------|--------------------------------------------|-----------------------------------------------------------------------------------------------|
| URL    | `muvy https://someVideoSite.com/someVidID` | [youtube-dl supported sites](https://rg3.github.io/youtube-dl/supportedsites.html) |
| Local  | `muvy /Documents/Fave-Films/movie.mp4`  | [FFmpeg supported formats](https://www.ffmpeg.org/general.html#File-Formats)                                                      |
| Folder | `muvy /Downloads/Phone-Backup-1/Photos`   | [ImageMagick supported formats](https://www.imagemagick.org/script/formats.php)                                                 |

### Options

#### `-p, --path`

Optionally specify the path where your final image will be saved.  
**Default**: your present working directory

#### `-s, --style`
Optionally specify currently supported styles: [solid](link) or [stretch](link).  
**Default**: solid

#### `-g, --gradient`
Optionally add a gradient on top of the final image.

Choose one:
```
black:heavy black:medium black:light
white:heavy white:medium white:light
```
**Default**: none

[See examples](link)  

#### `--arc`
Wrap all of the lines around a center point.

[See examples](link)  

#### `--rotate`
Pass `--rotate` to rotate the final image 90 degrees, i.e. to draw horizontal lines,
where the top is the 'start' of your media file.  
TODO - check if the last sentence is true

#### `-h, --height`
Optionally specify a custom height for the output image.

#### `--format`
Optionally force the download quality for `youtube-dl`.  
This determines the height of your image when using `-s stretch` only if you didn't specify --height.  
**Default**: 135 *(854x480 DASH at 24fps)*  

See [youtube-dl docs on format selection](https://github.com/rg3/youtube-dl/blob/master/README.md#format-selection).

#### `--frame_rate`
Optionally specify the amount of frames to extract per second from the media.  
This determines the width of the image.  

You should run `muvy [..]` without this option once and check the stats printout
to get an idea of a better number.  
For example, if the stats printout used "1.6 fps," passing `--frame_rate 3.2`
would double the amount of frames, lines, and subsequently the width.

> Setting this to an unreasonable number might cause hundreds of thousands
of files to be temporarily created in your system's temp files!

#### `--start` and `--end`
Optionally specify starting and ending times for processing videos.  
If you only specify one of them, the other will default to the start/end.

[Examples](link)

### Features
- [x] Accepting image galleries, local videos, and online videos
- [x] Specifying start & end times for frame extraction
- [x] Vertical lines
- [x] Horizontal lines
- [x] Stretched output (average of each line of pixels)
- [x] Arc distortion
- [ ] Spotmap output ('QR' code)
- [ ] Slit scan output
- [ ] 'Bedforms' output
- [ ] Dominant color algorithms
 - [ ] via ImageMagick histograms
 - [ ] via k-means clustering
- [ ] Fade to black or white on edges
- [ ] Pixel thickness control
- [ ] Colorspace adjustments
- [ ] Accept music files
 - [ ] Generate audio waveforms
 - [ ] Randomize waveform colors
- [ ] Presets

## Examples

// title //
// picture //
// code used to generate it //  

Also see References#examples


## Links
* Binaries · Gems
  * [FFmpeg](https://www.ffmpeg.org/documentation.html) · [Streamio FFmpeg](https://github.com/streamio/streamio-ffmpeg)
  * [ImageMagick](https://www.imagemagick.org/script/command-line-options.php) · [MiniMagick](https://github.com/minimagick/minimagick)
  * [youtube-dl](https://github.com/rg3/youtube-dl) · [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb)
* Other Works & Inspirations
  * [Zach Whalen's Barcoder](http://zachwhalen.net/pg/barcoder/)
  * [moviebarcode on tumblr](http://moviebarcode.tumblr.com/)
  * [/u/etherealpenguin on reddit](https://www.reddit.com/r/dataisbeautiful/comments/3rb8zi/the_average_color_of_every_frame_of_a_given_movie/)
  * [Colors of Motion](http://thecolorsofmotion.com/films)
* Slit scanning
  * [informal catalogue of research on this topic by Levin](http://www.flong.com/texts/lists/slit_scan/)
* K-means clustering as dominant color algorithms
  * [k-means clustering on wikipedia](link)
  * <>
* ImageMagick Histograms
  * [Sparse color docs](http://www.imagemagick.org/Usage/canvas/#sparse-color)
  * [Stackoverflow discussion (1)](https://stackoverflow.com/questions/40381273/apply-gradient-mask-on-image-that-already-has-transparency-with-imagemagick)
* ImageMagick support
  * tremendous thank you to [fmw](http://www.fmwconcepts.com/imagemagick/index.php) & [snibgo](http://im.snibgo.com/index.htm)
