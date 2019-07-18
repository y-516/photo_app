class SessionsController < ApplicationController
  before_action :detect_devise_variant
  def new
  end

  def create
    user = User.find_by(email:params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
       session[:user_id] = user.id
       redirect_to pictures_path
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
  private
  def detect_devise_variant  # (1)と同じ名前
      case request.user_agent
      when /iPad/
          request.variant = :tablet
      when /iPhone/
          request.variant = :mobile
      end
  end
end
