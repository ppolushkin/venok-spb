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
 

