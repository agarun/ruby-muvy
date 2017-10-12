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
* [Troubleshooting](#troubleshooting)
* [Links](#links)
------

## Install

### Notes

* Currently version 0.1.2, with many [features still planned](#features).
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
  On the third installation window, [you need to check 2 boxes](https://i.imgur.com/d46sn8a.png):
    - [x] Add application directory to your system path
    - [x] Install legacy utilities (e.g. convert)
    - [ ] Keep 'Install FFmpeg' unchecked - IM's bundle doesn't include `ffprobe` & `ffplay`
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
Optionally add a gradient on top of the final image. You can choose one:
```
black:heavy black:medium black:light
white:heavy white:medium white:light
```
**Default**: none

#### `--arc`
Pass `--arc` to wrap all of the lines around a center point. [See examples](#examples)  

#### `--rotate`
Pass `--rotate` to rotate the final image 90 degrees, i.e. to draw horizontal lines,
where the top is the 'start' of your media file.  

#### `-h, --height`
Optionally specify a custom height for the output image.

#### `--format`
Optionally force the download quality for `youtube-dl`.  
This command is currently best-suited to youtube. To see possible formats for other sites, type `youtube-dl -F <URL>` or see [youtube-dl docs on format selection](https://github.com/rg3/youtube-dl/blob/master/README.md#format-selection); however, even when specifying a suitable format, the script might fail to run.  
This determines the height of your image when using `-s stretch` only if you didn't specify --height.  
**Default**: 135 *(854x480 DASH at 24fps)*.

#### `--frame_rate`
Optionally specify the amount of frames to extract per second from the media.  
This determines the width of the image.  

You should run `muvy [..]` without this option once and check the stats printout
to get an idea of a better number.  
For example, if the stats printout reads "1.6 fps," passing `--frame_rate 3.2`
would double the amount of frames, lines, and subsequently the width.

> Setting this to an unreasonable number might cause hundreds of thousands
of files to be temporarily created in your system's temp files.

#### `--start` and `--end`
Optionally specify starting and ending times for processing videos.  
If you only specify one, the other will default (e.g. if you only give --end, start is 0).


### Features
- Formats
  - [x] Accepts image galleries, local videos, and online videos
    - [ ] Works with *any* size image folder (very large folders cause output issues)
    - [ ] Works with *any* youtube-dl supported site
    - [x] Specify start & end times for frame extraction
  - [ ] Accept music files
    - [ ] Generate audio waveforms
    - [ ] Randomize waveform colors
- Image Output
  - [x] Vertical lines
  - [x] Horizontal lines
  - [x] 'Stretched' output, taking average of each line of pixels
  - [x] Arc distortion
  - [ ] Spotmap output, akin to 'QR' code
  - [ ] Slit scan output
  - [ ] 'Bedforms' output
  - [ ] Stacked lines output, inspired by [Sol Lewitt's work](https://www.google.com/search?q=sol+lewitt&rlz=1C5CHFA_enUS757US757&source=lnms&tbm=isch&sa=X&ved=0ahUKEwjLjP7y5unWAhWb0YMKHcNQBhcQ_AUICigB&biw=1276&bih=680)
    - [ ] Choose inset borders
    - [ ] Curvature
  - [ ] Crosshatch lines output
- Image adjustments
  - [x] Fade to black or white on edges
  - [ ] Pixel thickness control
  - [ ] Colorspace changes
- Generation
  - [ ] Dominant color algorithms
    - [ ] via ImageMagick histograms
    - [ ] via k-means clustering
- Compatibility
  - [ ] Use `popen3` since current gem wrappers are outdated (TODO)

## Examples

### Films

<div align="center">
<img src="https://i.imgur.com/FpERYDO.png" />  
<h4>Spirited Away (2001)</h4>

`muvy film.mkv -h 300`  

0.27 frames per second on 125 minutes  
final resolution 2027x300  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/dpyoILD.png" />   
<h4>Mad Max: Fury Road (2015)</h4>

`muvy madden.mkv --end 01:52:50 -h 300`   

0.276 frames per second on 120 minutes  
final resolution 1868x300  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/ahDpJms.png" />
<h4>The Grand Budapest Hotel (2014)</h4>

`muvy "grand.avi" --end 01:33:40 --gradient black:medium --height 600`  

0.303 frames per second on 100 minutes  
final resolution 1703x600  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/pov6s07.png" />   
<h4>Her (2013)</h4>

`muvy film.mp4 -g black:medium -h 720`   

0.269 frames per second on 126 minutes  
final resolution 1919x720  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/JEHqHoG.png" />   
<h4>Melancholia (2011)</h4>

`muvy film.mp4 --gradient black:medium`   

0.277 frames per second on 136 minutes  
final resolution 2158x720  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/Up9SWKm.png" />  
<h4>Kagemusha (1980)</h4>

`muvy film.mp4 --style stretch --gradient black:medium`  

0.225 frames per second on 162 minutes  
final resolution 2439x688  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/j9yNVdN.png" />   
<img src="https://i.imgur.com/OgOgnz0.png" />   
<h4>Samsara (2011)</h4>

(1) `muvy film.avi --end 01:35:00 -s stretch -g black:medium`  


(2) `muvy film.avi --height 150 --end 01:35:00`  

0.3 frames per second on 95 minutes  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/7b7MWHX.png" />   
<h4>Baraka (1992)</h4>

`muvy film.avi --height 150 --end 01:30:30`   

0.3 frames per second on 90 minutes   
final resolution 1663x150  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/Q3ETqJT.png" />   
<h4>It's Such A Beautiful Day (2012)</h4>

`muvy film.mkv --height 200`   

0.4843 frames per second on 62 minutes  
final resolution 1780x720    
</div>  

<br><br>

### YouTube

<div align="center">
<img src="https://i.imgur.com/V0ecs7s.png" />   
<h4>Holi by Variable</h4>

`muvy https://www.youtube.com/watch?v=r64Xk7c4Mr4 --frame_rate 10 --style stretch`   

slow-motion youtube video   
10 frames per second on 1 minute 47 seconds   
final resolution 1073x480  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/F00eot2.png" />   
<img src="https://i.imgur.com/rA2Ugr1.png" />     
<h4>Mahalia - Sober by COLORS</h4>

(1) `muvy https://www.youtube.com/watch?v=QK7JQl9jNzM --frame_rate 7.5 --start 0:05 --end 3:23 -h 200`  


(2) `muvy https://www.youtube.com/watch?v=QK7JQl9jNzM --frame_rate 7.5 --start 0:05 --end 3:23 -s stretch`  

7.5 frames per second on 3 minutes 36 seconds  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/OMR4ffy.png?1" />
<h4>The Banach–Tarski Paradox by Vsauce</h4>

`muvy https://www.youtube.com/watch?v=s86-Z-CbaHA`     

0.62 frames per second on 24 minutes 14 seconds  
final resolution 898x720  
</div>  

<br><br>

<div align="center">
<img src="https://i.imgur.com/pdHnMQQ.png" />   
<h4>Colors In Macro by Macro Room</h4>

`muvy https://www.youtube.com/watch?v=gNbSjMFd7j4 --start 0:16 --end 2:07 --style stretch --frame_rate 10`     

10 frames per second on ~ 2 minutes  
final resolution 1110x480  
</div>  

<br><br>

<div align="center">
<img src="https://image.ibb.co/g4WEVb/3.png" width="350" height="350" hspace="20" />
<img src="https://image.ibb.co/eLRsGG/2.png" width="350" height="350" />    
<h4>Ink In Motion by Macro Room</h4>

(1) `muvy https://www.youtube.com/watch?v=BmBh0NNEm00 --start 0:37 --end 1:20 --frame_rate 10 -r -s stretch`       


(2) `muvy https://www.youtube.com/watch?v=BmBh0NNEm00 --start 0:37 --end 1:20 --frame_rate 10 -r --arc`   

</div>  

<br><br>

<div align="center">
<img src="https://preview.ibb.co/e49VLb/muvy_11_10_031219.png" width="300" height="300" />
<h4>BBC Planet Earth II Episode 1</h4>

`muvy episode.mp4 --arc -g black:light`    

0.413 frames per second on 58 minutes  
final resolution 1176x1176  

<br><br>

<img src="https://image.ibb.co/b2GmbG/muvy_11_10_042756.png" width="300" height="300" />
<h4>Speed Drawing</h4>

`muvy https://www.youtube.com/watch?v=P3UozWhL6A0 --start 0:04 --end 04:45 --arc`  

1.7185 frames per second  
final resolution 872x872  
</div>  

<br><br>

### DCIM  

DCIM merging is currently a bit buggy in that it will create extra random lines if it's low on memory.

<div align="center">
<img src="https://i.imgur.com/0DbOO11.png" height="400" />
<h4>2016 Travel</h4>

`muvy imagefolder/`  

2350 photos
</div>  

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
