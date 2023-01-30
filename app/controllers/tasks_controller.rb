class TasksController < ApplicationController
    before_action :set_task, only: [:edit, :update, :destroy]

    def index
        @tasks = Task.select(:id, :task, :user_id).where(user_id: current_user.id)
        @input_task = Task.new
        @no_tasks_message = "タスクが登録されていません。" if @tasks.empty?
    end

    def create
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
            redirect_to edit_task_path(@current_task.id), flash: { error: e.message } and return
        end
        redirect_to tasks_path and return
    end

    def destroy
        begin
            @current_task.destroy! if @current_task.user_id == current_user.id
        rescue ActiveRecord::RecordInvalid => e
            p e
            redirect_to tasks_path, flash: { error: e.message } and return
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
end
