class ProgramPolicy < ApplicationPolicy
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

  def last_program?
    true
  end

  # def show?
  #   true
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
