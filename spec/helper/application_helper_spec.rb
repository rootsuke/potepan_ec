require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#full_title" do
    it "returns base_title" do
      expect(full_title).to eq("BIGBAG Store")
    end

    it "returns page_title and base_title" do
      expect(full_title("Page_title")).to eq("Page_title | BIGBAG Store")
    end
  end
end
