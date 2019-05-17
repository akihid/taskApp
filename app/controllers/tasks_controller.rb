class TasksController < ApplicationController
  before_action :set_task , only:[:edit ,:update , :destroy ,:show]
  before_action :set_label_checked_already , only:[:edit ,:update]

  PER_PAGE = 10
  def index
    unless logged_in?
      redirect_to new_session_path 
    else
      define_tasks
    end
  end

  def show
    unless @task.find_read_task(current_user).present?
      @task.create_read_task(current_user)
    end
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
      (params[:task][:label_id] || []).each do |label|
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
    params.require(:task).permit(:title , :content , :deadline_at , :priority , :status, :image)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def set_label_checked_already
    @label_checked_already = @task.task_labels.map{ |label| label.label_id}
  end

  def define_tasks
    if params[:label].present?
      label = Label.find(params[:label])
      @tasks = label.label_used_task
    else
      @tasks = Task.all
    end

    @tasks = @tasks.find_self_task(current_user.id).search_task(params[:title] ,params[:status])
    
    # @tasks - @tasks.order_task(params[:label])
    @tasks = @tasks.order_task(params[:sort])
    @tasks = @tasks.page(params[:page]).per(PER_PAGE)

    get_expired_task
  end

  def task_edit_authority?
    return true if @task.user.user_is_yourself?(current_user)
    flash[:danger] =  '処理をする権限がありません'
    false
  end

  def get_expired_task
    if session[:first_login_flg]
      @expired_tasks = current_user.tasks.search_task_by_limit
      flash.now[:danger] = t('msg.alert_deadline') if @expired_tasks.size > 0
      session.delete(:first_login_flg)
    end
  end
end