class ChangeRecurrentCardLabels < ActiveRecord::Migration[7.0]
  def change
    rename_table :recurrent_card_labels, :labels_recurrent_cards
    remove_column :labels_recurrent_cards, :id
    remove_column :lists_recurrent_cards, :id
  end
end
