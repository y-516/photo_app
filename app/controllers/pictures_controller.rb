class PicturesController < ApplicationController
  before_action :set_picture,only:[:edit,:update,:destroy]

  def index
    @picture = Picture.all.order(created_at: :desc)
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
    @picture.save
    redirect_to pictures_path,notice:"投稿しました"
  end

  def edit
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
  end

  private

  def picture_params
    params.require(:picture).permit(:content,:image,:image_cache)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end
end
