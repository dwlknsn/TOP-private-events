class InvitationsController < ApplicationController
  before_action :set_event
  before_action :set_invitation, only: [ :destroy, :accept, :decline ]

  def create
    @invitation = @event.invitations.new(invitation_params)
    if @invitation.save
      redirect_to @event, notice: "Invitation sent successfully."
    else
      flash[:errors] = @invitation.errors.full_messages
      redirect_to @event, alert: "Failed to send invitation."
    end
  end

  def accept
    if @invitation.accept!
      redirect_to @event, notice: "Invitation accepted successfully."
    else
      redirect_to @event, alert: "Failed to accept invitation."
    end
  end

  def decline
    if @invitation.decline!
      redirect_to @event, notice: "Invitation declineed successfully."
    else
      redirect_to @event, alert: "Failed to decline invitation."
    end
  end

  def destroy
    @invitation.destroy
    redirect_to @event, notice: "Invitation deleted successfully."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def invitation_params
    params.require(:invitation).permit(:invitee_id, :expires_at)
  end
end
