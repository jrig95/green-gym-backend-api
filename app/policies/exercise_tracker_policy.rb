class ExerciseTrackerPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end
  # end

    def resolve
      if user.admin?
        scope.all
      else
        scope.match_user(dwt_ids)
      end
    end

    private

    def dwt_ids
      user_dwt_ids = []
      user_program_trackers = user.program_trackers
      user_program_trackers.each do |program_tracker|
        dwt_ids = program_tracker.daily_workout_tracker_ids
        dwt_ids.each do |id|
          user_dwt_ids << id
        end
      end
      user_dwt_ids
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

  private

  def matches_user
    record.daily_workout_tracker.program_tracker_id.in?(user.program_tracker_ids)
  end
end
