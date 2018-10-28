namespace :docker do

  desc "Create a new node"
  task :create_node do
    # TBD
  end

  desc "Push docker images to Google Cloud Registry"
  task :push_image do
    hostname              = "gcr.io"
    project_id            = "beyondludus-homepage" # FIXME: Pull this from env?
    image_name            = "github-danhealy-beyondludus-homepage"

    cur_image_name        = "#{hostname}/#{project_id}/#{image_name}"

    cur_tag               = get_cur_tag

    cur_image_tag_name    = "#{cur_image_name}:#{cur_tag}"
    cur_image_latest_name = "#{cur_image_name}:latest"

    puts "Building Docker image #{cur_image_tag_name}"
    sh "docker build -t #{cur_image_tag_name} -f Dockerfile.prod ."

    cur_image_id = `docker images | grep #{project_id}\/#{image_name} | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image #{cur_image_id} #{cur_image_tag_name}"
    sh "docker tag #{cur_image_id} #{cur_image_latest_name}"

    puts "Pushing Docker image #{cur_image_tag_name}"
    sh "docker push #{cur_image_tag_name}"
    sh "docker push #{cur_image_latest_name}"

    puts "Done"
  end

  desc "Deploy to local machine"
  task :up do
    sh "docker-compose down"
    sh "docker-compose build"
    sh "docker-compose run --rm web bundle exec rake db:create db:migrate"
    sh "docker-compose up"
  end

  desc "Deploy to production"
  task :deploy do
    sh "docker stack deploy -c docker-compose.prod.yml --with-registry-auth beyondludus"
  end

  desc "Create/migrate production DB"
  task :migrate do
    sh "docker service create --name beyondludus_maintenance --network beyondludus_backend gcr.io/beyondludus-homepage/github-danhealy-beyondludus-homepage:#{get_cur_tag} bundle exec rake db:create db:migrate"
  end

  # -----

  def get_cur_tag
    return `git rev-parse --short HEAD`.strip
  end

  def get_first_docker_machine
    begin
      m = `docker-machine ls | awk '{print $1}'`.split("\n")[1].strip
    rescue Exception
      m = "defaulttest"
    end
    return m
  end

end
