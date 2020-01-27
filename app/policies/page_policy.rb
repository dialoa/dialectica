class PagePolicy < ApplicationPolicy

  def update?
    is_user_admin?(@user)
  end
end
