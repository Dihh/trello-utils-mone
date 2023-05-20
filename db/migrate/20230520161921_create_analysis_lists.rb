class CreateAnalysisLists < ActiveRecord::Migration[7.0]
  def change
    create_table :analysis_lists do |t|
      t.integer :analysis_id
      t.string :list_id

      t.timestamps
    end
  end
end
