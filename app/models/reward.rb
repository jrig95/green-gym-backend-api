class Reward < ApplicationRecord
  # belongs_to :program, depend: :destroy
  # belongs_to :program

  # scope :visible_or_no_program, -> { where(visible: true).or(where(program_id: nil)) }
  # scope :matches_reward_with_user, ->(id) { where(program_id: id) }
  # scope :visible_or_no_program, -> (id) { where(visible: true).or(where(program_id: nil).or(where(program_id))) }

  scope :non_admin_scope, ->(id) { where(program_id: id).or(where(program_id: nil).or(where(visible: true))) }

end
