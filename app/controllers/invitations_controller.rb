class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  
  def index
    @invites = Invitation.includes(event: [:host]).where(attendee: current_user)
  end

  def create
    @invite = current_user.invitations.build(invite_params)
    if @invite.save
      redirect_to event_path(@invite), notice: "You have joined the event!"
    else
      redirect_to event_path(@invite), notice: "You are already attending this event!"
    end
  end

  def update
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
    @event = Event.find(params[:event_id])
    @invite = Invitation.find(params[:id])
    @invite.destroy
    redirect_to event_path(@event), notice: "You have left the event!"
  end

  private

  def invite_params
    params.require(:invitation).permit(:attendee_id, :event_id)
  end
end
