class ListsIds < ActiveRecord::Migration[7.0]
  def up
    add_column :lists, :trello_id, :string
    List.all.each do |p|
      p.update({trello_id: p.id})
    end
    remove_column :lists, :id
    add_column :lists, :id, :integer, primary_key: true
  end

  def down
    change_column :lists, :id, :string
    List.all.each do |p|
      p.update({id: p.trello_id})
    end
    remove_column :lists, :trello_id
  end
end
