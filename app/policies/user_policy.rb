class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # uncomment below when we want to limit scope to only admin
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def sort_by_first_name?
    user.admin?
  end

  def sort_by_last_name?
    user.admin?
  end

  def sort_by_user_company?
    user.admin?
  end

  def sort_by_last_sign_in_at?
    user.admin?
  end

  def show?
    matches_user || user.admin?
  end

  def update?
    matches_user || user.admin?
  end

  def destroy?
    user.admin?
  end

  def update_password?
    matches_user || user.admin?
  end

  def forgot_password?
    true
  end

  def reset_password?
    true
  end

  def send_code?
    matches_user
  end

  def verify_code?
    matches_user
  end

  def overall_impact?
    matches_user
  end

  def add_active_time?
    matches_user || user.admin?
  end

  private

  def matches_user
    record == user
  end
end
