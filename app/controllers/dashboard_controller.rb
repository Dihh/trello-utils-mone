class DashboardController < ApplicationController
  @@colors = ["#5c5c8f", "#c690cd", "#fcc468", "#6bd098", "#f17e5d", "#ffc3c8", "#5390a7", "#7ebd5e", "#fdff79", "#d13737"]

  def index
    @analysis = Analysis.find_by({status: "active"})
    if @analysis 
      dates = @analysis .analysis_dates
      datas = @analysis .lists.each_with_index.map do |list, index|
        values = dates.map do |date|
          date.date_values.find{ |date_value| date_value.list == list }
        end
        values = values.reject { |value| value == nil }
        {
          label: list.name,
          data: values.map {|value| value.value},
          borderColor: @@colors[index],
          backgroundColor: @@colors[index],
          fill: true
        }
      end
      @dashboard = {
        labels: dates.map {|date| date.date},
        datast: datas
      }
    else
      @dashboard = {
        labels: [],
        datast: []
      }
    end
  end
end
