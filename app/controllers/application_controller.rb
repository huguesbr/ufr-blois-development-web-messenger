class ApplicationController < ActionController::API
  class UnauthorizedError < StandardError; end

  # https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from
  rescue_from UnauthorizedError do |exception|
    render nothing: true, status: 401
  end

  def current_user
    # https://apidock.com/rails/v4.0.2/ActiveRecord/FinderMethods/find_by
    # find_by(id: ) will return nil if user not found
    # find(id) will raise an error if user not found
    @current_user ||= User.find_by(id: current_user_id)
  end

  def current_user_id
    @current_user_id ||= params[:current_user_id]&.to_i
  end

  def verify_user_presence
    raise UnauthorizedError unless current_user
  end
end
