class PagePolicy < ApplicationPolicy

  def new?
    is_user_admin?(@user)
  end

  def update?
    is_user_admin?(@user)
  end

  def edit?
    is_user_admin?(@user)
  end

  def destroy?
    is_user_admin?(@user)
  end


end
