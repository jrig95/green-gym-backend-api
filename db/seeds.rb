# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'Cleaning database...'
puts 'Destroying LibraryItems'
LibraryItem.destroy_all
puts 'Destroying Users'
User.destroy_all
puts 'Destroying Programs'
Program.destroy_all
puts 'Destroying Exercise overviews'
ExerciseOverview.destroy_all
puts 'Destroying ProgramTrackers'
ProgramTracker.destroy_all
puts 'Destroying DailyWorkoutTracker'
DailyWorkoutTracker.destroy_all
puts 'Destroying ExerciseTrakcers'
ExerciseTracker.destroy_all

# you need to destory everything before you seed. do it all here. before making anything.

# create empty array
libray_item_ids = []

# library_items first
puts 'Creating Library Items'
30.times do
  item = LibraryItem.create!(
    title: Faker::Music.band
  )
  puts "Created Library Item #{item.title} with ID: #{item.id}"
  libray_item_ids << item.id
  puts "added Library Item #{item.title} with ID: #{item.id} to array"
end
puts "\n"

# create programs (num of day) 20times.do each loop create a workout assign to a day

# Create programs array
program_ids = []

# Don't create an id for a program - Rails is already doing that.
puts 'creating Programs'
20.times do
  number_of_days = rand(7..30)

  program = Program.create!(
    program_title: Faker::Company.name,
    program_description: Faker::Company.buzzword,
    number_of_days: number_of_days,
    program_cover_image: 'https://picsum.photos/200',
    price: Faker::Commerce.price
  )
  puts "Created Program #{program.program_title} with ID: #{program.id}"

  program_ids << program.id
  puts "Added Programd #{program.id} to Program_ids array"

  # Create some daily_workouts
  puts "Creating Daily Workouts for #{program.program_title} with ID: #{program.id}"
  day_number = 1
  number_of_exercises = rand(5..10)
  number_of_days.times do
    daily_workout = DailyWorkout.create!(
      day_number: day_number,
      daily_challenge_title: Faker::Company.buzzword,
      daily_challenge_description: Faker::Movie.quote,
      number_of_exercises: number_of_exercises,
      program_id: program.id
    )

    number_of_exercises.times do
      Exercise.create!(
        exercise_title: Faker::Verb.ing_form,
        exercise_question: true,
        exercise_work_time: Faker::Number.between(from: 1, to: 60),
        exercise_rest_time: Faker::Number.between(from: 1, to: 30),
        calories_per_exercise: Faker::Number.between(from: 30, to: 90),
        daily_workout_id: daily_workout.id,
        library_item_id: libray_item_ids.sample
      )
    end

    number_of_exercises.times do
      ExerciseOverview.create!(
        overview_exercise_title: Faker::Book.title,
        number_of_sets: Faker::Number.between(from: 1, to: 5),
        daily_workout_id: daily_workout.id
      )
    end
    day_number += 1
  end

  rand(4).times do
    Reward.create!(
      reward_name: Faker::Commerce.product_name,
      reward_image: 'https://picsum.photos/200',
      reward_points: Faker::Number.between(from: 3000, to: 7000),
      program_id: program.id
    )
  end
  puts "\n"
end

puts "\n"

puts 'Creating users'
admin_user = { email: 'admin@admin.com', password: '123456', admin: true }
normal_user = { email: 'user@user.com', password: '123456', admin: false }
no_program_user = { email: 'nooprogram@noprogram.com', password: '123456', admin: false }
[admin_user, normal_user, no_program_user].each do |attributes|
  user = User.create!(attributes)
  puts "Created user #{user.email}, admin: #{user.admin}"
end

# create users
puts "Creating users"

20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    admin: false
  )

  puts "Created user #{user.email} with ID: #{user.id}"

  # save a random program id so it can be reused.
  program_id = program_ids.sample

  
  # for each user I create one program tracker
  program = Program.find(program_id)
  
  puts "User #{user.email} has selected the program #{program.program_title}"

  program_tracker = ProgramTracker.create!(program_id: program.id, user_id: user.id)

  puts "Created ProgramTracker for user #{user.email}"

  program.daily_workouts.each do |daily_workout|
    daily_workout_tracker = DailyWorkoutTracker.create!(
      program_tracker_id: program_tracker.id,
      daily_workout_id: daily_workout.id,
    )
    daily_workout.exercises.each do |exercise|
      exercise_tracker = ExerciseTracker.create!(number_of_reps: 0, daily_workout_tracker_id: daily_workout_tracker.id,
                                                 exercise_id: exercise.id)
    end
  end
