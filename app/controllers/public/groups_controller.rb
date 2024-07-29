module Public
  class GroupsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_group, only: [:show, :edit, :update, :destroy, :join, :leave]

    def index
      @groups = Group.all
    end

    def show
      @message = Message.new
    end

    def new
      @group = current_user.groups.build
    end

    def create
      @group = current_user.groups.build(group_params)
      if @group.save
        redirect_to @group, notice: 'グループが作成されました。'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @group.update(group_params)
        redirect_to @group, notice: 'グループが更新されました。'
      else
        render :edit
      end
    end

    def destroy
      @group.destroy
      redirect_to groups_url, notice: 'グループが削除されました。'
    end

    def join
      unless @group.users.include?(current_user)
        @group.users << current_user
        redirect_to @group, notice: 'グループに参加しました。'
      else
        redirect_to @group, alert: '既にグループに参加しています。'
      end
    end

    def leave
      if @group.users.include?(current_user)
        @group.users.delete(current_user)
        redirect_to @group, notice: 'グループから退出しました。'
      else
        redirect_to @group, alert: 'グループに参加していません。'
      end
    end

    private

    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name, :description)
    end
  end
end
