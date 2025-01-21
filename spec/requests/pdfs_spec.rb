require 'rails_helper'

RSpec.describe "Pdfs", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/pdfs/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/pdfs/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /download" do
    it "returns http success" do
      get "/pdfs/download"
      expect(response).to have_http_status(:success)
    end
  end

end
