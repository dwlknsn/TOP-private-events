class SignUpsController < ApplicationController
  before_action :set_event

  def new
  end

  def create
    @sign_up = @user.sign_ups.build(event: @event)

    if @sign_up.save
      redirect_to @sign_up.event, notice: "You have signed up for #{@sign_up.event.name}."
    else
      flash[:error] = @sign_up.errors.full_messages.join(", ")
      render @event, status: :unprocessable_entity
    end
  end

  private
  def set_event
    @event ||= Event.find(params[:event_id])
  end
end
