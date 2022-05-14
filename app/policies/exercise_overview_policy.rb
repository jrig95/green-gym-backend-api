class ExerciseOverviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
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

  def create?
    true
  end

  def destroy?
    true
  end
end

#   def show?
#     true
#   end

#   def update?
#       # Only admin can update program
#     user.admin?
#   end

#   def create?
#     user.admin?
#   end

#   def destroy?
#     user.admin?
#   end

#   private

#   def user_is_admin?
#     user.admin
#   end
# end
