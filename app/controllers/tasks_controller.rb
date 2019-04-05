class TasksController < ApplicationController

  # 並び替えに使用していいカラムの配列（paramで受け取るもの)
  VALID_SORT_COLUMNS = %w(deadline_at)

  before_action :set_task , only:[:edit ,:update ,:show ,:destroy]

  def index
    @tasks = Task.all
    sort = "created_at DESC"
    if params[:sort]
      sort = "#{params[:sort]} ASC" if VALID_SORT_COLUMNS.include?(params[:sort]) 
    end
    
    #  paramsに設定されているときのみ検索処理
    unless params[:title].nil?
      # binding.pry
      search
    end
    @tasks = @tasks.order(sort)
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
    if @task.update!(task_params)
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

  def search
    title = params[:title]
    status = params[:status]
    @tasks = @tasks.where("title LIKE ? " , "%#{title}%") if title.present?
    @tasks = @tasks.where("status = ? " , status) if status.present?
  end
end
