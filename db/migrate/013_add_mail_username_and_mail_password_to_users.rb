class AddMailUsernameAndMailPasswordToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :mail_username, :string
    add_column :users, :mail_password, :string
  end

  def self.down
    remove_column :users, :mail_username
    remove_column :users, :mail_password    
  end
end
