class SessionsController < ApplicationController
  before_action :set_session, only: [:destroy]
  before_action :verify_authorization, only: [:destroy]

  # POST /sessions
  def create
    user = User.find_by(user_credentials)
    raise UnauthorizedError.new('Invalid credentials') unless user

    @session = Session.new(user: user)

    if @session.save
      render json: @session, status: :created, location: @session
    else
      render json: @session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
  end

  private
    def user_credentials
      params[:user].permit(:name, :password)
    end

    def verify_authorization
      raise UnauthorizedError unless @session.user_id == current_user.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end
end
