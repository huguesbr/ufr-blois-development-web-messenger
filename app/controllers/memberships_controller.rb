class MembershipsController < ApplicationController
  before_action :set_membership, only: [:show, :update, :destroy]
  before_action :verify_user_presence, only: [:create, :update, :destroy]
  before_action :verify_chat_owner_authorization, only: [:update]
  before_action :verify_membership_owner_authorization, only: [:destroy]

  # GET /memberships
  def index
    @memberships = Membership.all

    render json: @memberships
  end

  # GET /memberships/1
  def show
    render json: @membership
  end

  # POST /memberships
  def create
    # https://apidock.com/rails/v4.0.2/ActiveRecord/Relation/find_or_initialize_by
    # attempt to find the membership
    # return the membership if found
    # return a new membership otherwise
    @membership = Membership.find_or_initialize_by(membership_create_params)

    if @membership.save
      render json: @membership, status: :created, location: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memberships/1
  def update
    if @membership.update(membership_update_params)
      render json: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  # DELETE /memberships/1
  def destroy
    @membership.destroy
  end

  private
    def verify_chat_owner_authorization
      raise UnauthorizedError unless @membership.chat.user_id == current_user.id
    end

    def verify_membership_owner_authorization
      raise UnauthorizedError unless @membership.user_id == current_user.id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def membership_create_params
      membership_create_params = params.require(:membership).permit(:chat_id)
      # force the membership creator to be the current user
      membership_create_params.merge(user_id: current_user.id)
    end

    # Only allow a trusted parameter "white list" through.
    def membership_update_params
      params.require(:membership).permit(:status)
    end
end
