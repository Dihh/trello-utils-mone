class CreateRecurrentCardLabels < ActiveRecord::Migration[7.0]
  def change
    create_table :recurrent_card_labels do |t|
      t.string :recurrent_card_id
      t.string :label_id

      t.timestamps
    end
  end
end
