json.array! @program_rewards do |program_reward|
  json.extract! program_reward, :id
  json.extract! program_reward.program, :program_title
  json.extract! program_reward.reward, :reward_name
  # json.program @program_reward.program
  # json.extract! program, :program_title
end
