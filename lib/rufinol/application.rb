require 'sinatra/base'
require 'erb'

module Rufinol
  class Application < Sinatra::Base
    #set :sessions, true
    set :root, File.join(File.expand_path(File.dirname(__FILE__)))

    get '/' do
    end

    get '/test' do
      erb :socket_test
    end
  end
end
