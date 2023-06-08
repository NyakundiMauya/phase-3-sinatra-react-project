class CreateAdminsTables < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.string :name
      t.integer :admin_id
      t.string :email
      t.string :password
    end  
  end
end
