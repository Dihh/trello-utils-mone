class List < ApplicationRecord
    belongs_to :board, :class_name => "Board", optional: true
    has_and_belongs_to_many :recurrent_cards
end
