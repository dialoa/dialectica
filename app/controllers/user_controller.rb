class UserController < ApplicationController
  before_action :set_user, only: [:show_user, :edit_user, :update_user, :destroy]

  def user_overview

  end

  def show_user
    if params[:id].present?
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end

  def edit_user
    authorize @user
    #@user = User.find(params[:id])
  end

  def update_user
  authorize @user
  @user.update(user_params)

  flash[:notice] = "edit was successful"
  #byebug
  #redirect_back(fallback_location: root_path)
  redirect_to dashboard_path
end

  private

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :email, :hidden)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
