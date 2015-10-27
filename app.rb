#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base

 end

get '/' do
	@product = Product.all
	erb :index 
end

get '/about' do
	erb :about
end

post '/cart' do

	@hh = {}
	@hh1 = {
		'1' => "Hawaiian",
		'2' => "Pepperoni",
		'3' => "Vegeterian"
	}

	order = params[:orders]
	s1 = order.split(/,/)
	
	s1.each do |x|
		
		s2 = x.split("=")
		s3 = s2[0].split (/_/)

		@hh[s3[1]] = s2[1]

	end

	erb :cart
end