class Analysis < ApplicationRecord
    belongs_to :board, optional: true
    has_and_belongs_to_many :lists
    has_many :analysis_dates, dependent: :destroy
end
