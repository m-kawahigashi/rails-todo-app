class TasksController < ApplicationController
    before_action :set_task, only: [:edit, :update, :destroy]
    before_action :set_task_list, only: [:index, :create, :destroy]

    def index
        # before_actionでset_task_list呼び出し
    end

    def create
        # before_actionでset_task_list呼び出し
        begin
            @task = Task.new(task_params)
            @task.save!
        rescue ActiveRecord::RecordInvalid => e
            p e
            redirect_to tasks_path, flash: { error: e.message} and return
        end
        redirect_to tasks_path and return
    end

    def edit
    end

    def update
        begin
            @current_task.update!(task_params)
        rescue ActiveRecord::RecordInvalid => e
            p e
            redirect_to edit_task_path(@current_task.id), flash: { error: e.message} and return
        end
        redirect_to tasks_path and return
    end

    def destroy
        # before_actionでset_task_list呼び出し
        begin
            @current_task.destroy! if @current_task.user_id == current_user.id
        rescue ActiveRecord::RecordInvalid => e
            p e
            redirect_to tasks_path, flash: { error: e.message} and return
        end
        redirect_to tasks_path and return
    end

    private
    def task_params
        params.require(:task).permit(:task, :user_id).merge(user_id: current_user.id)
    end

    def set_task
        @current_task = Task.find(params[:id])
    end

    def set_task_list
        @tasks = Task.select(:id, :task, :user_id).where(user_id: current_user.id)
        @input_task = Task.new
        @no_tasks_message = "タスクが登録されていません。" if @tasks.empty?
    end
end
