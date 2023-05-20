class List < ApplicationRecord
    belongs_to :board, :class_name => "Board", optional: true
end
