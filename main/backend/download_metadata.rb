current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require 'concurrent'
require 'mini_exiftool'
require 'json'

file = File.read File.expand_path(File.dirname(File.dirname(__FILE__))) + '/image_list.json'
files = JSON.parse file

pool = Concurrent::FixedThreadPool.new(10)

files.each do |file|
	metadata_file = METADATA_FOLDER + file + '.json'
	if File.exist? metadata_file
		p "File: #{metadata_file} exists"
	else
		pool.post do
			p "Fetching metadata for #{file}"
			begin
	   			photo = MiniExiftool.new File.expand_path file
	   			p "Writing metadata to file #{metadata_file}"

	   			tags = {}
				photo.tags.each do |tag|
					tags[tag] = photo[tag]
				end

	   			File.open metadata_file, 'w' do |file|
					file.write tags.to_json
				end
			rescue exception
				p "Error fetching EXIF for #{file}"
			end
		end		
	end
end

pool.shutdown
pool.wait_for_termination