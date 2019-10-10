#------------------------------------------------------------------------------
# app/controllers/api/v1/blogs_controller.rb
#------------------------------------------------------------------------------
class Api::V1::BlogsController < ApplicationController

  def index
    logger.debug "[DEBUG] Entered blogs#index"
    @blogs = Blog.all
    render json: @blogs
  end
  
  def show
    @blog = Blog.find(params[:id])
    render json: @blog
  end

  def create
  end

  def destroy
  end

end
