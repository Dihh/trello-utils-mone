class AnalysisDate < ApplicationRecord
  belongs_to :analysis
  has_many :date_values, dependent: :destroy
end
