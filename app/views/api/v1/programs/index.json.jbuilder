json.array! @programs do |program|
  json.extract! program, :id, :program_title, :program_description, :price

  if program.photo.attached?
    # json.photo_url url_for(@program.photo)
    json.photo_url program.photo.service_url
    # json.photo_url @program.photo.public_url
  end
end
