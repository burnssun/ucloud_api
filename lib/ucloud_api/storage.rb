require 'uri'
require 'httparty'

module UcloudApi
  
  class Storage
    include HTTParty
    
    format :json # specify resonse format
    
    # debug_output $stderr
    
    def initialize(user=nil, pass=nil)
      @user = user || ENV["UCLOUD_STORAGE_USER"]
      @pass = pass || ENV["UCLOUD_STORAGE_PASS"]
    end

    def auth
      auth_url = 'https://api.ucloudbiz.olleh.com/storage/v1/auth'
      response = self.class.get auth_url , :headers => { "X-Storage-User" => @user, "X-Storage-Pass"=> @pass }
      headers = response.headers
      @storage_url = headers["X-Storage-Url"]
      @auth_token = headers["X-Auth-Token"]
      response
    end

    # http://developer.ucloudbiz.olleh.com/doc/swift/Account/GET-Storage-account/
    def get path, options = {}
      url = File.join @storage_url,path
      params = { format: "json" }.merge options
      response = self.class.get url, :query => params, :headers=> {"X-Auth-Token"=> @auth_token}
      response.parsed_response
    end

    def head path, options = {}
      url = File.join @storage_url,path
      params = { format: "json" }.merge options
      self.class.head url, :query => params, :headers=> {"X-Auth-Token"=> @auth_token}
    end


  end


  class StorageReseller
    include HTTParty
    
    format :json # specify resonse format
    
    # debug_output $stderr
    
    def initialize(reseller_admin_user=nil, reseller_admin_pass=nil, reseller_user = nil)
      @reseller_admin = reseller_admin_user || ENV["UCLOUD_STORAGE_RESELLER_ADMIN"]
      @reseller_admin_pass = reseller_admin_pass || ENV["UCLOUD_STORAGE_RESELLER_ADMIN_PASS"]
      @reseller_user = reseller_user || ENV["UCLOUD_STORAGE_RESELLER_USER"]
    end
  
    def auth
      auth_url = 'https://api.ucloudbiz.olleh.com/storage/v1/auth'
      headers = {
        "X-Storage-User" => "#@reseller_user:#@reseller_admin",
        "X-Storage-Pass"=> @reseller_admin_pass }
      response = self.class.get auth_url , :headers => headers
      headers = response.headers
      @storage_url = headers["X-Storage-Url"]
      @auth_token = headers["X-Auth-Token"]
      response
    end
    
    def add_user user, pass
      auth_url = File.join "https://ssproxy.ucloudbiz.olleh.com", "/auth/v2/#@reseller_user/#{user}"
      #auth_url = "https://api.ucloudbiz.olleh.com/v2/#@reseller_user/#{user}"
      headers = {
        "X-Auth-Admin-User" => @reseller_admin,
        "X-Auth-Admin-Key" => @reseller_admin_pass,
        "X-Auth-User-Key" => pass }      
      self.class.put auth_url, :headers => headers
    end
      
  end
  
end
