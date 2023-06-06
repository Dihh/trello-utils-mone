class CreateDateValues < ActiveRecord::Migration[7.0]
  def change
    create_table :date_values do |t|
      t.belongs_to :analysis_date, null: false, foreign_key: true
      t.belongs_to :list, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
