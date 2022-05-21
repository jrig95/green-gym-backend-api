json.(@reward_tracker, :id, :user_id, :reward_id)
json.user @reward_tracker.user, :email, :user_company, :first_name, :last_name
json.reward @reward_tracker.reward, :reward_name
