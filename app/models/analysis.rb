class Analysis < ApplicationRecord
    belongs_to :board, :class_name => "Board", optional: true
    has_many :lists, :class_name => "AnalysisList", dependent: :delete_all

    def listss 
        self.lists.map {|list| list.list}
    end
end
