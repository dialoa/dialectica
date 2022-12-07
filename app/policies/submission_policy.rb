class SubmissionPolicy < ApplicationPolicy

  def index?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def submission_list?
    is_user_editor?(@user) || is_user_reviewer?(@user) || is_user_admin?(@user)
  end

  def download_csv?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def upload_csv?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def create_or_update_submission?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def pool?
    is_user_editor?(@user) || is_user_reviewer?(@user) || is_user_admin?(@user)
  end

  def show_pool?
    is_user_editor?(@user) || is_user_reviewer?(@user) || is_user_admin?(@user)
  end

  def show?
    is_user_editor?(@user) || is_user_reviewer?(@user) || is_user_admin?(@user)
  end

  def edit?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def update?
    is_user_editor?(@user) || is_user_admin?(@user)
  end

  def destroy?
    is_user_editor?(@user) || is_user_admin?(@user)
  end



  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
