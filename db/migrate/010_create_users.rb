class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :bekk_id,                   :integer, :null => true
      
    end
  end

  def self.down
    drop_table "users"
  end
end
