class ExercisePolicy < ApplicationPolicy
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
  #       scope.match_user(daily_workout_ids)
  #     end
  #   end

  #   private

  #   def daily_workout_ids
  #     user_dw_ids = []
  #     user_programs = user.programs
  #     user_programs.each do |program|
  #       program_dw_ids = program.daily_workout_ids
  #       program_dw_ids.each do |id|
  #         user_dw_ids << id
  #       end
  #     end
  #     user_dw_ids
  #     # only works right now if a user has only one program_tracker
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
end

#   def show?
#     matches_user || user.admin?
#   end

#   def update?
#     user.admin?
#   end

#   def create?
#     user.admin?
#   end

#   def destroy?
#     user.admin?
#   end

#   private

#   def matches_user
#     record.daily_workout.program_id.in?(user.program_ids)
#   end
# end
