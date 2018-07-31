require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test 
  
  def test_it_exists
    market = Market.new("South Pearl Street Farmers Market") 
    assert_instance_of Market, market 
  end
  
  def test_attributes_at_instantiation
    market = Market.new("South Pearl Street Farmers Market")
    assert_equal "South Pearl Street Farmers Market", market.name 
    assert_equal [], market.vendors
  end 
  
  def test_it_adds_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)  
  end 
  
  def test_it_adds_vendors
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal [vendor_1, vendor_2, vendor_3], market.vendors 
  end 
  
  def test_it_produces_vendor_names
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], market.vendor_names   
  end 
  
  def test_it_finds_vendors_who_sell_an_item
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal [vendor_1, vendor_3], market.vendors_that_sell("Peaches")
    assert_equal [vendor_2], 
    market.vendors_that_sell("Banana Nice Cream")
  end
  
  def test_sorted_item_list
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"], market.sorted_item_list
  end 
  
  def test_total_inventory
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal ({"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}), market.total_inventory
  end 
  
  def test_it_sells_on_sufficiency_of_stock
    market = Market.new("South Pearl Street Farmers Market")
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)    
    vendor_1.stock("Tomatoes", 7)    
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")    
    vendor_2.stock("Banana Nice Cream", 50)    
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)    
    vendor_3 = Vendor.new("Palisade Peach Shack")    
    vendor_3.stock("Peaches", 65)
    market.add_vendor(vendor_1)    
    market.add_vendor(vendor_2)    
    market.add_vendor(vendor_3)
    assert_equal false, market.sell("Peaches", 200)
    assert_equal false, market.sell("Onions", 1)
    assert_equal true, market.sell("Banana Nice Cream", 5)
    
    assert_equal 45, vendor_2.check_stock("Banana Nice Cream") 
    assert_equal true, market.sell("Peaches", 40)
    assert_equal 0, vendor_1.check_stock("Peaches")
    assert_equal 60, vendor_3.check_stock("Peaches")  
  end    
end 