class Page < ApplicationRecord
  belongs_to :last_result, class_name: "Result", optional: true
  has_many :results

  validates :name, presence: true
  validates :url, presence: true
  validates :check_type, presence: true
  validates :selector, presence: true
  validates :match_text, presence: { if: -> { check_type == "text" } }

  def run_check!
    scrapper = Scrapper.new url
    result = case check_type
             when "text" then scrapper.text(selector: selector).downcase == match_text.downcase
             when "exists" then scrapper.present?(selector: selector)
             when "not_exists" then !scrapper.present?(selector: selector)
             end
    results.create(success: result)
    update(last_result: results.last)
  end
end
