require 'pp'
require './lib/ucloud_api'

u = UcloudApi::Client.new
pts = u.listAvailableProductTypes
#pp pts.select { |p| p["templatedesc"] =~ /Ubuntu 12.04 64bit/ }.map { |x| [x["diskofferingid"],x["diskofferingdesc"],x["templatedesc"]]  }.uniq
pp pts.select { |p| p["templatedesc"] =~ /Ubuntu 12.04 64bit/ }
#pp pts["producttypes"].map { |x| [x["serviceofferingid"],x["serviceofferingdesc"]]  }.uniq

# # pp pts["producttypes"].select { |x|
# #   x["templatedesc"] =~ /WIN 2012 STD 64bit/i and x["serviceofferingdesc"] =~ /2vCore 2GB/
# # } 


# vms = u.cmd(:command => "listVirtualMachines")["virtualmachine"]
# pp vms.map { |x| [x["displayname"],x["nic"][0]["ipaddress"]] }


#pp u.listTemplates :templatefilter => "self"
# pp u.cmd :command=>"listTemplates", :templatefilter => "self"

# pp u.raw_cmd :command=>"listNetworkUsages", :startdate=>"2014-01-01", :enddate=>"2014-01-27"
# pp u.raw_cmd :command=>"listNetworks"
# pp u.raw_cmd :command=>"listSnapshots"

# p u.raw_cmd :command => "listVirtualMachines"
# p u.listVirtualMachines()

# pp u.listNetworkUsages :startdate=>"2014-01-01", :enddate=>"2014-01-27"


# pp u.cmd :command => "deployVirtualMachine", :serviceofferingid => serviceofferingid, :templateid => templateid, :diskofferingid => diskofferingid, :zoneid => zoneid, :usageplatype => "monthly", :displayname => "deploytest"

# pp u.cmd :command => "listVirtualMachines"

# u = UCloud.new( "miVr6X", "keokzhd")
# u.cmd :command=>"listVirtualMachines", :name=>"vm_33111", :response => "xml", :state=>"running"

    
