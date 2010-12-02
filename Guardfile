# A sample Guardfile
# More info at http://github.com/guard/guard#readme

require 'find'

guard 'coffeescript', :output => 'lib/rufinol/public/javascripts' do
  watch('^lib/rufinol/coffeescripts/(.*)\.coffee')
end

guard 'coffeescript', :output => 'spec/javascripts' do
  watch('^spec/coffeescripts/(.*)\.coffee')
end
