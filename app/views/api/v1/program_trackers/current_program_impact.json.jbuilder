

json.programs do
  json.array! @programs do |program|
    json.extract! program, :id, :program_title
    json.users do
      json.array! program.users.order(user_total_calories: :desc) do |user|
        json.extract! user, :id, :first_name, :user_total_calories

        if user.photo.attached?
          json.photo_url user.photo.service_url
        end
      end
    end
  end
end
