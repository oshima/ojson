require 'ojson/parser'
require 'ojson/version'

module Ojson
  def self.parse(json)
    Parser.new.parse(json)
  end
end
