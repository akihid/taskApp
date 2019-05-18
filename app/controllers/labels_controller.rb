class LabelsController < ApplicationController
  def index
    @labels = Label.all
    @labels.create_chart

    used_labels = []
    @labels.each do | label | 
      used_label_count = label.task_labels.count
      used_labels << used_label_count
    end
    label_words = @labels.pluck(:word) 
    @chart_data = [label_words, used_labels].transpose.to_h
  end
end
