class Map < ActiveRecord::Base
  @@default_name = "bekkmap"
  
  def to_gmap
    gm = GMap.new(@@default_name)
    gm.control_init(:large_map => true, :map_type => true)
    gm.center_zoom_init([lat, lng], zoom)
    gm
  end
end
