class UserPolicy < ApplicationPolicy

  def dashboard?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def show_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def edit_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def update_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def remove_role_from_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def add_role_to_user?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

end
