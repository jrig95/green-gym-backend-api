json.array! @programs do |program|
  json.extract! program, :id, :program_title, :program_description, :number_of_days, :price, :program_library_item_id, :calories_burned, :trees_planted, :calorie_credits

  if program.photo.attached?
    json.photo_url program.photo.service_url
  end
end
