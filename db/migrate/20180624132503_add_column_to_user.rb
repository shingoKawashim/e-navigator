class AddColumnToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :integer, default: 0, null: false, comment: "タイプ(0=>生徒,1=>面接官)"
  end
end
