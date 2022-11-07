class InvitationsController < ApplicationController
  def index
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @invitations = @event.invitations
    else
      @invitations = Invitation.all
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
