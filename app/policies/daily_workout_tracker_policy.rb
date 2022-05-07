class DailyWorkoutTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(program_tracker_id: user.program_tracker_ids)
      end
    end
  end

  def show?
    record.user == user || user.admin?
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
end
