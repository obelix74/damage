current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require current_dir + '/../../config/elasticsearch'
require current_dir + '/index_helper'

include IndexHelper

file = File.read File.expand_path(File.dirname(File.dirname(__FILE__))) + '/image_list.json'
files = JSON.parse file


files.each do |file|
	metadata_file = METADATA_FOLDER + file + '.json'
	if File.exist? metadata_file
			p "Creating Index for Metadata File: #{metadata_file}"
			begin
				serialized_data = generate_index_data(THUMBNAILS_FOLDER, metadata_file)
				p 'Indexing...'
				SearchClient.index(id: serialized_data[:id], index: "damage", body: serialized_data)
			rescue => exception
				p "Error creating index for #{metadata_file}"
			end
	else
		p "ERROR: Metadata file not found for #{file}"
	end
end
