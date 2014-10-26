class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.timestamps
    end
    add_index :users, :email, name: :email_idx, unique: true
  end
end
