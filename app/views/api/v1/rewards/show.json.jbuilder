json.extract! @reward, :id, :reward_name, :reward_image, :reward_points
json.programs @reward.programs do |program|
  json.extract! program, :program_title, :program_description
end
