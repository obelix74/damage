current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../config/constants'
require current_dir + '/../config/elasticsearch'
require 'json'
require 'date'

METADATA = JSON.parse(File.read(current_dir + '/test.NEF.json'), symbolize_names: true).freeze

serialized_data = {}

serialized_data[:thumbnail] = current_dir + '/test.NEF.png'
serialized_data[:title] = METADATA[:Title]
serialized_data[:categories] = METADATA[:Categories]
serialized_data[:keywords] = METADATA[:Keywords]
serialized_data[:description] = METADATA[:Description]
serialized_data[:rating] = METADATA[:Rating]
serialized_data[:fileType] = METADATA[:FileType]
serialized_data[:model] = METADATA[:Model]
serialized_data[:shutterSpeed] = METADATA[:ShutterSpeed].to_r.to_f if(METADATA[:ShutterSpeed])
serialized_data[:aperture] = METADATA[:Aperture]
serialized_data[:iso] = METADATA[:ISO]

if (METADATA[:CreateDate])
	date = Date.strptime(METADATA[:CreateDate], "%Y-%m-%d %H:%M:%s")
	serialized_data[:createDate] = date
end
serialized_data[:focalLength] = METADATA[:FocalLength]

if (METADATA[:Lens])
	serialized_data[:lens] = METADATA[:lens]
elsif (METADATA[:LensModel])
	serialized_data[:lens] = METADATA[:LensModel]
end

p 'Indexing...'
SearchClient.index(id: METADATA[:id], index: "damage", body: serialized_data)
get_result = SearchClient.get(id: METADATA[:id], index: "damage") 
raise "Get result is wrong" if get_result.empty?

results = SearchClient.search(
	index:'damage',
	body: {
		query: {
			query_string: {
				query: "categories:CATEG*",
				analyze_wildcard: true,
				allow_leading_wildcard: false
			}
		},
		sort: { rating: "desc"}
	}
	)
p "Search results:"
p "----------------------------------------------------"
hits = results.dig("hits", "hits").map { |tag_doc| tag_doc.dig("_source") }
p hits.inspect
raise "Search result is wrong" if hits.empty?
