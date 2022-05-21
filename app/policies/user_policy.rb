class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # uncomment below when we want to limit scope to only admin
    # def resolve
    #   if user.admin?
    #     scope.all
    #   end
    # end

    # comment below when we want to limit scope to only admin
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def update?
    true
  end

  # def show?
    # matches_user || user.admin?
  # end

  # def update?
  #   matches_user || user.admin?
  # end

  #   private

  # def matches_user
  #   record.daily_workout.program_id.in?(user.program_ids)
  # end
end
