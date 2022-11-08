class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_event, only: %i[]
  
  def index
    @invites = Invitation.includes(event: [:host]).where(attendee: current_user)
  end

  def create
    if @event.attendees.include?(current_user)
      redirect_to event_path(@event), notice: "You are already attending this event!"
    # elseif
    #   @event.private && @event.invitations.exclude?(current_user)
    #   redirect_to event_path(@event), notice: "You have not been invited"
    else
      @event.attendees << current_user
      redirect_to event_path(@event), notice: "You have joined the event!"
    end
  end

  def destroy
    @event.attendees.destroy(current_user)
    redirect_to event_path(@event), notice: "You have left the event!"
  end
end
