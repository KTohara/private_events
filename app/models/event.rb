# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :string
#  location    :string
#  date        :date
#  creator_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
  include ActionView::Helpers
  belongs_to :host, foreign_key: :creator_id, class_name: 'User'
  has_many :invitations
  has_many :attendees, through: :invitations
  
  scope :past, -> { where("date < ?", Date.today).order(date: :desc) }
  scope :future, -> { where('date > ?', Date.today).order(:date) }

  def formatted_date
    date.strftime("%a. %b %-d %Y")
  end

  def time_to_event
    current = Date.today
    return "Starts in: #{distance_of_time_in_words(current, date)}" if date > current
    "Event ended: #{time_ago_in_words(date)} ago"
  end
end
