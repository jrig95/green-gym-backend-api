class ProgramTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user_id: user.id)
      end
    end
  end



  def show?
    matches_user || user.admin?
  end

  def update?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    user.admin?
  end

  def current_dwt?
    matches_user || user.admin?
  end

  def five_day_array?
    matches_user || user.admin?
  end

  private

  def matches_user
    record.user == user
  end

end
