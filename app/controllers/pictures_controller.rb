class PicturesController < ApplicationController
  before_action :set_picture,only:[:edit,:update,:destroy]
  before_action :logged_in,only:[:new,:edit,:show,:destroy]

  def index
    @picture = Picture.all.order(created_at: :desc)
    @current_user = current_user
  end

  def new
    if params[:back]
    @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      ContactMailer.contact_mail(@picture).deliver
      redirect_to pictures_path,notice:"投稿しました"
    else
      render 'new'
    end
  end

  def edit
  end


  def look
    @comments = @picture.comments
    @comment = @picture.comments.build
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path,notice:"編集しました"
    else
      recder 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path,notice:"削除しました"
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
  end

  def show
    @picture = Picture.find_by(id:params[:id])
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  private

  def picture_params
    params.require(:picture).permit(:content,:image,:image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def logged_in
    if logged_in? != true
      redirect_to new_session_path
    end
  end

end
