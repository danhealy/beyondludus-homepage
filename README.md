# README

This is a simple demonstration site I'm using to showcase some technologies, and also to publish my personal resume and portfolio.

This was deployed to Linode using Docker Swarm, after having evaluated the possibility of using Kubernetes.  My takeaway from attempting to get this working in Kubernetes is that I found the manifests and server requirements too heavy weight for such a small project.  I attempted to use some alternatives to reduce complexity, like ksonnet and Kontena, but mainly it felt like I was trading complexity in Kubernetes for even more esoteric domain complexity and not really gaining any overall simplification.

Those pain points would be worth dealing with in an environment that requires rapid scaling, high availability and all the bells and whistles, but for this demonstration I just felt it was a bit too much.

Some good blog posts I studied:
* [Razvan Draghici's "Rails on Kubernetes" blog series](https://blog.cosmocloud.co/rails-on-kubernetes-part-1/)
* [Abe Voelker's "Deploying a Ruby on Rails application to Google Kubernetes Engine" blog series](https://blog.abevoelker.com/2018-04-05/deploying-a-ruby-on-rails-application-to-google-kubernetes-engine-a-step-by-step-guide-part-1/)
* [LH Fong's "Deploying Redis with Persistence on Google Kubernetes Engine" blog post](https://estl.tech/deploying-redis-with-persistence-on-google-kubernetes-engine-c1d60f70a043)
* [CoderJourney's "Learning Rails" series of tutorials, especially in regards to Docker deployment](https://coderjourney.com/learning-rails-deploying-rails-part-8/)
* [Adilson Cesar's "Using Reverse Load Balance Proxy with Docker Swarm" blog post](https://medium.com/@adilsonbna/traefik-using-reverse-load-balance-proxy-with-docker-swarm-3c8dd3921b7a)


The web front end itself is built around:
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
* Had to comment out test for Redis in the `docker-entrypoint.sh`
* Had to modify the gemfile to use `tzinfo-data` always
