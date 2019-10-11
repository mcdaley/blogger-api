#------------------------------------------------------------------------------
# app/controllers/api/v1/blogs_controller.rb
#------------------------------------------------------------------------------
class Api::V1::BlogsController < ApplicationController

  def index
    logger.debug "[DEBUG] Entered blogs#index"
    @blogs = Blog.all
    render json: @blogs, status: 200
  end
  
  def show
    begin
      @blog = Blog.find(params[:id])
      render  json: @blog
    rescue ActiveRecord::RecordNotFound => err
      error = {
        title:  err.message,
        status: 404,
      }
      render json: { errors: [error] }, status: 404
      return
    rescue ActionController::ParameterMissing => err
      error = {
        title:  err.message,
        status: 422
      }
    end
  end

  ##
  # Create a blog post, need to:
  # [x] - Params title, summary, posted date
  #       * Strong parameters
  # [x] - Figure out how to handle the user:
  #       * Watch gorails API authorization videos
  #       * Authorize and get current user
  #       * Pass in the user id
  # [x] - Create the blog post
  #       * What do I return? assume that I use the BlogSerializer
  # [x] - Handle errors
  #       * Build ErrorSerializer that adds the errors after I fail to
  #         save the blog
  # [x] - Build the create request in Postman
  # - Write rspec test cases
  #
  def create
    logger.debug  "[DEBUG] Entered Blogs#create w/ params= #{params.inspect}"
    @current_user = User.find(1)
    @blog         = @current_user.blogs.new(blog_params)

    if @blog.save
      logger.info "[INFO] Saved blog: #{@blog.inspect}"
      render json: @blog, status: 201
    else
      logger.error "[ERROR] Failed to save the blog: #{@blog.errors.inspect}"
      render json: @blog, adapter: :json_api, serializer: ErrorSerializer, status: 422
      ##render json: @blog, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  def destroy
  end

  #----------------------------------------------------------------------------
  # private
  #----------------------------------------------------------------------------
  private

    def blog_params
      params.require(:blog).permit(:title, :summary, :posted)
    end

end
