json.array! @users do |user|
  json.extract! user, :id, :email, :created_at, :updated_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :admin, :first_name, :last_name, :user_company, :user_total_calories, :user_points, :user_gender, :user_fitness_level

  if user.photo.attached?
    json.photo_url user.photo.service_url
  end

  json.program_trackers user.program_trackers, :id
  json.programs user.programs, :id, :program_title, :program_title, :program_description, :number_of_days

end
