namespace :k8s do

  desc "Create Kubernetes yml files from env vars and templates"
  task :generate_config do
    @missing_env_vars = []
    # env_vars = {
    #   PROJECT_ID:       nil,
    #   BUCKET_NAME:      nil,
    #   REPO_NAME:        nil,
    #   COMMIT_SHA:       nil,
    #   CONNECTION_NAME:  nil,
    #   DNS_WEBSITE:      nil,
    #   DNS_ASSETS:       nil,
    #   EMAIL:            nil,
    #   SECRET_KEY_BASE:  nil,
    #   DB_DBNAME:        nil,
    # }
    # @missing_vars = []
    # env_vars.keys.each do |v|
    #   val = ENV[v.to_s.upcase]
    #   unless val
    #     puts "Missing required environment variable: #{v.to_s.upcase}"
    #     @missing_vars << v
    #   end
    #   env_vars[v] = val
    # end
    # if @missing_vars.any?
    #   #next
    # end
    # ap env_vars

    # Parse all of the yml files in the /deploy/templates dir using Haml to
    # substitute env vars, and then output the result inside the /deploy/ dir
    files = Dir.glob("#{Rails.root}/deploy/templates/**/*.{yml,yaml}")
    files.each do |f|
      puts "Parsing #{f}"
      erb = ERB.new(open(f).read).result
      # puts erb
      new_file = YAML.load(erb)
      new_path = f.gsub("/templates", '')
      new_dir  = File.dirname(new_path)
      unless File.directory?(new_dir)
        FileUtils.mkdir_p(new_dir)
      end
      puts "Writing #{new_path}"
      File.write(new_path, new_file.to_yaml)
    end
    puts "Done."
    if @missing_env_vars.any?
      puts "Environment variables used but not set: #{@missing_env_vars}"
    end
  end

  # Wrapper around accessing ENV to keep track of missing variables
  def fetch_env_var(name)
    found = ENV[name.to_s]
    unless found
      puts "Used environment variable which was not set: #{name.to_s}"
      @missing_env_vars |= [name.to_s]
    end
    return found
  end
end
