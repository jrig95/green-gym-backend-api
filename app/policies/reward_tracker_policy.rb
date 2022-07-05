class RewardTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      end
    end
  end

  def show?
    matches_user || user.admin?
  end

  def create?
    matches_user || user.admin?
  end

  private

  def matches_user
    record.user == user
  end
end
