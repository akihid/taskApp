class TaskCreateService < BaseService
  include BaseServiceImpl
  include SessionsHelper

  concerning :TaskBuilder do
    # attr_reader :
    def task
      @task ||= Task.new(@attr)
    end

    # def task=(attributes)
    #   @task = Task.new(attributes)
    # end
  end

  concerning :LabelsBuilder do
    attr_reader :label_ids
    def labels
      if label_ids.nil?
        @labels ||= []
      else
        @labels ||= label_ids.map { |id| Label.find(id) }
      end
    end
  end

  def run()
    return false if !validate
    build_associate
    if task.save
      return true
    else
      @errors.push(task.errors.full_messages.first)
      return false
    end
  end

  private

  def validate
    @errors = []
    @errors.push('login is required') unless User.current_user
    return @errors.length == 0
  end

  def build_associate
    task.labels = labels if labels.length > 0
    task.user = User.current_user
    task.user_id = User.current_user.id
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