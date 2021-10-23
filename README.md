# Messenger App

## Rails App Setup
```
cd ~/Developer
git clone https://github.com/huguesbr/ufr-blois-development-web-messenger.git messenger
cd messenger
bundle install --path="vendor/bundle"
bin/rake db:migrate:reset
bin/rake db:seed
bin/rails server
```

## Postman Setup

- launch postman
- import `Messenger.postman_collection.json` (File > import)

## Checkout version of a specific TD

```
git fetch --all --tags
git checkout tags/td-06 -b td-06
bundle install --path="vendor/bundle"
bin/rake db:migrate:reset
bin/rake db:seed
```
