# Relaxed CookieJar

[![Gem Version](https://badge.fury.io/rb/relaxed_cookiejar.svg)](https://badge.fury.io/rb/relaxed_cookiejar)
[![Build Status](https://travis-ci.org/andreimaxim/relaxed_cookiejar.svg?branch=master)](https://travis-ci.org/andreimaxim/relaxed_cookiejar)
[![Maintainability](https://api.codeclimate.com/v1/badges/01636d74408d3f1fdd7d/maintainability)](https://codeclimate.com/github/andreimaxim/relaxed_cookiejar/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/01636d74408d3f1fdd7d/test_coverage)](https://codeclimate.com/github/andreimaxim/relaxed_cookiejar/test_coverage)

A gem that includes a monkeypatch for the original CookieJar gem.

This gem exists simply because the original CookieJar gem seems to be abandoned yet it
is still used by a lot of other gems (like Faye). The main change this gem does is to
relax the policies for matched domains.

For example, if you are trying to connect to a Salesforce PushTopic, the code will 
try to match the requested domain (something like `company--ver.inst.my.salesforce.com`) with 
the cookie domain (`.salesforce.com`) and it will obviously fail. CookieJar does try to go
one level deep (so it will also add `.inst.my.salesforce.com` to the list of valid domains) but
obviously this will not work.

This gem basically overrides the `CookieJar::CookieValidation.compute_search_domains_for_host`
method so it will go slightly deeper and also add `.my.salesforce.com` and `.salesforce.com` to
the list of expected domains.

## Usage

Simply require this gem:

```ruby
require 'faye'
require 'relaxed_cookiejar'
```

This should be it.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/andreimaxim/relaxed_cookiejar.]()

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
