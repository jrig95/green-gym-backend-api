class RewardPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!

    # Index Conditions
    # 1. an admin can see all the rewards
    # 2. a user can see all rewards.program_id.nil? and rewards.visible: true
    # 3. a user can see a reward if the reward.program_id is in their user.program_ids

    def resolve
      if user.admin?
        scope.all
      elsif user.admin == false
        scope.non_admin_scope(user_ids)
      end
    end

    private

    def user_ids
      user.program_ids
    end
  end

  # 1. if a reward does not have a program id then anyone can see it.
  # 2. if a reward has a program id, but is visible then anyone can see it.
  # 3. if a reward has a program id, but is not visible, then only a user whose program_id matches the reward_id can view the reward (note: a user can have more than one program)

  def show?
    if record.program_id.nil?
      true
    else
      record.visible || user.admin? || matching_program_ids
    end
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

  def matching_program_ids
    record.program_id.in? user.program_ids
  end
end
