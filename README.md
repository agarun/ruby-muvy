![muvy-header](https://i.imgur.com/Akc3Fh9.png)

**muvy** is a simple Ruby movie barcode generator. Videos go in, mushy images comes out. It pulls most of the frames out of a video, moves around the colors, and throws them all back together!

------
* [Installation](#installation)
  * [Notes](#notes)
  * [Getting Started](#getting-started)
* [Usage](#usage)
  * [Basics](#basics)
  * [Options](#options)
  * [Features](#features)
* [Examples](#examples)
------

## Installation

### Notes

* Currently version 0.2.0, with many [features planned](#features).
* In the `master` branch, the app uses FFmpeg, ImageMagick, and youtube-dl Ruby wrappers. It depends on the gems  [streamio-ffmpeg](https://github.com/streamio/streamio-ffmpeg) and [minimagick](https://github.com/minimagick/minimagick), which individually depend on the relevant binaries. It also depends on the  [youtube-dl.rb](https://github.com/layer8x/youtube-dl.rb) gem, which ships with the latest version of youtube-dl.
* In the `open3` branch, the app uses [Open3](https://apidock.com/ruby/Open3/popen3) to directly access [FFmpeg](https://www.ffmpeg.org/), [ImageMagick](https://www.imagemagick.org/script/index.php), and [youtube-dl](https://rg3.github.io/youtube-dl/) from the command-line.

### Getting Started

#### macOS
If you don't already have FFmpeg and ImageMagick installed (you can use `ffmpeg -v` or `convert -v` in terminal to check if you do), you can download all of them with [Homebrew](https://brew.sh/). With Homewbrew, just bring up a terminal session and type:  
`brew install ffmpeg`  
`brew install imagemagick`  
`gem install muvy`  

#### Windows
You can [download Ruby here]().  
Then you can download [FFmpeg here]().. and then download [ImageMagick here]().   
After installing everything, you can install any gem like so:  
`gem install muvy`

## Usage

### Basics

| Type   | Command                                    | Support                                                                                       |
|--------|--------------------------------------------|-----------------------------------------------------------------------------------------------|
| URL    | `muvy https://someVideoSite.com/someVidID` | [youtube-dl supports hundreds of sites](https://rg3.github.io/youtube-dl/supportedsites.html) |
| Local  | `muvy /Documents/Video-Backup-3/movie.mp4`  | <file types supported by FFmpeg go here>                                                      |
| Folder | `muvy /Downloads/Phone-Backup-1/Photos`   | <file types supported by imagemagick go here>                                                 |

Note for the `folder` option: ImageMagick `convert` does *not* modify ("mogrify") images in place, meaning it keeps the original files as they are. However, I would recommend you make a backup just in case when using this option.

### Options

Insert Slop printout here

#### Path

ehhh

#### Rotate

uhhhh

#### Other stuff

ooohhh...

#### Extra

* -frame_rate

### Features
- [x] Vertical lines (via -rotate)
- [x] Horizontal lines
- [x] Stretched output
- [ ] Spotmap output (something like a QR code)
- [ ] [Slit scan](http://www.flong.com/texts/lists/slit_scan/) output
- [ ] Carpet-like output (wavy lines)
- [ ] Dominant color algorithms
 - [ ] via ImageMagick histograms
 - [ ] via k-means clustering
- [x] Specifying start & end times for frame extraction
- [ ] Pixel thickness control
- [ ] Accepting image galleries (e.g. Phone DCIM)
- [ ] Adding presets (late stage feature)

## Examples

// title //
// picture //
// code used to generate it //  

Also see References#examples


## References
* Examples
  * // Section with others work //
* Movie barcodes, etc
* Slit scanning, etc
* Dominant color algorithms
* ImageMagick Histograms research, etc
