class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.hstore :data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             

      t.timestamps

    end

    add_index :users, :email, unique: true
    add_index :users, :data
  end

  def down
    drop_table :users
    remove_index :users, :email
    remove_index :users, :data
  end
end