end

# create programs (num of day) 20times.do each loop create a workout assign to a day
# DailyWorkout.destroy_all
# puts 'creating Daily Workouts'
# (1..80).each do |id|
#   DailyWorkout.create(
#     id: id,
#     program_id: rand(1..20),
#     daily_challenge_title: Faker::Company.buzzword,
#     daily_challenge_description: Faker::Movie.quote,
#     day_number: Faker::Number.between(from: 1, to: 40),
#     number_of_exercises: Faker::Number.between(from: 4, to: 12)
#   )
# end
# puts "\n"

# ExerciseOverview.destroy_all
# puts 'Creating Exercise Overviews'
# # exercise_overview = ExerciseOverview.all
# 80.times do
#   ExerciseOverview.create(
#     daily_workout_id: rand(1..80),
#     overview_exercise_title: Faker::Book.title,
#     number_of_sets: Faker::Number.between(from: 1, to: 5)
#   )
# end
# puts "\n"

# DailyWorkoutTracker.destroy_all
# puts 'Creating Daily Workout Trackers'
# 81.times do |id|
#   DailyWorkoutTracker.create(
#     id: id,
#     program_tracker_id: rand(1..20),
#     daily_workout_id: rand(1..80),
#     dwt_check_in: Faker::Boolean.boolean(true_ratio: 0.8),
#     dwt_daily_challenge: Faker::Boolean.boolean(true_ratio: 0.8)
#   )
# end
# puts "\n"

# ProgramTracker.destroy_all
# puts 'creating Program Trackers'
# (1..20).each do |id|
#   ProgramTracker.create(
#     id: id,
#     program_id: rand(1..20),
#     user_id: rand(1..20)
#   )
# end
# puts "\n"
# create exercises
# create users create trackers and reference a program id sample
# Exercise.destroy_all
# puts 'creating Exercises'
# (1..100).each do |id|
#   Exercise.create(
#     id: id,
#     exercise_title: Faker::Verb.ing_form,
#     exercise_question: true,
#     exercise_work_time: Faker::Number.between(from: 1, to: 60),
#     exercise_rest_time: Faker::Number.between(from: 1, to: 30),
#     calories_per_exercise: Faker::Number.between(from: 30, to: 90),
#     daily_workout_id: rand(1..80),
#     library_item_id: rand(1..30)
#   )
# end

# ExerciseTracker.destroy_all
# puts 'Creating Exercise Trackers'
# (1..100).each do |id|
#   ExerciseTracker.create(
#     id: id,
#     number_of_reps: Faker::Number.between(from: 10, to: 50),
#     exercise_id: rand(1..100),
#     daily_workout_tracker_id: rand(1..81)
#   )
# end

20.times do
  Reward.create!(
    reward_name: Faker::Commerce.product_name,
    reward_image: 'https://picsum.photos/200',
    reward_points: Faker::Number.between(from: 3000, to: 7000),
    program_id: nil,
    visible: Faker::Boolean.boolean(true_ratio: 0.5)
  )
end
puts "\n"

# puts "\n"

# # first_user = User.first
# # first_car = Car.new(user: first_user, name: "Escalade", description: "A classic SUV popular in the mid 2000's ", year: 2003, model: "S", location: "Minhang")
# # first_car.save!

# Program.destroy_all
# puts 'Creating programs...'
# beach_body_program = { program_title: 'Beach Body Program',
#                        program_description: 'Full body program to give you your dream beach body!', number_of_days: 36, price: 900, program_cover_image: 'https://www.verywellfit.com/thmb/pkMhIevhU1f_9CBeXhFrs6w7PkE=/614x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/181215157-56a815323df78cf7729bf6f1.JPG' }

