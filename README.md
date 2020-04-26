# Introduction

`Damage` is a highly opinionanted `Digital Asset Management (DAM)` tool with minimal features.  I wrote this so that I can quickly search my `RAW` images on my slow access NAS and identify the images I want to bring over to my computer for processing.

# Approach

* `Damage` scans the list of image directories provided and gathers the `EXIF` information and writes them to a designated `metadata` folder.
* It replicates the directory structure of the image directories under `metadata` folder.  For instance:
    * Consider `raw image folder` called `/Volumes/Pictures/2000/Asia/03/22`
    * Assume that all the metadata is configured to be written under `/Volumes/Data/damage`
    * A directory called `/Volumes/Data/damage/Volumes/Pictures/2000/Asia/03/22` will be created and the `EXIF` information will be written down with the name of the file
    * If the image is called `DSC001.NEF`, then the `EXIF` file would be in `/Volumes/Data/damage/Volumes/Pictures/2000/Asia/03/22/DSC001.NEF.json`
* A similar directory approach will be followed for generating thumbnails for images in a parallel directory structure
* `ElasticSearch` will be used to create search indices based on the `EXIF` information
* A simple server less Javascript GUI will be created which uses the index to render the images as thumbnails
* From the GUI, the following would be possible:
	* Using `ElasticSearch` to create complex queries
	* Update `rating`, `description`, `title`, `categories` and `keywords`.  These will *not* be written back to the original RAW file.  This will be added to the metadata `JSON` file and indices will be updated. A utility may be provided later to copy this over to the original image, if needed
	* User can select the result of search and click a button to copy the selected files over to your local filesystem

# What damage is not

* It won't update your original RAW files unless you ask for it
* It is not standards compliant with `XMP` and that support will not be added 
* This is not a polished product. It is a collection of scripts and a Javascript library.  You have to run scripts by hand and open the JS in a browser

# Required libraries

## Exiftool

Install `exiftool` by following instructions in https://exiftool.org/

## Ruby gems

From the root directory, install gems by running `bundle`.  Enter `sudo` password if asked for.

## Workflow

* Edit `main/backend/constants.rb` and update the paths 
* Run `ruby prepare_directories.rb`.  This creates the directory structure under `#{METADATA_FOLDER}` based on your `#{RAW_FOLDERS}` and generates a `image_list.json` that contains all the images to scan
* Run `ruby download_metadata.rb`.  This gathers all the `EXIF` information for the images and writes them to an appropriate folder under metadata


