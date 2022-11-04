# == Schema Information
#
# Table name: invitations
#
#  id          :bigint           not null, primary key
#  event_id    :bigint
#  attendee_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Invitation < ApplicationRecord
  
end
