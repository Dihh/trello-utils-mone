class Board < ApplicationRecord
    belongs_to :user, optional: true
    has_many :lists, :class_name => "List", dependent: :destroy
    has_many :labels, :class_name => "Label", dependent: :destroy
    has_many :analyses, :class_name => "Analysis", dependent: :destroy
    has_many :recurrent_cards, :class_name => "RecurrentCard", dependent: :destroy
end
