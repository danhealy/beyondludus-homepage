# README

Following https://blog.cosmocloud.co/rails-on-kubernetes-part-1/

Install ruby 2.5.1, rails, docker for mac

Minikube
`brew cask install minikube`

Install google cloud sdk
```
brew cask install google-cloud-sdk
# relog shell
gcloud auth login
# finish login
gcloud config set project beyondludus
gcloud auth configure-docker
```

Generated with:

```
rails new beyondludus --skip-coffee --database=postgresql
```

## Install devise
```
rails generate devise:install
rails generate devise user
```

Devise notes:

```
  Some setup you must do manually if you haven't yet:

    1. Ensure you have defined default url options in your environments files. Here
       is an example of default_url_options appropriate for a development environment
       in config/environments/development.rb:

         config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

       In production, :host should be set to the actual host of your application.

    2. Ensure you have defined root_url to *something* in your config/routes.rb.
       For example:

         root to: "home#index"

    3. Ensure you have flash messages in app/views/layouts/application.html.erb.
       For example:

         <p class="notice"><%= notice %></p>
         <p class="alert"><%= alert %></p>

    4. You can copy Devise views (for customization) to your app by running:

         rails g devise:views
```


Setup docker.  Dockerfile in tutorial vs dockerfile in Compose example
https://docs.docker.com/compose/rails/

Want to use alpine, ruby 2.5.1:
https://hub.docker.com/r/library/ruby/tags/2.5.1-alpine3.7/

Changed the ADD commands to COPY as per compose tutorial
Changed myapp to beyondludus


Had to comment out test for Redis in the docker-entrypoint.sh
Had to modify the gemfile to use tzinfo-data always

Added this line to development.rb to whitelist 172 private network IPs
`config.web_console.whitelisted_ips = '172.16.0.0/12'`
