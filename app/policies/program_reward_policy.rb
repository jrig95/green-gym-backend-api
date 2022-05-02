class ProgramRewardPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    user_is_admin?
  end

  def create?
    user_is_admin?
  end

  def destroy?
    user_is_admin?
  end

  def user_is_admin?
    user.admin
  end
end
