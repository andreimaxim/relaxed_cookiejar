require 'spec_helper'

RSpec.describe RelaxedCookieJar::CookieValidation do

  describe '#match_domains' do

    it 'should handle exact matches' do
      expect(CookieJar::CookieValidation.domains_match('localhost.local', 'localhost.local')).to eq 'localhost.local'
      expect(CookieJar::CookieValidation.domains_match('foo.com', 'foo.com')).to eq 'foo.com'
      expect(CookieJar::CookieValidation.domains_match('127.0.0.1', '127.0.0.1')).to eq '127.0.0.1'
      expect(CookieJar::CookieValidation.domains_match('::ffff:192.0.2.128', '::ffff:192.0.2.128')).to eq '::ffff:192.0.2.128'
    end

    it 'should handle matching a superdomain' do
      expect(CookieJar::CookieValidation.domains_match('.foo.com', 'auth.foo.com')).to eq '.foo.com'
      expect(CookieJar::CookieValidation.domains_match('.y.z.foo.com', 'x.y.z.foo.com')).to eq '.y.z.foo.com'
    end

    it 'should not match or illegal domains' do
      expect(CookieJar::CookieValidation.domains_match('foo.com', 'com')).to be_nil
    end

    it 'should match superdomains' do
      expect(CookieJar::CookieValidation.domains_match('.z.foo.com', 'x.y.z.foo.com')).to eq '.z.foo.com'
    end

    it 'should not match domains with and without a dot suffix together' do
      expect(CookieJar::CookieValidation.domains_match('foo.com.', 'foo.com')).to be_nil
    end
  end
end