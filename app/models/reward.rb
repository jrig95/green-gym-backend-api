class Reward < ApplicationRecord
  scope :non_admin_scope, ->(id) { where(program_id: id).or(where(program_id: nil).or(where(visible: true))) }
end
