class CreateAnalysisDates < ActiveRecord::Migration[7.0]
  def change
    create_table :analysis_dates do |t|
      t.date :date
      t.belongs_to :analysis, null: false, foreign_key: true

      t.timestamps
    end
  end
end
