require 'pp'
require './lib/ucloud_api'


s = UcloudApi::Storage.new
s.class.debug_output $stderr
p s.auth
# p s.get "/gamexfile"
# p s.head "/gamexfile"
p s.get "/epl"

# s = UcloudApi::StorageReseller.new
# s.class.debug_output $stderr
# p s.auth
# p s.add_user "gamexfile", "1234"
