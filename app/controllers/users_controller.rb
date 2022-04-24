# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.includes(:wallet).all
  end
end
