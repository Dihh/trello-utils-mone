class Board < ApplicationRecord
    belongs_to :user, :class_name => "User", :foreign_key => "user_key", optional: true
    has_many :lists, :class_name => "List"
    has_many :labels, :class_name => "Label"
    has_many :analyses, :class_name => "Analysis"
end
