class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :authenticate_creator, only: %i[edit update]
  before_action :set_event, only: %i[show edit update destroy]
  
  def index
    @events = Event.all.includes(:host)
  end

  def show
    @invites = @event.invitations.includes(:attendee).order(:status)
    invite = Invitation.find_by(event: @event, attendee: current_user) # find or create by?
    @invite = invite.nil? ? Invitation.new : invite
  end

  def new
    @event = Event.new
    @users = User.where.not(id: current_user.id)
  end

  def create
    @event = current_user.created_events.build(event_params)
    @users = User.where.not(id: current_user.id)
    @event.attendees << current_user
    @event.invitations.last.status = 'accepted'

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

  def update
    @event.invitations.build
    @users = User.all

    params[:event][:attendee_ids] << current_user.id
    if @event.update(event_params)
      redirect_to event_path(@event), notice: "Event updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event removed!"
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def authenticate_creator
      event = Event.find(params[:id])
      unless current_user == event.host
        redirect_to root_path, notice: "Not authorized to edit this event"
      end
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