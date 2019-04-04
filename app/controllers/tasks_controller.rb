class TasksController < ApplicationController

  before_action :set_task , only:[:edit ,:update ,:show ,:destroy]

  def index
    @tasks = Task.all.order("created_at DESC")
  end

  def show
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = t('msg.new_complete')
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = t('msg.update_complete')
      redirect_to tasks_path
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:notice] = t('msg.destroy_complete')
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title , :content , :deadline_at , :priority , :status)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
