class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: post.errors, status: :unprocessable_entity
    end
  end

  def index 
    render json: Post.all
  end

  def show 
    render json: @post, status: :ok 
  end

  def update 
    if @post.update(post_params)
      render json: @post, status: :ok 
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      # return a response with only headers and no body
      head :no_content
    else 
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
