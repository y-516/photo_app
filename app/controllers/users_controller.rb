class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def favorite
    @user = User.find(params[:id])
    @favorite_pictures = @user.favorite_pictures
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image,:password,
                                 :password_confirmation)
  end
end