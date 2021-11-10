class MessagesController < ApplicationController
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :verify_user_presence
  before_action :verify_membership
  before_action :verify_authorization, only: [:update, :destroy]

  # GET /chats/1/messages
  def index
    @messages = Message.where(chat_id: params[:chat_id])

    render json: @messages
  end

  # GET /chats/1/messages/1
  def show
    render json: @message
  end

  # POST /chats/1/messages
  def create
    @message = @chat.messages.new(message_params)

    if @message.save
      render json: @message, status: :created, location: chat_message_url(id: @message.id)
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chats/1/messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chats/1/messages/1
  def destroy
    @message.destroy
  end

  private
    def verify_user_presence
      raise UnauthorizedError unless current_user_id
    end

    def verify_authorization
      raise UnauthorizedError if @message.user_id != current_user_id
    end

    def verify_membership
      # https://apidock.com/rails/ActiveRecord/Base/exists%3F/class
      # check that an accepted membership exist for current user / chat
      raise UnauthorizedError unless Membership.exists?(chat: @chat, user_id: current_user_id, status: 'accepted')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = @chat.messages.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      message_params = params.require(:message).permit(:text)
      # force the message creator to be the current user
      message_params.merge(user_id: current_user_id)
    end
end
