# README

This is a simple demonstration site I'm using to showcase some technologies, and also to publish my personal resume and portfolio.

This was deployed to Google Cloud Kubernetes Engine, and was based on examples from the following sources:

* [Razvan Draghici's "Rails on Kubernetes" blog series](https://blog.cosmocloud.co/rails-on-kubernetes-part-1/)
* [Abe Voelker's "Deploying a Ruby on Rails application to Google Kubernetes Engine" blog series](https://blog.abevoelker.com/2018-04-05/deploying-a-ruby-on-rails-application-to-google-kubernetes-engine-a-step-by-step-guide-part-1/)


Using, mainly:
* Ruby 2.5
* Rails 5
* Bootstrap 4
* Haml
* Sass
* Google fonts, FontAwesome, Devicon 2.0

# Notes

* Used rails generator option `--skip-coffee`
* Customized Dockerfile, changed the `ADD` commands to `COPY` as per compose tutorial
* Had to add additional whitelisted_ips: `config.web_console.whitelisted_ips = ['172.16.0.0/12', '192.168.0.0/16']`
* Had to comment out test for Redis in the docker-entrypoint.sh
* Had to modify the gemfile to use tzinfo-data always
