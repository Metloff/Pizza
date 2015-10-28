class CreateOrders < ActiveRecord::Migration
  def change
  	create_table :orders do |t|

  		t.text :order
  		t.text :title
  		t.text :phone
  		t.text :adress

  		t.timestamps

  	end
  end
end
