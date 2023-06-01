class BoardsIds < ActiveRecord::Migration[7.0]
  def up
    add_column :boards, :trello_id, :string
    Board.all.each do |p|
      p.update({trello_id: p.id})
    end
    remove_column :boards, :id
    add_column :boards, :id, :integer, primary_key: true
  end

  def down
    change_column :boards, :id, :string
    Board.all.each do |p|
      p.update({id: p.trello_id})
    end
    remove_column :boards, :trello_id
  end
end
