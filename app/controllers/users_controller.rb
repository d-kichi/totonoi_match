class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @reviews = @user.reviews.includes(:sauna).order(created_at: :desc)
  end
end
