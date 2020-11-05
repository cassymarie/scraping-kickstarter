# require libraries/modules here
require 'nokogiri'
require 'pry'


def create_project_hash
  # open a file and reads - puts to a variable
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  #loops through each instance
  kickstarter.css("li.project.grid_4").each do |project|
    #sets the title name
    title = project.css("h2.bbcard_name strong a").text
    # creates new hash item with title changed to a symbol
    projects[title.to_sym] = {
      # applies values to attributes
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end

  # return the projects hash
  projects

  # binding.pry
  # "let us pry"

end

create_project_hash