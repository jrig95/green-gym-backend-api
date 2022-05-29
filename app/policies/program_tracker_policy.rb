class ProgramTrackerPolicy < ApplicationPolicy
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
  #       scope.where(user_id: user.id)
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

  def current_dwt?
    true
  end

  def five_day_array?
    true
  end

  # def show?
  #   record.user == user || user.admin?
  # end

  # def update?
  #   user.admin?
  # end

  # def create?
  #   user.admin?
  # end

  # def destroy?
  #   user.admin?
  # end
end
