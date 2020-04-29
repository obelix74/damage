current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require current_dir + '/../../config/elasticsearch'
require current_dir + '/index_helper'

include IndexHelper

file = File.read File.expand_path(File.dirname(File.dirname(__FILE__))) + '/image_list.json'
files = JSON.parse file

unique = {}
unique_lens = Set.new
unique_model = Set.new
unique_categories = Set.new
unique_keywords = Set.new
unique_fileType = Set.new
unique_shutterSpeed = Set.new
unique_aperture = Set.new
unique_iso = Set.new
unique_focalLength = Set.new

files.each do |file|
	metadata_file = METADATA_FOLDER + file + '.json'
	if File.exist? metadata_file
			p "Creating Index for Metadata File: #{metadata_file}"
			begin
				serialized_data = generate_index_data(THUMBNAILS_FOLDER, metadata_file)
				p 'Indexing...'
				SearchClient.index(id: serialized_data[:id], index: "damage", body: serialized_data)

				unique_lens.add(serialized_data[:lens])
				unique_model.add(serialized_data[:model])
				categories = serialized_data[:categories]
				if categories
					if categories.respond_to? :split
						categories.split(',').each do |category|
							unique_categories.add(category)
						end
					else
						categories.each do |category|
							unique_categories.add(category)
						end
					end
				end
				keywords = serialized_data[:keywords]
				if keywords
					if keywords.respond_to? :split
						keywords.split(',').each do |keyword|
							unique_keywords.add(keyword)
						end
					else
						keywords.each do |keyword|
							unique_keywords.add(keyword)
						end
					end
				end
				unique_fileType.add(serialized_data[:fileType])
				unique_shutterSpeed.add(serialized_data[:shutterSpeed])
				unique_aperture.add(serialized_data[:aperture])
				unique_iso.add(serialized_data[:iso])
				unique_focalLength.add(serialized_data[:focalLength])

			rescue => exception
				p "Error creating index for #{metadata_file}"
			end
	else
		p "ERROR: Metadata file not found for #{file}"
	end
end

unique[:lens] = unique_lens
unique[:model] = unique_model
unique[:categories] = unique_categories
unique[:keywords] = unique_keywords
unique[:fileType] = unique_fileType
unique[:shutterSpeed] = unique_shutterSpeed 
unique[:aperture] = unique_aperture
unique[:iso] = unique_iso 
unique[:focalLength] = unique_focalLength

p unique.inspect
p "Writing unique_values.json"
File.open(current_dir + "/unique_values.json","w") do |f|
  f.write(unique.to_json)
end

