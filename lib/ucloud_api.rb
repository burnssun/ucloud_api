
require "ucloud_api/version"
require 'base64'
require 'openssl'
require 'addressable/uri'
require 'httparty'

module UcloudApi
  
  class Client
    include HTTParty
    base_uri 'https://api.ucloudbiz.olleh.com/server/v1/client'
    format :json # spechify resonse format
    
    # debug_output $stderr
    
    def initialize(apikey=nil, secretkey=nil)
      @apikey = apikey || ENV["UCLOUDAPIKEY"]
      @secretkey = secretkey || ENV["UCLOUDSECRET"]
    end


    def raw_cmd options={}
      uri = Addressable::URI.new
      hashable_opt = options.merge( {:apiKey => @apikey, :response=>"json"} )
      uri.query_values = hashable_opt.sort
      hmac = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), uri.query.downcase, @secretkey)
      signature = Base64.encode64("#{OpenSSL::HMAC.digest('sha1', @secretkey, uri.query.downcase)}")[0..-2]
      query =  options.merge( {:response=>"json", :apiKey=>@apikey, :signature => signature } )
      self.class.get "/api" , :query => query
    end

    def self.list_styled command, listname
      class_eval <<"EOD"
  def #{command}(*args, &block)
    h = Hash[*args]
    h[:command] = "#{command}"
    response = raw_cmd(h)
    list = response.parsed_response["#{command.to_s.downcase}response"]["#{listname}"]
    yield(list) if block_given?
    list
  end
EOD
    end

    list_styled "listAvailableProductTypes", "producttypes"
    list_styled "listVirtualMachines", "virtualmachine"
    list_styled "listTemplates", "template"
    list_styled "listZones", "zone"
    list_styled "listNetworks", "network"

    # def method_missing m, *args, &block
    #   h = Hash[*args]
    #   h[:command] = m.to_s
    #   response = raw_cmd(h)
    #   r = response.parsed_response["#{m.to_s.downcase}response"]
    #   yield(r) if block_given?
    #   r
    # end
    
  end
  
end
