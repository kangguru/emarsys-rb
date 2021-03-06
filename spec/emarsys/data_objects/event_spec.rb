require 'spec_helper'

describe Emarsys::Event do
  describe ".collection" do
    it "requests all events" do
      expect(
        stub_get("event") { Emarsys::Event.collection }
      ).to have_been_requested.once
    end
  end

  describe ".trigger" do
    it "requests event trigger with parameters" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "jane.doe@example.com"}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger(123, key_id: 3, external_id: 'jane.doe@example.com')
      expect(stub).to have_been_requested.once
    end

    it "requests event trigger with additional data parameters" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "jane.doe@example.com", :data => {'global' => {'my_placeholder' => 'Something'}}}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger(123, key_id: 3, external_id: 'jane.doe@example.com', data: {'global' => {'my_placeholder' => 'Something'}})
      expect(stub).to have_been_requested.once
    end
  end

  describe ".trigger_multiple" do
    it "requests event trigger with parameters" do
      stub = stub_request(:post, "https://api.emarsys.net/api/v2/event/123/trigger").with(:body => {'key_id' => 3, 'external_id' => "", :data => nil, :contacts => [{'external_id' => "jane.doe@example.com"}]}.to_json).to_return(standard_return_body)
      Emarsys::Event.trigger_multiple(123, key_id: 3, contacts: [{'external_id' => 'jane.doe@example.com'}])
      expect(stub).to have_been_requested.once
    end
  end
end
