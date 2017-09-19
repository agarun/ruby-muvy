# muvy

A Ruby movie barcode generator.

## The Plan

* The app handles local video files and some online media. It employs a Ruby wrapper for youtube-dl to accept video URLs and store them temporarily.
* A Ruby FFmpeg wrapper creates thumbnails of the video at fixed intervals based on its length and frame rate.
* A Ruby wrapper for ImageMagick is used to extract color data from each image.
* The final images are currently generated based on the average colors of each relevant frame. I'm really eager to add a 'dominant color' option accomplished by k-means clustering, however this is a very intensive algorithm to run over an entire video file.
* There will be a few command-line options available to adjust the final image, namely to fade colors or change the resolution.
