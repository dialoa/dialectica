class UserController < ApplicationController
  before_action :set_user, only: [:show_user, :edit_user, :update_user, :destroy, :add_role_to_user, :remove_role_from_user, :show_user]

  def user_overview

  end

  def dashboard

  end

  def add_role_to_user
    authorize @user
    unless @user.roles.where(name: params[:role][:role_name]).exists?
      @user.roles << Role.find_by_name(params[:role][:role_name])
    end

    flash[:notice] = "edit was successful"
    redirect_to show_user_user_path(@user)
  end

  def remove_role_from_user
    authorize @user
    @user.roles.delete(Role.find_by_name(params[:role_name]))
    #@customer.orders.delete(@order1)
    flash[:notice] = "edit was successful"
    redirect_to show_user_user_path(@user)
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

  #byebug
  #redirect_back(fallback_location: root_path)
  #redirect_to dashboard_path

  flash[:notice] = "edit was successful"
  redirect_to show_user_user_path(@user)
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
