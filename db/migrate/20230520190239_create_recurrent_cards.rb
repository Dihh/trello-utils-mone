class CreateRecurrentCards < ActiveRecord::Migration[7.0]
  def change
    create_table :recurrent_cards do |t|
      t.string :name
      t.string :board_id

      t.timestamps
    end
  end
end
