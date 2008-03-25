class AddDefaultClientData < ActiveRecord::Migration
  def self.up
    c = Client.create(:name => 'NAV NDU', :description => 'NAV Drift og Utvikling', :url => 'http://www.nav.no/', :image_url => '' )
    c.location = Location.find_by_name("NAV NDU")
    c.save!    
  end

  def self.down
    Client.delete_all
  end
end
