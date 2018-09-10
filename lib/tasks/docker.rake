namespace :docker do

  desc "Push docker images to Google Cloud Registry"
  task :push_image do
    hostname              = "gcr.io"
    project_id            = "beyondludus-homepage" # FIXME: Pull this from env?
    image_name            = "beyondludus-homepage-rails"

    cur_image_name        = "#{hostname}/#{project_id}/#{image_name}"

    cur_tag               = `git rev-parse --short HEAD`.strip

    cur_image_tag_name    = "#{cur_image_name}:#{cur_tag}"
    cur_image_latest_name = "#{cur_image_name}:latest"

    puts "Building Docker image #{cur_image_tag_name}"
    sh "docker build -t #{cur_image_tag_name} ."

    cur_image_id = `docker images | grep #{project_id}\/#{image_name} | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image #{cur_image_id} #{cur_image_tag_name}"
    sh "docker tag #{cur_image_id} #{cur_image_latest_name}"

    puts "Pushing Docker image #{cur_image_tag_name}"
    sh "docker push #{cur_image_tag_name}"
    sh "docker push #{cur_image_latest_name}"

    puts "Done"
  end

end
