class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [ :show, :edit, :update, :destroy ]
  before_action :authorise_user!, only: [ :edit, :update, :destroy ]

  respond_to :html

  def index
    @events = {
      hosted: Event.hosted_by(current_user),
      attended: Event.attended_by(current_user),
      attendable: Event.attendable_by(current_user)
    }
    respond_with(@events)
  end

  def show
    @sign_up = @event.sign_ups.where(attendee_id: current_user.id).take
    respond_with(@event, @sign_up)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = current_user.hosted_events.build(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy!
    respond_with(@event)
  end

  private

  def set_event
    @event ||= Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:datetime, :location, :name, :description)
  end

  def authorise_user!
    return if @event.owned_by?(current_user)
    flash[:alert] = "Only the event owner can perform that action."
    redirect_to(root_path)
  end
end
