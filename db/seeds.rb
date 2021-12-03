# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# creating some users
%w(Hugues Talia Naelie Kian).each do |name|
  puts "creating user #{name} (password: password)"
  User.create(name: name, password: "password")
  # User.create(name: name, password: SecureRandom.hex(10))
end

# creating some chats
%w(Development Fun Random).each do |name|
  # creating a chat, will also create a membership for the chat owner
  # `after_create`
  user = User.all.sample
  puts "creating chat's #{name} owned by #{user.name}"
  Chat.create(name: name, user: user)
end

# creating some messages
['Hello, world', "What's up", "How are you?", "Coming tonight?", "No", "Yes"].each do |text|
  chat = Chat.all.sample
  user = User.all.sample
  puts "creating message #{text} in chat #{chat.name} by #{user.name}"
  Message.create(chat: chat, user: user, text: text)
end

# ensure that each chat's message owner have a membership
Message.all.each do |message|
  # https://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_create_by
  # Finds the first record with the given attributes, or creates a record with the attributes if one is not found
  puts "ensuring user #{message.user.name} has a membership in chat #{message.chat.name}"
  Membership.find_or_create_by(chat_id: message.chat_id, user_id: message.user_id, status: 'accepted')
end