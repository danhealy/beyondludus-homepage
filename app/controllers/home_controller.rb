class HomeController < ApplicationController
  def index
    @title = "Dan Healy's Resume"
    @random_number = rand(50)
  end
end
