#------------------------------------------------------------------------------
# spec/requests/api/v1/blog_request_spec.rb
#------------------------------------------------------------------------------
require 'rails_helper'

RSpec.describe Api::V1::BlogsController, :type => :request do
  
  describe 'GET blogs#index => ' do
    let!(:barney) { create(:user_with_blog_posts) }

    ## before do 
    ##   get api_v1_blogs_path
    ## end

    context 'valid requests => ' do
      it "returns http success" do
        #barney = create(:user_with_blog_posts)
        get api_v1_blogs_path

        expect(response).to               have_http_status(:success)
        expect(response.content_type).to  eq "application/json; charset=utf-8"
      end

      it 'return all the blog posts' do
        #barney = create(:user_with_blog_posts)
        get api_v1_blogs_path
        
        ## puts "[DEBUG] Response body= #{response.body}"
        expect(JSON.parse(response.body).size).to eq(2)
      end
    end
  end # end of describe 'GET #index'

  describe 'GET blogs#show => ' do
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

  describe 'POST blogs#create => ' do
    context 'Invalid Reqest => ' do
      it 'returns an error when title is blank' do
        user       = create(:user)
        blog_attrs = attributes_for(:blog, title: '')
        
        post api_v1_blogs_path(blog_attrs)
        
        expect(response).to have_http_status(422)
        
        json_response = JSON.parse(response.body)
        expect(json_response["errors"][0]["title"]).to    match /param\sis\smissing/
      end
    end

    context 'Valid Request => ' do
      it 'returns a blog post' do
        user       = create(:user)
        blog_attrs = attributes_for(:blog)
        post api_v1_blogs_path({blog: blog_attrs})
        
        expect(response).to have_http_status(201)
        
        json_response = JSON.parse(response.body)
        expect(json_response["title"]).to              eq "#{blog_attrs[:title]}"
        expect(json_response["user"]["first_name"]).to eq user.first_name
      end
    end
  end # end of describe 'POST blogs#create'

  describe 'DELETE blogs#destroy => ' do
    context 'Invalid request => ' do
      it 'returns blog not found' do
        delete api_v1_blog_path({id: -100})

        expect(response).to have_http_status(404)

        json_response = JSON.parse(response.body)
        expect(json_response["errors"][0]["status"]).to eq   404
        expect(json_response["errors"][0]["title"]).to  match /Couldn\'t find Blog/
      end
    end

    context 'Valid request => ' do
      it 'returns a 200 status code' do
        barney = create(:user_with_blog_posts)
        delete api_v1_blog_path({id: barney.blogs[0]})
        
        expect(response).to have_http_status(200)
      end
        
      it 'deletes the blog' do
        barney = create(:user_with_blog_posts)

        expect {
          delete api_v1_blog_path({id: barney.blogs[0]})
        }.to change(Blog, :count).by(-1)
      end
    end
  end

end # end of RSpec.describe Api::V1::BlogsController
