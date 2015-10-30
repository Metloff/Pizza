#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:pizzashop.db"

class Product < ActiveRecord::Base

end

class Order < ActiveRecord::Base

end

get '/' do
	@product = Product.all
	erb :index 
end

get '/about' do
	erb :about
end

post '/cart' do


	@orders_input = params[:orders_input]
	@items = parse_orders_input @orders_input

	#выводим сообщение о том, что корзина пуста

	if @items.length == 0
		return erb :cart_is_empty
	end

	#выводим список продуктов по-умолчанию

	@items.each do |item|
		item[0] = Product.find(item[0])

	end

	#возвращаем представление по-умолчанию

	erb :cart
end

post '/place_order' do

	@c = Order.new params[:order]
	@c.save	

	erb :order_placed

end

get '/admin' do
	@allorders = Order.order 'created_at DESC'
	@a = []

	@allorders.each do |order|
		
			b = parse_orders_input order[:orders_input]

			b.each do |b1|
				b1[0] = Product.find(b1[0])
			end

			@a << b
			
			order[:orders_input] = @a
	end

	# @pizzainfo.each do |pizza|
	# 	pizza[0] = Product.find(pizza[0])
	# end

	erb :admin
end

def parse_orders_input orders_input

	s1 = orders_input.split(/,/)

	arr = []

	s1.each do |x|
		
		s2 = x.split("=")

		s3 = s2[0].split (/_/)

		id = s3[1]
		cnt = s2[1]

		arr2 = [id, cnt]

		arr.push arr2

	end

	return arr
end
