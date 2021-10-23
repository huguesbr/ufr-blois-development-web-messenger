# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# creating some users
%w(Hugues Talia Naelie Kian).each do |name|
  User.create(name: name)
end

# creating some chats
%w(Development Fun Random).each do |name|
  Chat.create(name: name, user: User.all.sample)
end

# creating some messages
['Hello, world', "What's up", "How are you?", "Coming tonight?", "No", "Yes"].each do |text|
  Message.create(chat: Chat.all.sample, user: User.all.sample, text: text)
end