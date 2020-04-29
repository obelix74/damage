current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require 'concurrent'
require 'rmagick'
include Magick
require 'json'

file = File.read File.expand_path(File.dirname(File.dirname(__FILE__))) + '/image_list.json'
files = JSON.parse file

pool = Concurrent::FixedThreadPool.new(20)

files.each do |file|
	thumbnail_file = THUMBNAILS_FOLDER + file + '.png'
	if File.exist? thumbnail_file
		p "File: #{thumbnail_file} exists"
	else
		pool.post do
			p "Creating thumbnail for #{file}"
			begin
				img = Image.read(file)[0]
				size = 512
				geom = "#{size}x#{size}"
				img.change_geometry!(geom) { |cols, rows| img.thumbnail! cols, rows }
				p "Writing thumbnail file #{thumbnail_file}"
				img.write(thumbnail_file)
			rescue exception
				p "Error creating thumbnail for #{file}"
			end
		end		
	end
end

pool.shutdown
pool.wait_for_termination
