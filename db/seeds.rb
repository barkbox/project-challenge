# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks',
    user_id: 1,
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty',
    user_id: 1,
  },
  {
    name: 'Jax',
    description: '',
    user_id: 1,
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys',
    user_id: 1,
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua',
    user_id: 1,
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all',
    user_id: 1,
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes',
    user_id: 1,
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity',
    user_id: 1,
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig',
    user_id: 1,
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run',
    user_id: 1,
  },
]

users = [
  {
    name: 'Ryan',
    email: 'ryan@email.com',
    password: 'password'
  },
  {
    name: 'Hillary',
    email: 'hillary@email.com',
    password: 'password'
  },
  {
    name: 'Daisy',
    email: 'daisy@email.com',
    password: 'password'
  }
]

users.each do |user|
  User.create(user)
end

dogs.each.with_index do |dog, i|
  user = i % 3 == 0 ? 3 : i % 3
  puts user
  dog = Dog.find_or_create_by(name: dog[:name], description: dog[:description], user_id: user )
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
