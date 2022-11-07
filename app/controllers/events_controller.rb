class EventsController < ApplicationController
  before_action :set_event, only: %i[show attend unattend]
  before_action :set_current_user_event, only: %i[edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build(event_params)

    if @event.save
      redirect_to event_path(@event), notice: "Event created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: "Event removed!"
  end

  def attend
    if @event.attendees.include?(current_user)
      redirect_to event_path(@event), notice: "You are already attending this event!"
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
      @event = current_user.hosted_events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :location, :date)
    end
end