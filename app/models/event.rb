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
#  private     :boolean          default(FALSE)
#
class Event < ApplicationRecord
  belongs_to :host, foreign_key: :creator_id, class_name: 'User'
  has_many :invitations, dependent: :destroy
  has_many :attendees, through: :invitations, source: :attendee

  validates :title, :location, :start_date, :end_date, :start_time, :end_time, presence: true

  scope :past, -> { where("end_date < ?", Date.today).order(end_date: :desc) }
  scope :future, -> { where('end_date > ?', Date.today).order(:end_date) }
end
