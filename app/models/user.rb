# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  username               :string           not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_events,
    foreign_key: :creator_id,
    class_name: 'Event',
    dependent: :destroy,
    inverse_of: :host
  has_many :invitations, foreign_key: :attendee_id, dependent: :destroy, inverse_of: :attendee
  has_many :attending_events, through: :invitations, source: :event

  validates :username, length: { in: 3..15 }

  scope :new_attendees, -> event { joins(:invitations)
    .where(invitations: { id: event.id })
    .where.not(invitations: { status: :accepted }) }
  scope :not_attending, -> attendees { where.not(id: attendees) }
  scope :query, -> search { where('UPPER(username) LIKE ?', "#{search.upcase}%") }
end