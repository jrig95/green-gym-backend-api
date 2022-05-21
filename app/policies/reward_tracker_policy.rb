class RewardTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    true
  end

  def create?
    true
  end

  # def show?
  #   user.admin? || matches_user
  # end

  # def create?
  #   user.admin? || matches_user
  # end

  # private

  # def matches_user
  #   record.user == user
  # end
end
