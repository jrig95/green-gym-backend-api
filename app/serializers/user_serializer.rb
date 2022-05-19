class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :admin, :created_at, :first_name, :last_name, :user_company, :user_gender, :user_fitness_level, :user_passions, :user_total_calories, :user_points

  # def first_name
  #   object.first_name
  # end
  # def user_attributes
  #   puts serialization_options[:first_name]
  # end
end