# hilton_program = { program_title: 'Hilton Employee Exercise Program',
#                    program_description: 'The official exercise program for Hilton employees', number_of_days: 42, price: 4000, program_cover_image: 'https://www.socialshakeupshow.com/wp-content/uploads/2019/11/HiltonEmployees.jpg' }

# [beach_body_program, hilton_program].each do |attributes|
#   program = Program.create!(attributes)
#   puts "Created #{program.program_title}"
# end

# 20.times do
#   Program.create(
#     program_title: Faker::Company.name,
#     program_description: Faker::Company.buzzword,
#     number_of_days: Faker::Number.between(from: 1, to: 40),
#     program_cover_image: 'https://picsum.photos/200',
#     price: Faker::Commerce.price
#   )
# end

# puts "\n"

# DailyWorkout.destroy_all
# puts 'Creating Daily Workouts'
# programs = Program.all
# beach_body_first_day_workout = { program_id: programs[0].id, day_number: 1,
#                                  daily_challenge_title: 'Update your Profile', daily_challenge_description: 'Upload a profile pic and fill out your profile', number_of_exercises: 5 }

# hilton_program_first_day_workout = { program_id: programs[1].id, day_number: 1,
#                                      daily_challenge_title: 'Send a workout pic', daily_challenge_description: 'Send a picture of your first workout', number_of_exercises: 6 }
# [beach_body_first_day_workout, hilton_program_first_day_workout].each do |attributes|
#   daily_workout = DailyWorkout.create!(attributes)
#   puts "Created daily workout #{daily_workout.day_number} for #{daily_workout.program.program_title}"
# end

# 80.times do
#   DailyWorkout.create(
#     program_id: Faker::Number.between(from: 1, to: 23),
#     daily_challenge_title: Faker::Company.buzzword,
#     daily_challenge_description: Faker::Movie.quote,
#     day_number: Faker::Number.between(from: 1, to: 40),
#     number_of_exercises: Faker::Number.between(from: 4, to: 12)
#   )
# end
# puts "\n"

# ExerciseOverview.destroy_all
# puts 'Creating Exercise Overviews'
# # exercise_overview = ExerciseOverview.all
# 20.times do
#   ExerciseOverview.create(
#     daily_workout_id: Faker::Number.between(from: 1, to: 80),
#     overview_exercise_title: Faker::Book.title,
#     number_of_sets: Faker::Number.between(from: 1, to: 5)
#   )
# end
# puts "\n"

# LibraryItem.destroy_all
# puts 'Creating Library Item'
# library_item_one = { title: 'push ups' }
# library_item_two = { title: 'squat hold' }
# library_item_three = { title: 'burpees' }
# library_item_four = { title: 'planks' }
# [library_item_one, library_item_two, library_item_three, library_item_four].each do |attributes|
#   library_item = LibraryItem.create!(attributes)
#   puts "Created library item #{library_item.title}"
# end

# Exercise.destroy_all
# puts 'Creating Exercises'
# daily_workouts = DailyWorkout.all
# library_items = LibraryItem.all
# beach_body_first_day_workout_exercise_one = { exercise_title: 'push ups', exercise_question: true,
#                                               exercise_work_time: '45 seconds', exercise_rest_time: '15 seconds', calories_per_exercise: 40, daily_workout_id: daily_workouts[0].id, library_item_id: library_items[0].id }

# beach_body_first_day_workout_exercise_two = { exercise_title: 'squat hold', exercise_question: false,
#                                               exercise_work_time: '45 seconds', exercise_rest_time: '15 seconds', calories_per_exercise: 30, daily_workout_id: daily_workouts[0].id, library_item_id: library_items[1].id }

# hilton_program_first_day_workout_exercise_one = { exercise_title: 'burpees', exercise_question: true,
#                                                   exercise_work_time: '30 seconds', exercise_rest_time: '15 seconds', calories_per_exercise: 50, daily_workout_id: daily_workouts[1].id, library_item_id: library_items[2].id }

# hilton_program_first_day_workout_exercise_two = { exercise_title: 'planks', exercise_question: false,
#                                                   exercise_work_time: '60 seconds', exercise_rest_time: '15 seconds', calories_per_exercise: 40, daily_workout_id: daily_workouts[1].id, library_item_id: library_items[3].id }

