class LabelsController < ApplicationController
  def index
    @labels = Label.all
    @labels.create_chart
  end
end
