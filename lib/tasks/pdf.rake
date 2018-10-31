namespace :pdf do

  desc "Create PDFs"
  task :create do
    dm_active = `docker-machine active`.strip
    if dm_active.present?
      puts "Docker machine active: #{dm_active}.  Please unset env:\n> eval $(docker-machine env -u)"
    else
      pdf_path = File.expand_path("../../../public/pdf", __FILE__)
      Dir.chdir pdf_path
      site = "https://beyondludus.com/"
      puts "Creating PDF from site: #{site}"
      cur_cmd = "docker run --security-opt seccomp:unconfined --rm -v $(pwd):/converted/ arachnysdocker/athenapdf athenapdf --margins none --pagesize Letter #{site} danhealy_resume.pdf"
      puts cur_cmd
      sh cur_cmd
      puts "Creating grayscale version"
      cur_cmd = "gs -sOutputFile=#{pdf_path}/danhealy_resume_bw.pdf -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH #{pdf_path}/danhealy_resume.pdf"
      puts cur_cmd
      sh cur_cmd
    end
  end

end
