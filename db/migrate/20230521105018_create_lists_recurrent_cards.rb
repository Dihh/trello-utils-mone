class CreateListsRecurrentCards < ActiveRecord::Migration[7.0]
  def change
    create_table :lists_recurrent_cards do |t|
      t.string :recurrent_card_id, null: false
      t.string :list_id, null: false

      t.timestamps
    end
  end
end
