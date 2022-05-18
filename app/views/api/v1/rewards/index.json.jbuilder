json.array! @rewards do |reward|
  json.extract! reward, :id, :reward_name, :reward_points, :program_id, :visible

end
