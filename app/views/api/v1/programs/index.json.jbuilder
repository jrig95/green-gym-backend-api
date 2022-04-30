json.array! @programs do |program|
  json.extract! program, :id, :program_title, :program_description
end
