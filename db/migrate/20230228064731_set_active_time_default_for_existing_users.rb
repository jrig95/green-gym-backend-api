class SetActiveTimeDefaultForExistingUsers < ActiveRecord::Migration[6.1]
  def up
    User.update_all(active_time: 0)
  end

  def down
    # no need to undo this operation
  end
end
