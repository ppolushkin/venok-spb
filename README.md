venok
=======

Это розничный сайт.

How to push into production:

https://devcenter.heroku.com/articles/git

 git push production master:master

How to push into staging:

 git checkout staging  
 git commit -am 'changes'  
 git push heroku staging:master  

How to run rake console
 q [venok-spb-staging | venok]


How to periodically clean basket:

 heroku run rake session_cleaner:clean --app venok
 
How to fix precompile error during deploy:  
http://stackoverflow.com/questions/16432825/heroku-precompile-assets-failed-on-rail-4-app  
https://devcenter.heroku.com/articles/labs-user-env-compile

How to read logs:
  heroku logs -n 1500 --app venok | less
 

How db was migrated to paid plan:
https://devcenter.heroku.com/articles/upgrading-heroku-postgres-databases#upgrade-with-pg-copy-default

heroku maintenance:on --app venok

heroku addons:add heroku-postgresql:hobby-basic --app venok

heroku pg:copy HEROKU_POSTGRESQL_VIOLET HEROKU_POSTGRESQL_AQUA_URL --app venok

heroku pg:promote HEROKU_POSTGRESQL_AQUA_URL --app venok

heroku maintenance:off --app venok

== How to add heroku repo ==
heroku login
heroku git:remote -a obelisk-spb-staging -r staging

https://devcenter.heroku.com/articles/git#creating-a-heroku-remote

== Setup docker environment ==

https://docs.docker.com/compose/rails/

1. Install docker
2. Install docker-compose
3. Make sure project is located in ~/Workspace/venok
4. run
    sudo docker-compose up
5. Create db via rake
    sudo docker-compose run rails rake db:create
6. Now you have to setup database. First restart it:
    sudo docker-compose down
    sudo rm ~/Workspace/venok/tmp/pids/server.pid
    sudo docker-compose up
7. Attach to db container and restore db
a)  find and copy image id
    sudo docker images
b)  connect to it
    sudo docker exec -it 665b4a1e17b6 bash
c)  make restore
    cd /home/venok
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -U postgres -d dev_venok venok_db_2018-01-20.dump
8. Restart cluster again


== Run docker container ==
sudo docker run -it -p 3000:3000 -v ~/Workspace/venok:/home/venok venok_rails bash -l


