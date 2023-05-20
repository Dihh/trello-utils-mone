class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: false do |t|
      t.string :key, primary_key: true
      t.string :token

      t.timestamps
    end
  end
end
