class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    # 2重送信対策(一意性):https://railstutorial.jp/chapters/modeling_users?version=5.1#aside-database_indices
    add_index :users, :email, unique: true
  end
end
