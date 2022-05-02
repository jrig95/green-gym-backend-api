json.extract! @program_reward, :id
json.extract! @program_reward, :program_id
json.extract! @program_reward.program, :program_title, :program_description, :number_of_days
json.extract! @program_reward, :reward_id
json.extract! @program_reward.reward, :reward_name, :reward_image, :reward_points
