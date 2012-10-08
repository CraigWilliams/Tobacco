require 'spec_helper'
require_relative '../../lib/tobacco/test_helpers'

describe Tobacco::TestHelpers do
  include Tobacco::TestHelpers

  let(:content) { 'blah' }
  let(:consumer) { mock('consumer', content_url: '/what') }

  it 'returns supplied content' do
    mock_page_content(content)

    smoker = Tobacco::Smoker.new(consumer)
    smoker.read

    smoker.content.should == content
  end

end
