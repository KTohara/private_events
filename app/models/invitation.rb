# == Schema Information
#
# Table name: invitations
#
#  id          :bigint           not null, primary key
#  status      :integer          default("no_response"), not null
#  event_id    :bigint
#  attendee_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Invitation < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: 'User'

  enum status: [:no_response, :accepted, :declined]
end
