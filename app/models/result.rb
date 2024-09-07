class Result < ApplicationRecord
  belongs_to :page

  def notify
    UserMailer.with(result: self).success.deliver_later
  end
end
