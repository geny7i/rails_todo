# README

This README would normally document whatever steps are necessary to get the
application up and running.

*Demo
https://rails-todo-yosida.herokuapp.com/

Things you may want to cover:

* Ruby version
2.50
* System dependencies

* Configuration
```
bundle install
```
* Database initialization
```
rails db:migrate
```
* Deployment instructions
get client id & client secret form https://console.developers.google.com/

setENV
```
export GOOGLE_CLIENT_ID=m"hogero"
export GOOGLE_CLIENT_SECRET="hugarien"
```
```heroku
heroku config:set GOOGLE_CLIENT_ID="your app id"
heroku config:set GOOGLE_CLIENT_SECRET="your client secret"
```

```
raila s
```
* ...
