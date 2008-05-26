require 'vpim'

# The gem's implementation is broken - it doesn't add the timezone.
def Vpim.encode_date_time(d) # :nodoc:
   d.iso8601.gsub /[-:]/, ''
end
