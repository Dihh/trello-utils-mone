class TablesTrelloIds < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :key_, :string
    User.all.each do |p|
      p.update({key_: p.key})
    end
    remove_column :users, :key
    add_column :users, :id, :integer, primary_key: true
    rename_column :users, :key_, :key
  end

  def down
    change_column :users, :id, :string
    User.all.each do |p|
      p.update({id: p.key})
    end
    remove_column :users, :id
    change_column :users, :key, :string, primary_key: true
  end
end
