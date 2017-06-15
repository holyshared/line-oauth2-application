# line-oauth2-application

This is a sample application of [LINE Login](https://developers.line.me/line-login/overview) using the following authentication gem.

* devise
* omniauth
* omniauth-oauth2, ~> 1.3.1
* [omniauth-line](https://github.com/holyshared/omniauth-line) (Not original)

## Setup

```shell
# clone from github
git clone https://github.com/holyshared/line-oauth2-application.git
cd line-oauth2-application

# setup
bundle install
bundle exec rake db:create
bundle exec rake db:migrate
```

### Environments

LINE Set environment variables for login.  
At this time you need a **LINE Business Account**.  
[https://developers.line.me/line-login/overview](https://developers.line.me/line-login/overview)

* LINE\_CHANNEL\_ID
* LINE\_CHANNEL\_SECRET
