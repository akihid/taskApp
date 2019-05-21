class TaskCreateService < BaseService
  include BaseServiceImpl

  concerning :TaskBuilder do
    # attr_reader :
    def task(user)
      @task = user.tasks.build(@attr)
    end
  end

  # concerning :TaskLabelBuilder do
  #   # attr_reader :task_id
  #   def task_label
  #     @task_label |= Task.friendly.find(team_id)
  #   end
  # end

  def run(user)
    return false if !validate
    task(user)
    binding.pry
    return save_task
  end

  private

  def validate
    @errors = []
    return @errors.length == 0
  end

  def save_task
    @task.save
  end
end


# class TeamTransferService < BaseService

#   concerning :TeamBuilder do
#     attr_reader :team_id
#     def team
#       @team ||= Team.friendly.find(team_id)
#     end
#   end

#   concerning :AssignBuilder do
#     attr_reader :id
#   end

#     def assign
#         @assign ||= Assign.find(id)
#     end
#   def transfer
#     return false if !validate

#     build_associate

#     return TeamMailer.team_mail(team.owner.email, team).deliver && team.save
#   end

#   private

#   def build_associate
#     team.owner_id = assign.user_id
#   end

#   def validate
#     @errors = []
#     true
#   end