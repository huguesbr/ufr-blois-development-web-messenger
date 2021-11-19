class ApplicationController < ActionController::API
  class UnauthorizedError < StandardError; end

  # https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from
  rescue_from UnauthorizedError do |exception|
    render json: { error: exception.message }, status: 401
  end

  def current_user
    # https://apidock.com/rails/v4.0.2/ActiveRecord/FinderMethods/find_by
    # find_by(id: ) will return nil if user not found
    # find(id) will raise an error if user not found
    # find user associated with *eventual* session (`&.`)
    @current_user ||= current_session&.user
    raise UnauthorizedError unless @current_user

    @current_user
  end

  def current_session_token
    # grab session token from params
    @current_session_token ||= params[:session_token]
  end

  def current_session
    # find session for session token
    @current_session ||= Session.find_by(token: current_session_token)
  end

  def current_user_id
    @current_user_id ||= current_user.id
  end

  def verify_user_presence
    raise UnauthorizedError unless current_user
  end
end
