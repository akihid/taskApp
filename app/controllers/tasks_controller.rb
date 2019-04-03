class TasksController < ApplicationController

  before_action :set_task , only:[:edit ,:update ,:show]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    if paragitms[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
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

  def confirm
    @task = Task.new(task_params)
  end



  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = "編集完了"
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  private

  def task_params
    params.require(:task).permit(:title , :content , :deadline_at , :priority , :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
