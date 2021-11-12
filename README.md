# Messenger App

## Rails App Setup
```
cd ~/Developer
# delete any previous version of the messenger repo
rm -fr messenger
# clone the messenger git repo
git clone https://github.com/huguesbr/ufr-blois-development-web-messenger.git messenger
cd messenger
# install any dependencies
bundle install --path="vendor/bundle"
# reset the database to a clean state
bin/rake db:migrate:reset
# populate some dummy data in our database
bin/rake db:seed
# launch rails server
bin/rails server
```

> Test that your setup is working by navigating to http://localhost:3000

## Postman Setup

- launch Postman (Accessories / Postman) 
- import `~/Developer/messenger/Messenger.postman_collection.json` (File > import)

## Console

```
bin/rails console
> User.all
> app.get '/chats'
```

## SQL Console

```
bin/rails dbconsole
> select * from users
```

## Logs

```
tail -f log/development.log
```
