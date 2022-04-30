json.array! @programs do |program|
  json.extract! program, :id, :program_title, :program_description, :program_cover_image, :price
end
