class UsersController < ApplicationController
  before_action :set_user
  def show
    @events = {
      hosted: @user.hosted_events,
      attended: @user.attended_events
    }
    @invitations = @user.invitations.open
  end

  private

  def set_user
    @user ||= User.find(params[:id])
  end
end
