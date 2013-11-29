class CreateDatabaseSync < ActiveRecord::Migration
  def up
    create_table :syncs do |t|
      t.string :platform
      t.datetime :synced_at

      t.timestamps

    end
    add_index :syncs, :platform 
  end

  def down
  end
end
