require "cc4has_many/version"
require "active_support"
require 'active_support/concern'

module Cc4hasMany
  autoload :Reflection, 'cc4has_many/reflection'
  autoload :HasManyCounterCache, 'cc4has_many/has_many_counter_cache'

  def self.init
  end
end
