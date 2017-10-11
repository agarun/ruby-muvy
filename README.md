<p align="center">
  <img src="https://i.imgur.com/Akc3Fh9.png" alt="muvy-header" />
</p>

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

* Currently version 0.1.1, with many [features still planned](#features).
* Not optimized for sites other than YouTube

### Getting Started

#### macOS
You can use `ffmpeg -v`, `convert -v`, or `youtube-dl --version` at the terminal to check if you already have the binaries.

If you don't already have FFmpeg, ImageMagick, or youtube-dl installed, you can download all of them with [Homebrew](https://brew.sh/). With Homebrew, just bring up a terminal session and type:

```sh
$ brew install ffmpeg
$ brew install imagemagick
$ brew install youtube-dl
$ gem install muvy
```

#### Windows
1. You can [download Ruby here](https://rubyinstaller.org/).  
2. You can download Windows binaries for [ImageMagick here](https://www.imagemagick.org/script/download.php#windows), **noting**:
  * On the third installation window, [you need to check 2 boxes](https://i.imgur.com/d46sn8a.png):
    * [x] Add application directory to your system path
    * [x] Install legacy utilities (e.g. convert)
    * [ ] Keep 'Install FFmpeg' unchecked - IM's bundle doesn't include `ffprobe` & `ffplay`
2. Grab [FFmpeg here](http://ffmpeg.zeranoe.com/builds/).
3. You'll have to manually edit your PATH environment variable [like in this tutorial](https://www.wikihow.com/Install-FFmpeg-on-Windows).
Once you set up FFmpeg in the PATH, you need to move the ImageMagick folder from 'User Variables' to the first entry in the 'System Variables' PATH variable so that Windows prefers ImageMagick `convert` over its own 'convert.exe'. [Here's an image showing that process](https://i.imgur.com/cf4HvCb.png).  
ImageMagick 7 replaced `convert` with `magick` on Windows, but this gem can't make use of that yet.
4. Get [youtube-dl here](https://rg3.github.io/youtube-dl/download.html).   
5. Then, you can install any gem like so:  
```sh
$ gem install muvy
```


## Usage

### Basics

| Type   | Command: `muvy [Type] [Options]`                                    | Support                                                                                       |
|--------|--------------------------------------------|-----------------------------------------------------------------------------------------------|
| URL    | `muvy https://youtube.com/someVidID` | [youtube-dl sites](https://rg3.github.io/youtube-dl/supportedsites.html), but most fail |
| Local  | `muvy /Documents/Fave-Films/movie.mp4`  | [FFmpeg supported formats](https://www.ffmpeg.org/general.html#File-Formats)                                                      |
| Folder | `muvy /Downloads/Phone-Backup-1/Photos`   | [ImageMagick supported formats](https://www.imagemagick.org/script/formats.php)                                                 |

### Options

#### `-p, --path`

Optionally specify the path where your final image will be saved.  
**Default**: your present working directory

#### `-s, --style`
Optionally specify currently supported styles: solid, stretch.  
**Default**: solid

#### `-g, --gradient`
Optionally add a gradient on top of the final image.

Choose one:
```
black:heavy black:medium black:light
white:heavy white:medium white:light
```
**Default**: none

[See examples](#examples)  

#### `--arc`
Pass `--arc` to wrap all of the lines around a center point.

[See examples](#examples)  

#### `--rotate`
Pass `--rotate` to rotate the final image 90 degrees, i.e. to draw horizontal lines,
where the top is the 'start' of your media file.  
TODO - check if the last sentence is true

#### `-h, --height`
Optionally specify a custom height for the output image.

#### `--format`
Optionally force the download quality for `youtube-dl`.  
This command is currently best-suited to youtube. To see possible formats for other sites, type `youtube-dl -F <URL>`; however, even when specifying a suitable format, the script might fail to run.  
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
of files to be temporarily created in your system's temp files.

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
- [ ] Works with any youtube-dl supported site
- [ ] Dominant color algorithms
 - [ ] via ImageMagick histograms
 - [ ] via k-means clustering
- [x] Fade to black or white on edges
- [ ] Pixel thickness control
- [ ] Colorspace adjustments
- [ ] Accept music files
 - [ ] Generate audio waveforms
 - [ ] Randomize waveform colors
- [ ] Presets

## Examples

### Films

<p align="center">
  <img src="https://i.imgur.com/FpERYDO.png" />  
</p>  

**Film**: Spirited Away, released in 2001, runs for 125 minutes  
**Command**: `muvy film.mkv -h 300`  
**Statistics**: generated at 0.2712 frames per second, final output 2027x300  


<p align="center">
  <img src="https://i.imgur.com/ahDpJms.png" />
</p>

**Film**: The Grand Budapest Hotel, released in 2014, runs for 100 minutes  
**Command**: `muvy "grand.avi" --end 01:33:40 --gradient black:medium --height 600`  
**Statistics**: generated at 0.303 frames per second, final output 1703x600


<p align="center">
  <img src="https://i.imgur.com/Up9SWKm.png" />  
</p>  

**Film**: Kagemusha, released in 1980, runs for 162 minutes  
**Command**: `muvy film.mp4 --style stretch --gradient black:medium`  
**Statistics**: generated at 0.225 frames per second, final output 2439x688  


<p align="center">
  <img src="https://i.imgur.com/Q3ETqJT.png" />  
</p>  

**Film**: It's Such A Beautiful Day, released in 2012, runs for 62 minutes  
**Command**: `muvy movie.mkv --height 200`  
**Statistics**: generated at 0.4843 frames per second, final output 1780x720  


<TODO: Samsara, Melancholia, Her, Mad Max, Leon the Professional>


### YouTube

<p align="center">  
  <img src="https://i.imgur.com/ZnydeV2.png" width="452" height="455" />  
</p>  

**Video**: Holi by Variable, runs for 1 minute 47 seconds  
**Command**: `muvy https://www.youtube.com/watch?v=r64Xk7c4Mr4 --frame_rate 10 --style stretch -g white:medium`  
**Statistics**: generated at 10 frames per second  


<p align="center">
  <img src="https://i.imgur.com/F00eot2.png" />  
</p>  

<p align="center">
  <img src="https://i.imgur.com/rA2Ugr1.png" />  
</p>  

**Video**: Mahalia - Sober, runs for 3 minutes 36 seconds  
**Command** (1): `muvy https://www.youtube.com/watch?v=QK7JQl9jNzM --frame_rate 7.5 --start 0:05 --end 3:23 --height 200`  
**Command** (2): `muvy https://www.youtube.com/watch?v=QK7JQl9jNzM --frame_rate 7.5 --start 0:05 --end 3:23 --style stretch`  
**Statistics**:  

<p align="center">
  <img src="https://i.imgur.com/OMR4ffy.png?1" />  
</p>  

**Video**: The Banach–Tarski Paradox - Vsauce   
**Command**: muvy https://www.youtube.com/watch?v=s86-Z-CbaHA  
**Statistics**: generated at 0.62 frames per second, final output 898x720  


### Arcs

<p align="center">
  <img src="https://preview.ibb.co/e49VLb/muvy_11_10_031219.png" width="350" height="350" hspace = "20" />
  <img src="https://image.ibb.co/b2GmbG/muvy_11_10_042756.png" width="350" height="350" />  
</p>


**Video** (left): BBC Planet Earth II episode 1, runs for 58 minutes  
**Command**: `muvy episode.mp4 --arc -g black:light`  
**Statistics**:  generated at 0.4133 frames per second, final output 1176x1176  

**Video** (right): Speed Drawing  
**Command**: `muvy https://www.youtube.com/watch?v=P3UozWhL6A0 --start 0:04 --end 04:45 --arc`  
**Statistics**: generated at 1.7185 frames per second, final output 872x872  

### DCIM  

Coming soon...  

## Troubleshooting

Make sure you can access `ffmpeg -v`, `magick -v`, and `youtube-dl --version` on the command line. If you can't, you likely have to update your existing PATH environment variable to include the folder holding the relevant binaries. If you're on Windows and you are unsure how to add FFmpeg to path, you can try any of these links: [1](https://github.com/adaptlearning/adapt_authoring/wiki/Installing-FFmpeg), [2](https://video.stackexchange.com/questions/20495/how-do-i-set-up-and-use-ffmpeg-in-windows), [3](https://www.wikihow.com/Install-FFmpeg-on-Windows).

If you're on Windows and *very* recently made changes, you probably have to reopen a command prompt window or restart for those changes to take effect.

You might also want to update all three binaries.

If it's not working out, [I've linked more generators](#links) and methods that you can try out, most of them depending on some combination of `ffmpeg` and `ImageMagick`.

## Links
* Binaries · Gems
  * [FFmpeg](https://www.ffmpeg.org/documentation.html) · [Streamio FFmpeg](https://github.com/streamio/streamio-ffmpeg)
  * [ImageMagick](https://www.imagemagick.org/script/command-line-options.php) · [MiniMagick](https://github.com/minimagick/minimagick)
  * [youtube-dl](https://github.com/rg3/youtube-dl) · [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb)
* Other Works & Inspirations
  * [Zach Whalen's Barcoder](http://zachwhalen.net/pg/barcoder/)
  * [arcanesanctum generator](http://arcanesanctum.net/movie-barcode-generator/)
  * [/u/etherealpenguin on reddit](https://www.reddit.com/r/dataisbeautiful/comments/3rb8zi/the_average_color_of_every_frame_of_a_given_movie/)
  * [moviebarcode on tumblr](http://moviebarcode.tumblr.com/)
  * [Colors of Motion](http://thecolorsofmotion.com/films)
* Slit scanning
  * [informal catalogue of research on this topic by Levin](http://www.flong.com/texts/lists/slit_scan/)
* K-means clustering as dominant color algorithms
  * [k-means clustering on wikipedia](link)
* ImageMagick Histograms
  * [Sparse color docs](http://www.imagemagick.org/Usage/canvas/#sparse-color)
  * [Stackoverflow discussion (1)](https://stackoverflow.com/questions/40381273/apply-gradient-mask-on-image-that-already-has-transparency-with-imagemagick)
* ImageMagick support
  * tremendous thank you to [fmw](http://www.fmwconcepts.com/imagemagick/index.php) & [snibgo](http://im.snibgo.com/index.htm)
