class RecurrentCardLabel < ApplicationRecord
    belongs_to :recurrent_card, :class_name => "RecurrentCard"
    belongs_to :label, :class_name => "Label"
end
