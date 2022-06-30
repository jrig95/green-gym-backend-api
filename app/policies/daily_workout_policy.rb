class DailyWorkoutPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    # def resolve
    #   scope.all
    # end

    def resolve
      if user.admin?
        scope.all
      else
        scope.match_user(user_ids)
      end
    end

    private

    def user_ids
      user.program_ids
    end
  end

  def show?
    true
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

  def last_workout?
    true
  end

  private

  def matches_user
    record.program_id.in?(user.program_ids)
  end
end
