#------------------------------------------------------------------------------
# app/controllers/api/v1/blogs_controller.rb
#------------------------------------------------------------------------------
class Api::V1::BlogsController < ApplicationController

  ##
  # Retrieve all the blog posts
  #
  def index
    logger.debug "[DEBUG] Entered blogs#index"
    @blogs = Blog.all
    render json: @blogs, status: 200
  end
  
  ##
  # Retrieve a single blog post
  #
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
    end
  end

  ##
  # Create a new blog post
  #
  def create
    logger.debug  "[DEBUG] Entered Blogs#create w/ params= #{params.inspect}"

    begin
      @current_user = current_user
      @blog         = @current_user.blogs.new(blog_params)

      if @blog.save
        logger.info "[INFO] Saved blog: #{@blog.inspect}"
        render json: @blog, status: 201
      else
        logger.error "[ERROR] Failed to save the blog: #{@blog.errors.inspect}"
        render json: @blog, adapter: :json_api, serializer: ErrorSerializer, status: 422
      end
    rescue ActionController::ParameterMissing => err
      error = {
        title:  err.message,
        status: 422
      }
      render json: { errors: [error] }, status: 422
    end
  end

  ##
  # Delete a blog post. 
  #
  # NOTE:
  # Using destroy vs. delete to remove the blog. Destroy returns the blog
  # that is deleted and will run all of the callbacks associated w/ the
  # Blog model, so it is a little slower than "delete".
  #
  def destroy
    logger.debug  "[DEBUG] Entered Blogs#destroy w/ params= #{params.inspect}"

    begin
      @blog = Blog.destroy(params[:id])
      
      logger.info "[INFO] Deleted blog: #{@blog.inspect}"
      render json: @blog, status: 200
    rescue ActiveRecord::RecordNotFound => err
      error = {
        title:  err.message,
        status: 404,
      }
      render json: { errors: [error] }, status: 404
      return
    end
  end

  #----------------------------------------------------------------------------
  # private
  #----------------------------------------------------------------------------
  private

    def blog_params
      params.require(:blog).permit(:title, :summary, :posted)
    end

    def destroy_blog_params
      params.require(:blog).permit(:id)
    end

    ##
    # Hack to select the current user by grabbing the first one in the DB. I
    # need to do this as I have not implemented user sign-up yet.
    #
    def current_user
      User.limit(1).order(:id, :asc)[0]
    end

end
