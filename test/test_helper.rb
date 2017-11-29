$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "bit_ranger"

require "minitest/autorun"
require 'minitest/given'
Given.source_caching_disabled = true
