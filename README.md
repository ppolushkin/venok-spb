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
 heroku run rails console --app [venok-spb-staging | venok]


How to periodically clean basket:

 heroku run rake session_cleaner:clean --app venok

