class User < ApplicationRecord
    has_many :boards, dependent: :destroy
    validates :key, presence: true
end
