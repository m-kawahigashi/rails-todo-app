class TasksController < ApplicationController
    before_action :set_task, only: [:edit, :update, :destroy]

    def index
        p "川東 aaa"
        @tasks = Task.select(:task, :user_id).where(user_id: current_user.id)
        @input_task = Task.new
        # binding.pry

        @no_tasks_message = "タスクが登録されていません。" if @tasks.empty?
    end

    def create
        # binding.pry
        @task = Task.new(task_params)

        begin
            @task.save!
        rescue => e
            # binding.pry
            @err_message = "タスクの登録に失敗しました。"
        end
        redirect_to root_path
    end

    private
    def task_params
        params.require(:task).permit(:task, :user_id).merge(user_id: current_user.id)
    end

    def set_task
        @current_task = Task.find(params[:id])
    end
end
