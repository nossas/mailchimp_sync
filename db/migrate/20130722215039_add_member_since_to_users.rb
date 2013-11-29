class AddMemberSinceToUsers < ActiveRecord::Migration
  def up
    add_column :users, :member_since, :datetime
  end

  def down
    remove_column :users, :member_since, :datetime
  end
end
