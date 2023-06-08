class CreateDownloadedTables < ActiveRecord::Migration[6.1]
  def change
    create_table :downloadedbooks do |t|
      t.string :title
      t.integer :book_id
    end
  end
end
