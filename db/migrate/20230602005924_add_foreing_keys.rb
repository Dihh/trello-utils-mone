class AddForeingKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :analyses, :boards
    add_foreign_key :analyses_lists, :analyses
    add_foreign_key :analyses_lists, :lists
    add_foreign_key :lists, :boards
    add_foreign_key :labels, :boards
    add_foreign_key :recurrent_cards, :boards
    add_foreign_key :labels_recurrent_cards, :recurrent_cards
    add_foreign_key :labels_recurrent_cards, :labels
    add_foreign_key :lists_recurrent_cards, :recurrent_cards
    add_foreign_key :lists_recurrent_cards, :lists
  end
end
