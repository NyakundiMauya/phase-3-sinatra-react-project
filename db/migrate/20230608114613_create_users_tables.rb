class CreateUsersTables < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :user_id
      t.string :email
      t.string :password
    end
  end
end
