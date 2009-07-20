require 'rubygems'
require 'tegu_gears'

Dir.glob("#{File.dirname(__FILE__)}/ext/*.rb").each { |file| require file }
Dir.glob("#{File.dirname(__FILE__)}/kmeans/*.rb").each { |file| require file }

