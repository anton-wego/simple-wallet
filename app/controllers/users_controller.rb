class UsersController < ApplicationController

  def index
    @users = User.includes(:wallet).all
  end
end
