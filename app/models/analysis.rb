class Analysis < ApplicationRecord
    belongs_to :board, :class_name => "Board", optional: true
end
