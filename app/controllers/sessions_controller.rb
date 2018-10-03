class SessionsController < ApplicationController
  def new
  end

  def create
    #入力された情報を元にdbからデータを変数に代入、データなければfalse代入
    user = User.find_by(email:params[:session][:email].downcase)
    #.authenticate 引数の文字列がパスワードと一致するとUserオブジェクトを、
    #間違っているとfalseを返すメソッド
    if user && user.authenticate(params[:session][:password])
       session[:user_id] = user.id
       redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
