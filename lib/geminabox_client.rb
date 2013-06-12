require "geminabox_client/version"

module GeminaboxClient
  autoload :Client, 'geminabox_client/client'
  autoload :GemLocator, 'geminabox_client/gem_locator'

  class GeminaboxClient::Error < RuntimeError
  end
end
