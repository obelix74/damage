current_dir = File.expand_path(File.dirname(File.dirname(__FILE__)))
require current_dir + '/../../config/constants'
require current_dir + '/../../config/elasticsearch'
require 'json'

MAPPINGS = JSON.parse(File.read(current_dir + '/../../config/mapping.json'), symbolize_names: true).freeze
SearchClient.indices.put_mapping(index: "damage", body: MAPPINGS)
