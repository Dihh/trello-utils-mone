module AnalysesHelper
    def get_analysis_date_value(analysis_date, list)
        analysis_date_value = analysis_date.date_values.find {|date_value| date_value.list == list }
        analysis_date_value.value if analysis_date_value
    end

end
