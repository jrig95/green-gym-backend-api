json.array! @program_trackers do |program_tracker|
  json.extract! program_tracker, :id, :program_id, :user_id
end
