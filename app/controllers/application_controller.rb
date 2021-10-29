class ApplicationController < ActionController::API
  def current_user_id
    params[:user_id]&.to_i
  end
end
