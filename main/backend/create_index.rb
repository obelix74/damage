# This file should be executed just once to create the index

current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require current_dir + '/../../config/elasticsearch'

index_settings = { number_of_shards: 1, number_of_replicas: 0}
settings = { settings: { index: index_settings } }
SearchClient.indices.create(index: 'damage', body: settings)