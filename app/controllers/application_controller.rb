class ApplicationController < ActionController::API
  class UnauthorizedError < StandardError; end

  # https://apidock.com/rails/ActiveSupport/Rescuable/ClassMethods/rescue_from
  rescue_from UnauthorizedError do |exception|
    render nothing: true, status: 401
  end

  def current_user
    @current_user ||= User.find(current_user_id)
  end

  def current_user_id
    @current_user_id ||= params[:current_user_id]&.to_i
  end
end
