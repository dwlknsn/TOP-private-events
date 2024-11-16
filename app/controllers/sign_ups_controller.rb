class SignUpsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event
  before_action :set_sign_up, only: [ :destroy ]

  def new
  end

  def create
    @sign_up = current_user.sign_ups.build(event: @event)

    if @sign_up.save
      redirect_to @sign_up.event, notice: "You have signed up for #{@sign_up.event.name}."
    else
      flash[:error] = @sign_up.errors.full_messages.join(", ")
      render @event, status: :unprocessable_entity
    end
  end

  def destroy
    @sign_up.destroy!
    redirect_to @event, notice: "You have cancelled your sign-up for #{@sign_up.event.name}."
  end

  private

  def set_event
    @event ||= Event.find(params[:event_id])
  end

  def set_sign_up
    @sign_up ||= SignUp.find(params[:id])
  end
end
