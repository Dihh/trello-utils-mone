class Analysis < ApplicationRecord
    belongs_to :board, :class_name => "Board", optional: true
    has_and_belongs_to_many :lists
end
