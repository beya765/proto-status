class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.integer :lv, default: 0
      t.integer :str, default: 0
      t.integer :vit, default: 0
      t.integer :dex, default: 0
      t.integer :int, default: 0
      t.integer :spe, default: 0
      t.integer :point, default: 10
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
