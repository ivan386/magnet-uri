require 'cgi'
require 'uri'

class MagnetURI

  VERSION = '0.0.1'

  PARAMS = [:as, :dn, :kt, :mt, :tr, :xl, :xs, :xt].map do |param|
    attr_reader param
    param
  end

  def initialize(uri)
    raise ArgumentError, 'bad argument (expected magnet URI)' unless uri =~ /^magnet:\?/

    scheme, params = uri.split('?', 2)

    @params = {}.tap do |param|
      CGI.parse(URI.decode(params)).each do |name, value|
        name  = name.to_sym
        value = (value.size == 1 ? value.first : value)

        param[name] = value
        instance_variable_set("@#{name}", value) if PARAMS.include?(name)
      end
    end
  end

  def params
    @params
  end

  # Acceptable Source - Web link to the file online
  alias :acceptable_source :as

  # Display Name      - Filename
  alias :display_name :dn

  # Keyword Topic     - Key words for search
  def kt
    Array(@kt)
  end
  alias :keywords :kt

  # Manifest Topic    - Link to the metafile that contain a list of magneto
  alias :manifest :mt

  # Address Tracker   - Tracker URL for Bittorrent downloads
  def tr
    Array(@tr)
  end
  alias :trackers :tr

  # Exact Length      - Size in bytes
  def xl 
    @xl && @xl.to_i
  end
  alias :length :xl

  # Exact Source      - P2P link
  alias :source :xs

  # Exact Topic       - URN containing file hash
  alias :topic :xt
end

module Kernel
  def MagnetURI(uri)
    MagnetURI.new(uri)
  end

  module_function :MagnetURI
end
