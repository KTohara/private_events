class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
  def index
    @invites = Invitation.where(attendee: current_user)
  end
end
