class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) # 安全なパラメータを使用
    if @user.save
      # 保存が成功した場合の処理
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      # 保存が失敗した場合の処理
      render 'new', status: :unprocessable_entity
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
