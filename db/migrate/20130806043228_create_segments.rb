class CreateSegments < ActiveRecord::Migration
  def up
    create_table :segments, force: true do |t|
      t.text :name  
      t.integer :campaign_id
      t.integer :seg_id
      t.timestamps
    end
  end

  def down
    drop_table :segments
  end
end
