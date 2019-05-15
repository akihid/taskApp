class TasksController < ApplicationController

  # 並び替えに使用していいカラムの配列（paramで受け取るもの)
  VALID_SORT_COLUMNS = %w(deadline_at , priority)

  before_action :set_task , only:[:edit ,:update , :destroy ,:show]
  before_action :set_label_checked_already , only:[:edit ,:update]

  def index
    unless logged_in?
      redirect_to new_session_path 
    else
      define_tasks
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
      if params[:task][:label_id].present?
        params[:task][:label_id].each do |label|
          @task.task_labels.create(task_id:@task.id , label_id:label.to_i)
        end
      end
      flash[:success] = t('msg.new_complete')
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def edit
    redirect_to tasks_path unless task_edit_authority?
  end

  def update
    if @task.update(task_params)
      @task.task_labels.destroy_all
      params[:task][:label_id].each do |label|
        @task.task_labels.create(task_id:@task.id , label_id:label.to_i)
      end
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

  def set_label_checked_already
    @label_checked_already = @task.task_labels.map{ |label| label.label_id}
  end

  def define_tasks
    sort = define_sort

    if params[:label].present?
      label = Label.find(params[:label])
      @tasks = label.label_used_task
    else
      @tasks = Task.all
    end

    @tasks = @tasks.find_self_task(current_user.id).search_task(params[:title] ,params[:status])
    @tasks = @tasks.order(sort)
    @tasks = @tasks.page(params[:page]).per(10)
  end

  def define_sort
    sort = "created_at DESC"
    if params[:sort]
      sort = "#{params[:sort]} ASC" if VALID_SORT_COLUMNS.include?(params[:sort]) 
    end
    sort
  end

  def task_edit_authority?
    return true if @task.user.user_is_yourself?(current_user)
    flash[:danger] =  '処理をする権限がありません'
    false
  end
end