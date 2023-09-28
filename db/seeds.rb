# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do |i|
  User.create(
    name: Faker::Name.name,
    photo: "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
    bio: Faker::Lorem.paragraphs(number: 1).join("\n\n"),
    posts_counter: 0
  )
end

10.times do
  Post.create(
    author_id: rand(21..32), # Random author ID between 21 and 32
    title: Faker::Lorem.sentence,
    text: Faker::Lorem.paragraphs(number: 3).join("\n\n"), # Generates 3 paragraphs of text
    likes_counter: rand(0..50), # Random likes counter
    comments_counter: rand(0..20) # Random comments counter
  )
end