class Map < ActiveRecord::Base
  @@default_name = "map"
  
  def to_gmap
    gm = GMap.new(@@default_name)
    gm.control_init(:small_map => true, :map_type => true, :overview_map => true, :scale => true)
    gm.set_map_type_init(GMapType::G_HYBRID_MAP)
    gm.center_zoom_init([lat, lng], zoom)
    gm
  end
end
