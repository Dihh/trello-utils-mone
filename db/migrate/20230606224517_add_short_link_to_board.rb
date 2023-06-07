class AddShortLinkToBoard < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :short_link, :string
  end
end
