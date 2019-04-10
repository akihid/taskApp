class TasksController < ApplicationController

  # 並び替えに使用していいカラムの配列（paramで受け取るもの)
  VALID_SORT_COLUMNS = %w(deadline_at , priority)

  before_action :set_task , only:[:edit ,:update ,:show ,:destroy]

  def index
    unless logged_in?
      redirect_to new_session_path 
    else
      sort = "created_at DESC"
      if params[:sort]
        sort = "#{params[:sort]} ASC" if VALID_SORT_COLUMNS.include?(params[:sort]) 
      end
      #  paramsに設定されているときのみ検索処理
      @tasks = Task.find_self_task(current_user.id).search_task(params[:title] ,params[:status])

      @tasks = @tasks.order(sort)
      @tasks = @tasks.page(params[:page]).per(10)
    end
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
    @task = current_user.tasks.build(task_params)
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
    flash[:danger] = t('msg.destroy_complete')
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
