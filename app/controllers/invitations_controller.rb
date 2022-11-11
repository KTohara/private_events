class InvitationsController < ApplicationController
  before_action :authenticate_user!, only: %i[index]
  before_action :set_invite, only: %i[update destroy]
  
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
    @invite.status = 'declined' if declined?
    @invite.status = 'accepted' if accepted?

    if @invite.update(invite_params)
      redirect_to user_invitations_path(current_user), notice: "You status has been updated."
    else
      redirect_to user_invitations_path(current_user), notice: "You cannot change your status!"
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @invite = Invitation.find(params[:id])
    @invite.destroy
    redirect_to event_path(@event), notice: "You have left the event!"
  end

  def search
    if params[:query]
      @users = User.where('UPPER(username) LIKE ?', "#{params[:query].upcase}%")
    else
      @users = User.all
    end
  end

  private
    def invite_params
      params.require(:invitation).permit(:attendee_id, :event_id, :status)
    end

    def set_invite
      @invite = Invitation.find(params[:id])
    end

    def declined?
      params[:commit] == 'Decline'
    end

    def accepted?
      params[:commit] == 'Accept'
    end
end
