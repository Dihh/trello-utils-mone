class User < ApplicationRecord
    has_many :boards, :class_name => "Board", :foreign_key => "user_key", dependent: :destroy
end
