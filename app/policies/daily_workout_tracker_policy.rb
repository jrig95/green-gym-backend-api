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
    matches_user || user.admin?
  end

  def update?
    matches_user || user.admin?
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
    record.program_tracker.user == user
  end
end
