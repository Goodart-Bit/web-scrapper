require "net/http"

class Scrapper
  attr_reader :document
  def initialize(url)
    response = Net::HTTP.get(URI(url))
    @document = Nokogiri::HTML(response)
  end

  def text(selector:)
    document.at_css(selector).text
  end

  def present?(selector:)
    document.at_css(selector)
  end
end