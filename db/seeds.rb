# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

require 'open-uri'

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

# create a list of images to be used in rewards and programs
program_images = [
  'https://tse2-mm.cn.bing.net/th/id/OIP-C.QZxypTqcfm_3djPGXESRgwHaE7?w=260&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse3-mm.cn.bing.net/th/id/OIP-C.mbrWkT3bGhylpd_aVZydfAHaE8?w=259&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse1-mm.cn.bing.net/th/id/OIP-C.K3_sVSyKJHYcbK5t1ILH7gHaFj?w=231&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse3-mm.cn.bing.net/th/id/OIP-C.PAAiCFTeq4-Vv8yBzbReAwHaE7?w=281&h=188&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse1-mm.cn.bing.net/th/id/OIP-C.55slZc5z4gPnl1CDTnTRcQHaE8?w=223&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
]

reward_images = [
  'https://tse4-mm.cn.bing.net/th/id/OIP-C.xXXHVUAJyZgz3zLPSXxv2wHaHa?w=158&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse2-mm.cn.bing.net/th/id/OIP-C.Ne1XPbs6M2RHP_bdA9Pa8wHaHa?w=157&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse4-mm.cn.bing.net/th/id/OIP-C.TZKCYtZOzvhQqQTXqmXr3AHaEd?w=301&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse3-mm.cn.bing.net/th/id/OIP-C.Zj6-DTx0uiLhQhKy9uBy5AHaJ4?w=132&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7', 'https://tse4-mm.cn.bing.net/th/id/OIP-C.wE9oQ4ccsUFUBlVpWVGhggHaFj?w=238&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
]

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
  file = URI.open(program_images.sample)

  number_of_days = rand(7..30)
  
  program = Program.create!(
    program_title: Faker::Company.name,
    program_description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
    number_of_days: number_of_days,
    price: Faker::Commerce.price
  )

  program.photo.attach(io: file, filename: 'image.png', content_type: 'image/png')
  program.save!

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
    file = URI.open(reward_images.sample)

    reward = Reward.new(
      reward_name: Faker::Commerce.product_name,
      reward_points: Faker::Number.between(from: 3000, to: 7000),
      program_id: program.id,
      visible: Faker::Boolean.boolean(true_ratio: 0.5)
    )
  
    reward.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
    reward.save!

    puts "Created Reward: #{reward.reward_name}"
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
puts 'Creating users'

gender = %w[Male Female]
fitness_level = %w[beginner intermediate advanced]

20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: '123456',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_company: Faker::Company.name,
    user_total_calories: Faker::Number.between(from: 3000, to: 7000),
    user_points: Faker::Number.between(from: 3000, to: 7000),
    user_passions: Faker::Movies::Lebowski.quote,
    user_gender: gender.sample,
    user_fitness_level: fitness_level.sample,
    admin: false
  )

  puts "Say hello to #{user.first_name} #{user.last_name} who works for #{user.user_company}"

  # save a random program id so it can be reused.
  program_id = program_ids.sample

  # for each user I create one program tracker
  program = Program.find(program_id)

  puts "#{user.first_name} has selected the program #{program.program_title}"

  program_tracker = ProgramTracker.create!(program_id: program.id, user_id: user.id)

  puts "Created ProgramTracker for #{user.first_name}"

  program.daily_workouts.each do |daily_workout|
    daily_workout_tracker = DailyWorkoutTracker.create!(
      program_tracker_id: program_tracker.id,
      daily_workout_id: daily_workout.id
    )
    daily_workout.exercises.each do |exercise|
      exercise_tracker = ExerciseTracker.create!(number_of_reps: 0, daily_workout_tracker_id: daily_workout_tracker.id,
                                                 exercise_id: exercise.id)
    end
  end
end

puts "\n"

puts 'Creating rewards....'
puts "\n"

file = URI.open(reward_images.sample)

20.times do
  reward = Reward.new(
    reward_name: Faker::Commerce.product_name,
    reward_points: Faker::Number.between(from: 3000, to: 7000),
    program_id: nil,
    visible: Faker::Boolean.boolean(true_ratio: 0.5)
  )

  reward.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
  reward.save!

  puts "Created Reward: #{reward.reward_name}"
  puts "\n"
end
puts "\n"

puts '******************************'

puts "\n"

puts 'creating a program with an image'

file = URI.open('https://th.bing.com/th/id/OIP.XZSw6cYr8Y5MWR4CastG5gHaF7?pid=ImgDet&rs=1')
program = Program.new(program_title: 'NES', program_description: 'A great console', number_of_days: 7, price: 6)
program.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
program.save!

puts 'created a program with an image'

puts 'creating library_item with a video'
# video
file = URI.open('https://vd2.bdstatic.com/mda-ji09d1rc02h0njw2/sc/mda-ji09d1rc02h0njw2.mp4?v_from_s=hkapp-haokan-nanjing&auth_key=1652777270-0-0-d1d3013a011ca5c9f03e2a005d03d730&bcevod_channel=searchbox_feed&cd=0&pd=1&pt=3&logid=1070074697&vid=5816411584377358713&abtest=101830_1-102148_2-17451_1-3000225_3&klogid=1070074697')

library_item = LibraryItem.new(title: 'workout')
library_item.video.attach(io: file, filename: 'workout.mp4', content_type: 'video/mp4')
library_item.save!

puts 'created library_item with a video'

# puts "creating reward with a photo"
# file = URI.open('https://th.bing.com/th/id/OIP.XZSw6cYr8Y5MWR4CastG5gHaF7?pid=ImgDet&rs=1')
# reward = Reward.new(
#     reward_name: "pic reward",
#     reward_points: 90,
#     program_id: nil,
#     visible: false
#   )
# reward.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
# reward.save!
# puts "created photo reward"

puts 'creating user with a photo'
file = URI.open('https://th.bing.com/th/id/OIP.XZSw6cYr8Y5MWR4CastG5gHaF7?pid=ImgDet&rs=1')
user = User.create!(
  email: Faker::Internet.email,
  password: '123456',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  user_company: Faker::Company.name,
  user_total_calories: Faker::Number.between(from: 3000, to: 7000),
  user_points: Faker::Number.between(from: 3000, to: 7000),
  user_passions: Faker::Movies::Lebowski.quote,
  user_gender: gender.sample,
  user_fitness_level: fitness_level.sample,
  admin: false
)
user.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
user.save!

puts 'user with photo created'

puts 'Seeds successfully created'
