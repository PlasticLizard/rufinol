require 'sinatra/base'
require 'erb'

module Rufinol
  class Application < Sinatra::Base
    #set :sessions, true
    set :root, File.join(File.expand_path(File.dirname(__FILE__)))

    get '/' do
      @board = Rufinol.firmata
      erb :board
    end

    get '/test' do
      erb :socket_test
    end

    helpers do

      def pin_select(pin)
        id = pin.pin_type == (Rufirmata::ANALOG ? "a_" : "d_") +  pin.pin_number.to_s
        sel = "<select id='#{id}' name='#{id}'>"
        {"Input"=>Rufirmata::INPUT, "Output"=>Rufirmata::OUTPUT,
         "Analog"=>Rufirmata::ANALOG, "PWM"=>Rufirmata::PWM,
          "Unavailable"=>Rufirmata::UNAVAILABLE}.each_pair do |key,value|
          selected = pin.mode == value ? " selected" : ""
          sel +="<option value=#{value}#{selected}>#{key}</option>"
        end
        sel += "</select>"
      end

    end

  end
end
