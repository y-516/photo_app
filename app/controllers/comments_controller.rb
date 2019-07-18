class CommentsController < ApplicationController
  #コメントを保存、投稿するためのアクション
  def create
    #Pictureをパラメータの値から探し出して,
    #Pictureに紐づくcommentsとしてbuildする。
    @picture= Picture.find(params[:picture_id])
    @comment = @picture.comments.build(comment_params)
    #クライアントの要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.js {render :index}
      else
        format.html {redirect_to picture_path(@picture),notice:'投稿できませんでした'}
      end
    end

  end
end

private

def comment_params
  params.require(:comment).permit(:picture_id,:content)
end
