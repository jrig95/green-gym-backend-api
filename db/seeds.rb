# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Clean database..."
puts "\n"

User.destroy_all
puts "Creating users"
admin_user = {email: "admin@admin.com", password: "123456", admin: true}
normal_user = {email: "user@user.com", password: "123456", admin: false}
[admin_user, normal_user].each do |attributes|
  user = User.create!(attributes)
  puts "Created user #{user.email}, admin: #{user.admin}"
end
puts "\n"


Program.destroy_all
puts "Creating programs..."
beach_body_program = { program_title: "Beach Body Program", program_description: "Full body program to give you your dream beach body!", number_of_days: 36, price: 900, program_cover_image: "https://www.verywellfit.com/thmb/pkMhIevhU1f_9CBeXhFrs6w7PkE=/614x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/181215157-56a815323df78cf7729bf6f1.JPG" }

hilton_program = { program_title: "Hilton Employee Exercise Program", program_description: "The official exercise program for Hilton employees", number_of_days: 42, price: 4000, program_cover_image: "https://www.socialshakeupshow.com/wp-content/uploads/2019/11/HiltonEmployees.jpg"}

[ beach_body_program, hilton_program].each do |attributes|
  program = Program.create!(attributes)
  puts "Created #{program.program_title}"
end
puts "\n"


DailyWorkout.destroy_all
puts "Creating Daily Workouts"
programs = Program.all
beach_body_first_day_workout = { program_id: programs[0].id, day_number: 1, daily_challenge_title: "Update your Profile", daily_challenge_description: "Upload a profile pic and fill out your profile", number_of_exercises: 5}

hilton_program_first_day_workout = { program_id: programs[1].id, day_number: 1, daily_challenge_title: "Send a workout pic", daily_challenge_description: "Send a picture of your first workout", number_of_exercises: 6}
[ beach_body_first_day_workout, hilton_program_first_day_workout].each do |attributes|
  daily_workout = DailyWorkout.create!(attributes)
  puts "Created daily workout #{daily_workout.day_number} for #{daily_workout.program.program_title}"
end
puts "\n"

LibraryItem.destroy_all
puts "Creating Libray Item"
library_item_one = { title: "push ups"}
library_item_two = { title: "squat hold"}
library_item_three = { title: "burpees"}
library_item_four = { title: "planks"}
[library_item_one, library_item_two, library_item_three, library_item_four].each do |attributes|
  library_item = LibraryItem.create!(attributes)
  puts "Created library item #{library_item.title}"
end
puts "\n"


Exercise.destroy_all
puts "Creating Exercises"
daily_workouts = DailyWorkout.all
library_items = LibraryItem.all
beach_body_first_day_workout_exercise_one = {exercise_title: "push ups", exercise_question: true, exercise_work_time: "45 seconds", exercise_rest_time: "15 seconds", calories_per_exercise: 40, daily_workout_id: daily_workouts[0].id, library_item_id: library_items[0].id}

beach_body_first_day_workout_exercise_two = {exercise_title: "squat hold", exercise_question: false, exercise_work_time: "45 seconds", exercise_rest_time: "15 seconds", calories_per_exercise: 30, daily_workout_id: daily_workouts[0].id, library_item_id: library_items[1].id}

hilton_program_first_day_workout_exercise_one = {exercise_title: "burpees", exercise_question: true, exercise_work_time: "30 seconds", exercise_rest_time: "15 seconds", calories_per_exercise: 50, daily_workout_id: daily_workouts[1].id, library_item_id: library_items[2].id}

hilton_program_first_day_workout_exercise_two = {exercise_title: "planks", exercise_question: false, exercise_work_time: "60 seconds", exercise_rest_time: "15 seconds", calories_per_exercise: 40, daily_workout_id: daily_workouts[1].id, library_item_id: library_items[3].id}

[beach_body_first_day_workout_exercise_one, beach_body_first_day_workout_exercise_two, hilton_program_first_day_workout_exercise_one, hilton_program_first_day_workout_exercise_two].each do |attributes|
exercise = Exercise.create!(attributes)
  puts "Created exercise #{exercise.exercise_title} for #{exercise.daily_workout.program.program_title} day #{exercise.daily_workout.day_number} workout"
end
puts "\n"

Reward.destroy_all
puts "Creating Rewards"

apple_watch = {reward_name: "Apple Watch", reward_image: "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MKUW3_VW_34FR+watch-45-alum-blue-cell-7s_VW_34FR_WF_CO?wid=1400&hei=1400&trim=1%2C0&fmt=p-jpg&qlt=95&.v=1632171100000%2C1631661588000", reward_points: 4000, program_id: nil, visible: false}

beach_body_program_sunglasses_reward = {reward_name: "Sunglasses", reward_image: "https://cdn.shopify.com/s/files/1/0084/1616/5946/products/AGingersSoul_3Q_1000x.jpg?v=1588805484", reward_points: 2000, program_id: programs[0].id, visible: true}

hilton_program_shoes_reward =  {reward_name: "shoes", reward_image: "https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/gxnjiwtoqqamijxhi72z/revolution-5-mens-road-running-shoes-ZXqS6C.png", reward_points: 3500, program_id: programs[1].id, visible: false}
[apple_watch, beach_body_program_sunglasses_reward, hilton_program_shoes_reward].each do |attributes|
  reward = Reward.create!(attributes)
  if reward.program_id.nil?
    puts "Created #{reward.reward_name}"
  else
    puts "Created  visble: #{reward.visible} reward #{reward.reward_name} for #{Program.where(id:[reward.program_id])[0].program_title}"
  end
end
puts "\n"
