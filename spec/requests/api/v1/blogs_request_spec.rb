#------------------------------------------------------------------------------
# spec/requests/api/v1/blog_request_spec.rb
#------------------------------------------------------------------------------
require 'rails_helper'

RSpec.describe Api::V1::BlogsController, :type => :request do
  
  describe 'GET #index => ' do
    ## let(:barney) { create(:user_with_blog_posts) }

    ## before do 
    ##   get api_v1_blogs_path
    ## end

    context 'valid requests => ' do
      it "returns http success" do
        barney = create(:user_with_blog_posts)
        get api_v1_blogs_path

        expect(response).to               have_http_status(:success)
        expect(response.content_type).to  eq "application/json; charset=utf-8"
      end

      it 'return all the blog posts' do
        barney = create(:user_with_blog_posts)
        get api_v1_blogs_path
        
        ## puts "[DEBUG] Response body= #{response.body}"
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end
  end # end of describe 'GET #index'

  describe 'GET #show => ' do
    context 'Valid requests => ' do
      it 'returns http success' do
        barney = create(:user_with_blog_posts)
        get api_v1_blog_path({id: barney.blogs[0]})

        expect(response).to               have_http_status(:success)
        expect(response.content_type).to  eq "application/json; charset=utf-8"
      end

      it 'returns a blog post' do 
        barney = create(:user_with_blog_posts)
        get api_v1_blog_path({id: barney.blogs[0]})

        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to          eq 1
        expect(json_response["title"]).to       match /Blog/
      end
    end

    context 'Invalid request => ' do
      it 'returns not found' do
        barney = create(:user_with_blog_posts)
        get api_v1_blog_path({id: -100})

        expect(response).to               have_http_status(404)
        expect(response.content_type).to  eq "application/json; charset=utf-8"
      end

      it 'returns an error message' do
        barney = create(:user_with_blog_posts)
        get api_v1_blog_path({id: 100})

        json_response = JSON.parse(response.body)
        expect(json_response["errors"][0]["status"]).to    eq 404
      end
    end
  end # end of describe 'GET #show'


end # end of RSpec.describe Api::V1::BlogsController
