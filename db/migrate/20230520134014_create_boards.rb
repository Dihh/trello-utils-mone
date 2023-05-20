class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards, id: false do |t|
      t.string :id, primary_key: true
      t.string :name
      t.string :user_key

      t.timestamps
    end
  end
end
