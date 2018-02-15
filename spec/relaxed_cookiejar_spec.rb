require 'spec_helper'

RSpec.describe RelaxedCookieJar do

  it 'has a valid version' do
    expect(::RelaxedCookieJar::VERSION).not_to be_nil
  end
end
