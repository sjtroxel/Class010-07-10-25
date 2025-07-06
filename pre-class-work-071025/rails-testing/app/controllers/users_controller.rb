class UsersController < ApplicationController

before_action :set_user, only: [:show, :update, :destroy]

def create
  user = User.new(user_params)
  if user.save
    render json: user, status: :created
  else
    render json: user.errors, status: :unprocessable_entity
  end
end

def index 
  render json: User.all
end

def show 
  render json: @user, status: :ok 
end

def update 
  if @user.update(user_params)
    render json: @user, status: :ok 
  else 
    render json: @user.errors, status: :unprocessable_entity
  end
end

def destroy
  if @user.destroy
    # return a response with only headers and no body
    head :no_content
  else 
    render json: @user.errors, status: :unprocessable_entity
  end
end

private

def user_params
  params.require(:user).permit(:email, :name)
end

def set_user
  @user = User.find(params[:id])
end
end