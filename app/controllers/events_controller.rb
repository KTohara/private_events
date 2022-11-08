class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit attend unattend]
  before_action :set_current_user_event, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  
  def index
    @events = Event.all.includes(:host)
  end

  def show
    @invites = @event.invitations.includes(:attendee).order(:status)
    invite = Invitation.find_by(attendee: current_user)
    @invite = invite.nil? ? Invitation.new : invite
  end

  def new
    @event = Event.new
    @event.invitations.build
    @users = User.all
  end

  def create
    @event = current_user.created_events.build(event_params)
    @event.attendees << current_user
    current_user.invitations.last.status = "accepted"

    if @event.save
      redirect_to event_path(@event), notice: "Event created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event.invitations.build
    @users = User.all
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event removed!"
  end

  def attend
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

  def unattend
    @event.attendees.destroy(current_user)
    redirect_to event_path(@event), notice: "You have left the event!"
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def set_current_user_event
      @event = current_user.created_events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(
        :title,
        :description,
        :location,
        :start_date,
        :end_date,
        :start_time,
        :end_time,
        :private,
        attendee_ids: []
      )
    end
end