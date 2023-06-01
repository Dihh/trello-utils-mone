class Rename < ActiveRecord::Migration[7.0]
  def change
    rename_table :analysis_lists, :analyses_lists
    remove_column :analyses_lists, :id
  end
end
