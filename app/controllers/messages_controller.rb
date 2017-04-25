class MessagesController < ApplicationController

  def index
    @message = Message.new
    respond_to do |format|
      format.html do
        @messages = Message.all
      end
      format.js do
        @messages = check_new_messages
      end
    end
    @last_id = @messages&.last&.id || 0
  end

  def create
    Message.create message_params
  end

  private
  def check_new_messages
    10.times do
      @new_messages = Message.after_messages params[:last_id].to_i
      return  @new_messages if @new_messages.any?
      sleep 5
    end
    nil
  end

  def message_params
    params.require(:message).permit :name, :content
  end
end
