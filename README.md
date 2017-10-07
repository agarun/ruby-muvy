![muvy-header](https://i.imgur.com/Akc3Fh9.png)

**muvy** is a simple Ruby movie barcode generator. Videos go in, crispy images come out.  
You can feed it a youtube video, phone gallery, or any locally stored video files. It pulls most of the frames out, moves around the colors, and throws them all back together.

------
* [Install](#install)
  * [Notes](#notes)
  * [Getting Started](#getting-started)
* [Usage](#usage)
  * [Basics](#basics)
  * [Options](#options)
  * [Features](#features)
* [Examples](#examples)
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
| Local  | `muvy /Documents/Video-Backup-3/movie.mp4`  | [FFmpeg supported formats](https://www.ffmpeg.org/general.html#File-Formats)                                                      |
| Folder | `muvy /Downloads/Phone-Backup-1/Photos`   | [ImageMagick supported formats](https://www.imagemagick.org/script/formats.php)                                                 |

### Options

#### `-p, --path`

Optionally specify the path where your final image will be saved.  
**Default**: your present working directory

#### `-s, --style`
Optionally specify currently supported styles: [solid](link) or [stretch](link).  
**Default**: solid

#### `--rotate`
Pass `--rotate` to rotate the final image 90 degrees, i.e. to draw horizontal lines,
where the top is the 'start' of your media file.  
[Two examples](link).

#### `-h, --height`
... no default hopefully ...

#### `--frame_rate`
Optionally specify the amount of frames to extract per second from the media.  
This determines the width of the image.  
You should run `muvy` without this option once and check the stats printout
to get an idea of a better number.

#### `--start` and `--end`
Optionally specify starting and ending times for processing videos.  
Example:
* KOSAKSOKASKSOK

### Features
- [x] Accepting image galleries, local videos, and online videos
- [x] Specifying start & end times for frame extraction
- [x] Vertical lines
- [x] Horizontal lines
- [x] Stretched output (average of each line of pixels)
- [ ] Spotmap output ('QR' code)
- [ ] [Slit scan](http://www.flong.com/texts/lists/slit_scan/) output
- [ ] 'Bedforms' output
- [ ] Dominant color algorithms
 - [ ] via ImageMagick histograms
 - [ ] via k-means clustering
- [ ] Fade to black or white on edges
- [ ] Pixel thickness control
- [ ] Colorspace adjustments
- [ ] Accept music files
 - [ ] Generate audio waveforms
- [ ] Presets

## Examples

// title //
// picture //
// code used to generate it //  

Also see References#examples


## References
* Other movie barcode generators and collections
  * [moviebarcode on tumblr](http://moviebarcode.tumblr.com/)
  * [/u/etherealpenguin on reddit](https://www.reddit.com/r/dataisbeautiful/comments/3rb8zi/the_average_color_of_every_frame_of_a_given_movie/)
  * lots of others iirc
  * the python dudes for sure too
* Slit scanning
* K-means clustering as dominant color algorithms
  * [k-means clustering on wikipedia](link)
  * blogposts..
* ImageMagick Histograms
* Binaries · Gems
  * [FFmpeg](https://www.ffmpeg.org/documentation.html) · [Streamio FFmpeg](https://github.com/streamio/streamio-ffmpeg)
  * [ImageMagick](https://www.imagemagick.org/script/command-line-options.php) · [MiniMagick](https://github.com/minimagick/minimagick)
  * [youtube-dl](https://github.com/rg3/youtube-dl) · [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb)
