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
  belongs_to :creator, foreign_key: :creator_id, class_name: 'User'
  has_many :invitations
  has_many :attendees, foreign_key: :attendee_id, class_name: 'Invitation'
end
