current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../config/constants'
require current_dir + '/../config/elasticsearch'
require current_dir + '/../main/backend/index_helper'

include IndexHelper

serialized_data = generate_index_data(THUMBNAILS_FOLDER, '/Volumes/Data/Data/damage/metadata/Volumes/Pictures/2006/02/17/DSC_2155.NEF.json')
p 'Indexing...'
SearchClient.index(id: serialized_data[:id], index: "damage", body: serialized_data)
get_result = SearchClient.get(id: serialized_data[:id], index: "damage") 
raise "Get result is wrong" if get_result.empty?

results = SearchClient.search(
	index:'damage',
	body: {
		query: {
			query_string: {
				query: "lens:18-70*",
				analyze_wildcard: true
			}
		},
		sort: { rating: "desc"}
	}
	)

p "Search results for lens:"
p "----------------------------------------------------"
hits = results.dig("hits", "hits").map { |tag_doc| tag_doc.dig("_source") }
p hits.inspect
raise "Search result is wrong" if hits.empty?
