Searchkick.client =
  Elasticsearch::Client.new(
    url: ENV.fetch("ELASTICSEARCH_URL", "http://localhost:9200"),
    retry_on_failure: 3,
    transport_options: { request: { timeout: 20 } }
  )
