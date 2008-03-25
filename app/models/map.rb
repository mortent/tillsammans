class Map < ActiveRecord::Base
  @@default_name = "map"
  @@default_opts = { :small_map => true, :map_type => true, :overview_map => true, :scale => true }
  
  def to_gmap(opts={})  
    opts.merge!(@@default_opts)
    
    gm = GMap.new(@@default_name)
    gm.control_init(opts)
    gm.set_map_type_init(GMapType::G_HYBRID_MAP)
    gm.center_zoom_init([lat, lng], zoom)
    gm
  end
end
