class Analysis < ApplicationRecord
    belongs_to :board, optional: true
    has_and_belongs_to_many :lists
end
