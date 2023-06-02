class AddBoardForeingKeys < ActiveRecord::Migration[7.0]
  def up
    add_column :boards, :user_id, :integer
    Board.all.each do |board|
      board.user_id = User.find_by({key: board.user_key}).id
      board.save
    end
    add_foreign_key :boards, :users
    remove_column :boards, :user_key, :string
  end

  def down
    add_column :boards, :user_key, :string
    Board.all.each do |board|
      board.user_key = User.find_by({id: board.user_id}).key
      board.save
    end
    remove_column :boards, :user_id
  end
end
