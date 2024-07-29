module Public
  class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group

    def create
      @message = current_user.messages.build(message_params)
      if @message.save
        redirect_to @group, notice: 'メッセージが送信されました。'
      else
        redirect_to @group, alert: 'メッセージの送信に失敗しました。'
      end
    end

    private

    def set_group
      @group = Group.find(params[:group_id])
    end

    def message_params
      params.require(:message).permit(:body, :group_id)
    end
  end
end
