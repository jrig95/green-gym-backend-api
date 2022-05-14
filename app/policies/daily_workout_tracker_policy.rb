class DailyWorkoutTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    def resolve
      scope.all
    end
  end

  #   def resolve
  #     if user.admin?
  #       scope.all
  #     else
  #       scope.where(program_tracker_id: user.program_tracker_ids)
  #     end
  #   end
  # end

  def show?
    true
  end

  def update?
    true
  end

  def create?
    true
  end

  def destroy?
    true
  end

  # def show?
  #   record.program_tracker.user == user || user.admin?
  # end

  # def update?
  #   record.program_tracker.user == user || user.admin?
  # end

  # def create?
  #   record.program_tracker.user == user || user.admin?
  # end

  # def destroy?
  #   user.admin?
  # end
end
