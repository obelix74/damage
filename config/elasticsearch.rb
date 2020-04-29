require 'elasticsearch'

SearchClient = Elasticsearch::Client.new(
		url: "http://localhost:9200",
		retry_on_failure: 5,
		request_timeout: 30,
		adapter: :typhoeus
	)