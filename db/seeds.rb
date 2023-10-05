# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# Assuming you have users with IDs 3 to 5 in your database
user_ids = (3..5).to_a

user_ids.each do |user_id|
  user = User.find_by(id: user_id)

  if user
    user.posts_counter.times do
      Post.create(
        author: user, 
        title: Faker::Lorem.sentence,
        text: Faker::Lorem.paragraphs(number: 4).join("\n\n"),
        likes_counter: rand(0..50),
        comments_counter: rand(0..20)
      )
    end

    50.times do
      random_user = User.where(id: (3..5).to_a.sample).first
      random_post = Post.order('RANDOM()').first
      Comment.create(
        user_id: random_user.id,
        post: random_post, 
        text: Faker::Lorem.sentence
      )
    end
  else
    puts "User with ID #{user_id} not found in the database."
  end
end


