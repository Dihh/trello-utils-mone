class Board < ApplicationRecord
    belongs_to :user, :class_name => "User", :foreign_key => "user_key", optional: true
    has_many :lists, :class_name => "List"
end
