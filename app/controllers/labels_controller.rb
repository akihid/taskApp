class LabelsController < ApplicationController
  def index
    repository = LabelIndexService.new
    if repository.run
      @labels = repository.labels
      @chart_data = repository.chart_data
    else
      # notice: repository.errors.first
    end
  end
end
