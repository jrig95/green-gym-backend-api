class LibraryItemPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
  #   def resolve
  #     scope.all
  #   end
  # end


    def resolve
      scope.all if user.admin?
    end
  end

  # def show?
  #   true
  # end

  # def update?
  #   true
  # end

  # def create?
  #   true
  # end

  # def destroy?
  #   true
  # end

  def show?
    user.admin?
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

  def tagged?
    user.admin?
  end
end
