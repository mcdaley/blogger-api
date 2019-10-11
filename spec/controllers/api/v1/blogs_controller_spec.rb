#------------------------------------------------------------------------------
# spec/api/v1/blogs_controller_spec.rb
#------------------------------------------------------------------------------
require 'rails_helper'

RSpec.describe Api::V1::BlogsController, :type => :controller do

  describe "GET #index => " do
    let(:barney) { create(:user_with_blog_posts) }

    context 'Retrieves all blog posts => ' do
      before do
        @request.headers["Content-Type"] = "application/json"
        get :index, :format => :json
      end

      it "returns http success" do
        expect(response).to               have_http_status(:success)
        expect(response.content_type).to  eq "application/json; charset=utf-8"
      end
    end
  end

=begin
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end
=end

=begin
  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
=end

end
