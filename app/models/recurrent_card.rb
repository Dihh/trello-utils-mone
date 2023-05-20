class RecurrentCard < ApplicationRecord
    belongs_to :board, :class_name => "Board"
end
