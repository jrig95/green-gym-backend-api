class ExercisePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      else
        scope.match_user(daily_workout_ids)
      end
    end

    private

    def daily_workout_ids
      user_dw_ids = []
      user_programs = user.programs
      user_programs.each do |program|
        user_dw_ids << program.daily_workout_ids
      end
      user_dw_ids
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

  private

  def matches_user
    record.daily_workout.program_id.in?(user.program_ids)
  end
end
