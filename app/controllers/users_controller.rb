class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcom to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
        # parameterとして許可する属性定義
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end