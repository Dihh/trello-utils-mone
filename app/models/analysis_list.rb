class AnalysisList < ApplicationRecord
    belongs_to :analysis, :class_name => "Analysis"
    belongs_to :list, :class_name => "List"
end
