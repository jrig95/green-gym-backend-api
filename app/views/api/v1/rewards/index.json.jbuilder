json.array! @rewards do |reward|
  json.extract! reward, :id,:reward_name, :reward_image, :reward_points

end
