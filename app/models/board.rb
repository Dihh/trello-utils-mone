class Board < ApplicationRecord
    belongs_to :user, :class_name => "User", :foreign_key => "user_key"
end
