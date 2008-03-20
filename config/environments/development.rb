# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_extensions         = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

GeoKit::Geocoders::yahoo = 'Vk1yLjnV34EMS5s7pmKl.vkNugSojjEoeeZS44Q0CI2DFBUTZzJXHnbO2Fa2.nFN2f4nv0XwJBUyTQ--'
GeoKit::Geocoders::google = 'ABQIAAAAWnmpHGMPJ5CaA_wxTZdWgxRi_j0U6kJrkFvY4-OX2XYmEAa76BTMjosZz11_knsqbY5Eet6bd_w64A'
