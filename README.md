# ⚠️ ARCHIVED - This repository is no longer maintained

**This repository has been archived and is no longer actively maintained.**

This project was last updated on 2015-10-28 and is preserved for historical reference only.

- 🔒 **Read-only**: No new issues, pull requests, or changes will be accepted
- 📦 **No support**: This code is provided as-is with no support or updates
- 🔍 **For reference only**: You may fork this repository if you wish to continue development

For current CARTO projects and actively maintained repositories, please visit: https://github.com/CartoDB

---

# CartoDB Utils

Ruby client to work with some CartoDB utils

## Installation

```Bash
gem install cartodb-utils
```

## examples

```ruby
require 'cartodb-utils'

sa = CartoDBUtils::Metrics::SQLAPI.new(:cartodb_domain => 'example.cartodb.com', :api_key => '') 
result = sa.request("SELECT 5")
puts result

es = CartoDBUtils::Metrics::Elasticsearch.new(:elasticsearch_ip => '127.0.0.1')
result = es.request({'version' => true})
puts result

```
