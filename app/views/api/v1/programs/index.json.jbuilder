json.array! @programs do |program|
  json.extract! program, :id, :program_title, :program_description, :price, :start_date, :program_library_item_id

  if program.photo.attached?
    json.photo_url program.photo.service_url
  end
end
