class DateValue < ApplicationRecord
  belongs_to :analysis_date
  belongs_to :list
end
