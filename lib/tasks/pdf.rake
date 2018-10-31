namespace :docker do

  desc "Create PDFs"
  task :create do
    Dir.chdir File.expand_path("../../public/pdf", __FILE__)
    site = "https://beyondludus.com/"
    puts "Creating PDF from site: #{site}"
    sh "docker run --security-opt seccomp:unconfined --rm -v $(pwd):/converted/ arachnysdocker/athenapdf athenapdf --margins none --pagesize Letter #{site} danhealy_resume.pdf"
    puts "Creating grayscale version"
    sh "gs -sOutputFile=danhealy_resume_bw.pdf -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH danhealy_resume.pdf"
  end

end