# [beach_body_first_day_workout_exercise_one, beach_body_first_day_workout_exercise_two,
#  hilton_program_first_day_workout_exercise_one, hilton_program_first_day_workout_exercise_two].each do |attributes|
#   exercise = Exercise.create!(attributes)
#   puts "Created exercise #{exercise.exercise_title} for #{exercise.daily_workout.program.program_title} day #{exercise.daily_workout.day_number} workout"
# end

# 100.times do
#   Exercise.create(
#     exercise_title: Faker::Verb.ing_form,
#     exercise_question: true,
#     exercise_work_time: Faker::Number.between(from: 1, to: 60),
#     exercise_rest_time: Faker::Number.between(from: 1, to: 30),
#     calories_per_exercise: Faker::Number.between(from: 30, to: 90),
#     daily_workout_id: Faker::Number.between(from: 1, to: 70),
#     library_item_id: Faker::Number.between(from: 1, to: 29)
#   )
# end

# puts "\n"

# Reward.destroy_all
# puts 'Creating Rewards'

# apple_watch = { reward_name: 'Apple Watch',
#                 reward_image: 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MKUW3_VW_34FR+watch-45-alum-blue-cell-7s_VW_34FR_WF_CO?wid=1400&hei=1400&trim=1%2C0&fmt=p-jpg&qlt=95&.v=1632171100000%2C1631661588000', reward_points: 4000, program_id: nil, visible: false }

# beach_body_program_sunglasses_reward = { reward_name: 'Sunglasses',
#                                          reward_image: 'https://cdn.shopify.com/s/files/1/0084/1616/5946/products/AGingersSoul_3Q_1000x.jpg?v=1588805484', reward_points: 2000, program_id: programs[0].id, visible: true }

# hilton_program_shoes_reward = { reward_name: 'shoes',
#                                 reward_image: 'https://static.nike.com/a/images/t_PDP_864_v1/f_auto,b_rgb:f5f5f5/gxnjiwtoqqamijxhi72z/revolution-5-mens-road-running-shoes-ZXqS6C.png', reward_points: 3500, program_id: programs[1].id, visible: false }
# [apple_watch, beach_body_program_sunglasses_reward, hilton_program_shoes_reward].each do |attributes|
#   reward = Reward.create!(attributes)
#   if reward.program_id.nil?
#     puts "Created #{reward.reward_name}"
#   else
#     puts "Created  visble: #{reward.visible} reward #{reward.reward_name} for #{Program.where(id: [reward.program_id])[0].program_title}"
#   end
# end

# ProgramTracker.destroy_all
# puts 'Creating Program Trackers'

# user_two_with_beach_body_program = { program_id: 1, user_id: 2 }
# user_two_with_hilton_program = { program_id: 2, user_id: 2 }

# [user_two_with_beach_body_program, user_two_with_hilton_program].each do |attributes|
#   program_tracker = ProgramTracker.create!(attributes)
#   puts "Created #{program_tracker.user.email}'s #{program_tracker.program.program_title} program tracker."
# end

# 41.times do
#   ProgramTracker.create(
#     program_id: Faker::Number.between(from: 3, to: 22),
#     user_id: Faker::Number.between(from: 4, to: 22)
#   )
# end
# puts "\n"

# DailyWorkoutTracker.destroy_all
# puts 'Creating Daily Workout Trackers'

# user_two_with_beach_body_program_day_one_dwt = { program_tracker_id: 1, daily_workout_id: 1, dwt_check_in: true,
#                                                  dwt_daily_challenge: true }
# user_two_with_hilton_program_day_one_dwt = { program_tracker_id: 2, daily_workout_id: 2, dwt_check_in: true,
#                                              dwt_daily_challenge: true }

# [user_two_with_beach_body_program_day_one_dwt, user_two_with_hilton_program_day_one_dwt].each do |attributes|
#   dwt = DailyWorkoutTracker.create!(attributes)
#   puts "Created #{dwt.program_tracker.user.email}'s daily_workout_tracker for day #{dwt.daily_workout.day_number} of program: #{dwt.program_tracker.program.program_title}."
# end

puts 'Seeds successfully created'
