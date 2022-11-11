class UserPolicy < ApplicationPolicy

  def edit_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def update_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

end
