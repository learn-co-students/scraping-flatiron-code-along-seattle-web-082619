require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end


  def get_page
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
    Nokogiri::HTML(html)
  end

  def get_courses
    doc = self.get_page
    doc.css(".post")
  end

  def make_courses
    self.get_courses.each do |course|
      title = course.css("h2").text
      schedule = course.css(".date").text
      description = course.css("p").text
      new_course = Course.new
      new_course.title = title
      new_course.schedule = schedule
      new_course.description = description
    end
  end

end
