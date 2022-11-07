# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  title       :string           not null
#  description :string
#  location    :string           not null
#  start_date  :date             not null
#  end_date    :date             not null
#  start_time  :time             not null
#  end_time    :time             not null
#  creator_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Event < ApplicationRecord
  include ActionView::Helpers
  
  belongs_to :host, foreign_key: :creator_id, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  validates :title, :location, :start_date, :end_date, :start_time, :end_time, presence: true

  scope :past, -> { where("end_date < ?", Date.today).order(end_date: :desc) }
  scope :future, -> { where('end_date > ?', Date.today).order(:end_date) }

  def formatted_date(date, time)
    date.strftime("%a. %b %-d %Y") + time.strftime(" at %l:%M %P")
  end

  def time_to_event
    current = Date.today
    return "Starts in: #{distance_of_time_in_words(current, start_date)}" if start_date > current
    "Event ended: #{time_ago_in_words(start_date)} ago"
  end
end
