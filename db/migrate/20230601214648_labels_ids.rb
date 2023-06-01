class LabelsIds < ActiveRecord::Migration[7.0]
  def up
    add_column :labels, :trello_id, :string
    Label.all.each do |p|
      p.update({trello_id: p.id})
    end
    remove_column :labels, :id
    add_column :labels, :id, :integer, primary_key: true
  end

  def down
    change_column :labels, :id, :string
    Label.all.each do |p|
      p.update({id: p.trello_id})
    end
    remove_column :labels, :trello_id
  end
end
