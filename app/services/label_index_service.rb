class LabelIndexService < BaseService
  include BaseServiceImpl

  concerning :LabelsBuilder do
    def labels
      @labels = Label.all
    end
  end

  attr_accessor :chart_data

  def run
    return false if !validate
    return create_chart.present?
  end

  def validate
    @errors = []
    @errors.push('labels is required') unless labels.length > 0
    return @errors.length == 0
  end

  def build_associate
  end

  private 
  def create_chart
    h = {}
    labels.map { |label| h[label.word] = label.used_count }
    self.chart_data = h
    return h
  end
end