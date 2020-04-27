require 'rmagick'
include Magick

current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
image = current_dir + '/test.NEF'
img = Image.read(image)[0]
size = 512
geom = "#{size}x#{size}"
img.change_geometry!(geom) { |cols, rows| img.thumbnail! cols, rows }
img.write(current_dir + '/test.NEF.png')