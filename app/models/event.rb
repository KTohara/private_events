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
  belongs_to :host, foreign_key: :creator_id, class_name: 'User'
  has_many :invitations
  has_many :attendees, through: :invitations

  def formatted_date
    date.strftime("%a. %b %d %Y")
  end
end
