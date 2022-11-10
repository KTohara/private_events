# == Schema Information
#
# Table name: invitations
#
#  id          :bigint           not null, primary key
#  status      :integer          default("uncomfirmed"), not null
#  event_id    :bigint
#  attendee_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User'

  enum status: [:accepted, :unconfirmed, :declined]
end
