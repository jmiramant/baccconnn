class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls  do |t|
      t.string :url
      t.string :baconurl
      t.integer :click_counter, :default => 0
      t.references  :user
      t.timestamps
    end
  end
end
