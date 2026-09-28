require "rails_helper"

RSpec.describe "Web manifest", type: :request do
  it "is valid JSON" do
    get pwa_manifest_path(format: :json)
    expect(response.parsed_body).to include("name", "icons")
  end
end
