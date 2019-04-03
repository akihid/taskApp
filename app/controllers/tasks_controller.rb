class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "新規登録完了"
      redirect_to tasks_path
    else
      render 'new'
    end
  end


  def edit
  end

  def update
  end

  private

  def task_params
    params.require(:task).permit(:title , :contetnt , :deadline_at , :priority , :status)
  end
end
