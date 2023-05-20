class RecurrentCard < ApplicationRecord
    belongs_to :board, :class_name => "Board"
    has_many :labels, :class_name => "RecurrentCardLabel", dependent: :delete_all

    def labelss 
        self.labels.map {|label| label.label}
    end
end
