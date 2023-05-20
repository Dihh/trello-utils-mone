class CreateAnalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :analyses do |t|
      t.string :name
      t.string :board_id
      t.text :pre_planning
      t.text :pos_planning
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
