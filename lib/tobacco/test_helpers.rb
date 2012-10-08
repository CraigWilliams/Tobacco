module Tobacco
  module TestHelpers

    def mock_page_content(content)
      Tobacco::Inhaler.any_instance.stub(:read).and_return(content)
    end

  end
end
