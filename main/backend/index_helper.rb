require 'json'
require 'date'

module IndexHelper

	# Given a metadata JSON file, return a Hash that can be used to generate an Elasticsearch index
	def generate_index_data(thumbnails_folder, file)
		metadata = JSON.parse(File.read(file), symbolize_names: true).freeze
		index_data = {}
		index_data[:id] = metadata[:id]

		index_data[:thumbnail] = thumbnails_folder + index_data[:id] + '.png'
		index_data[:title] = metadata[:Title]
		index_data[:categories] = metadata[:Categories]
		index_data[:keywords] = metadata[:Keywords]
		index_data[:description] = metadata[:Description]
		index_data[:rating] = metadata[:Rating]
		index_data[:fileType] = metadata[:FileType]
		index_data[:model] = metadata[:Model]
		index_data[:shutterSpeed] = metadata[:ShutterSpeed].to_r.to_f if(metadata[:ShutterSpeed])
		index_data[:aperture] = metadata[:Aperture]
		index_data[:iso] = metadata[:ISO]

		if (metadata[:CreateDate])
			date = Date.strptime(metadata[:CreateDate], "%Y-%m-%d %H:%M:%s")
			index_data[:createDate] = date
		end
		index_data[:focalLength] = metadata[:FocalLength]

		if (metadata[:LensID])
			index_data[:lens] = metadata[:LensID]
		elsif (metadata[:Lens])
			index_data[:lens] = metadata[:Lens]
		elsif (metadata[:LensModel])
			index_data[:lens] = metadata[:LensModel]
		end

		index_data
	end
end