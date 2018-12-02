# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create! :name => 'John Doe', :email => 'john@gmail.com', :password => 'topsecret', :password_confirmation => 'topsecret'

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks',
    user: user
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty',
    user: user
  },
  {
    name: 'Jax',
    description: '',
    user: user
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys',
    user: user
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua',
    user: user
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all',
    user: user
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes',
    user: user
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity',
    user: user
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig',
    user: user
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run',
    user: user
  },
]

dogs.each do |dog|
  dog = Dog.find_or_create_by(name: dog[:name], description: dog[:description], user: dog[:user])
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end
