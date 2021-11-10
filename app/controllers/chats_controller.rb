class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :verify_user_presence, only: [:index, :show, :create]
  before_action :verify_authorization, only: [:update, :destroy]

  # GET /chats
  def index
    @chats = Chat.all

    render json: @chats
  end

  # GET /chats/1
  def show
    render json: @chat
  end

  # POST /chats
  def create
    @chat = Chat.new(chat_params)

    if @chat.save
      render json: @chat, status: :created, location: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1
  def update
    if @chat.update(chat_params)
      render json: @chat
    else
      render json: @chat.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1
  def destroy
    @chat.destroy
  end

  private
    def verify_user_presence
      raise UnauthorizedError unless current_user_id
    end

    def verify_authorization
      raise UnauthorizedError if @chat.user_id != current_user_id
    end

  # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def chat_params
      chat_params = params.require(:chat).permit(:name)
      # force the chat creator to be the current user
      chat_params.merge(user_id: current_user_id)
    end
end
