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

  def show?
    matches_user || user.admin?
  end

  def update?
    matches_user || user.admin?
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

  private

  def matches_user
    record == user
  end
end
