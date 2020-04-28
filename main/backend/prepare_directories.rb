current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require 'find'
require 'fileutils'
require 'json'

files = []
RAW_FOLDERS.each do |folder|
	p "Chdir to #{folder}"
	Dir.chdir(folder)
	Dir.glob("**/*/").each do |path|
	 	p "Directory: #{path}"
	 	if !path.to_s.match(/Cache|Settings|Trash|Output|Selects|CaptureOne/i)
		 	metadata_folder = METADATA_FOLDER + folder + '/' + path.to_s
		 	thumbnails_folder = THUMBNAILS_FOLDER + folder + '/' + path.to_s
		 	original_folder = folder + "/#{path}"
	 		
	 		unless File.directory?(metadata_folder) 
	 			p "Creating metadata folder: #{metadata_folder}"
		 		FileUtils.mkdir_p metadata_folder, mode: 0755 
	 		end

	 		unless File.directory?(thumbnails_folder) 
	 			p "Creating thumbnails folder: #{thumbnails_folder}"
		 		FileUtils.mkdir_p thumbnails_folder, mode: 0755 
	 		end

	 		p "Chdir to #{original_folder}"
	 		Dir.chdir original_folder
	 		Dir.glob("*.{jpg,NEF,nef,JPG,JPE,TIFF,tiff,TIF,tif}").each do |file|
	 			files << "#{original_folder}#{file}"
	 		end
	 	end
	end

	File.open("#{current_dir}/image_list.json", "w") do |file|
		file.write files.to_json
	end
end
