class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_host, only: [:search]
  before_action :set_invite, only: %i[update destroy]
  before_action :set_event, only: %i[destroy search]
  
  def index
    @invites = Invitation.includes(event: [:host]).where(attendee: current_user)
    unless current_user == User.find(params[:user_id])
      redirect_back_or_to root_path, notice: "These aren't the invitations you're looking for..."
    end
  end

  def create
    user = User.find(params[:invitation][:attendee_id])
    @invite = user.invitations.build(invite_params)
    if @invite.save && params[:invitation][:request_type] == 'search'
      redirect_to event_invitations_search_path(@invite.event_id), notice: "You have sent an invite to #{@invite.attendee.username}"
    elsif @invite.save && action_name == 'create'
      redirect_to event_path(@invite.event_id), notice: "You have joined the event!"
    else
      redirect_to event_path(@invite.event_id), notice: "You are already attending this event!"
    end
  end

  def update
    @invite.status = 'declined' if params[:commit] == 'Decline'
    @invite.status = 'accepted' if params[:commit] == 'Accept'

    if @invite.update(invite_params)
      redirect_to user_invitations_path(current_user), notice: "You status has been updated."
    else
      redirect_to user_invitations_path(current_user), notice: "You cannot change your status!"
    end
  end

  def destroy
    @invite = Invitation.find(params[:id])
    @invite.destroy
    redirect_to event_path(@event), notice: "You have left the event!"
  end

  def search
    @invite = Invitation.new
    @users = User.not_attending(@event.attendees)
    @users = @users.query(params[:query]) if params[:query]
    if turbo_frame_request?
      render partial: 'search_user', locals: { users: @users }
    else
      render :search
    end
  end

    private
    
    def invite_params
      params.require(:invitation).permit(:attendee_id, :event_id, :status)
    end

    def set_invite
      @invite = Invitation.find(params[:id])
    end

    def set_event
      @event = Event.find(params[:event_id])
    end
end
