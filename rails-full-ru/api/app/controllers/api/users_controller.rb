# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  def show
    @user = User.find(params[:id])
    respond_with @user.as_json
  end

  def index
    @users = User.all
    respond_with @users.as_json
  end
end
