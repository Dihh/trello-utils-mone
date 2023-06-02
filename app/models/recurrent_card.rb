class RecurrentCard < ApplicationRecord
    belongs_to :board
    has_and_belongs_to_many :labels
    has_and_belongs_to_many :lists
end
