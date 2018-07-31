require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists 
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor 
  end
  
  def test_attributes_at_instantiation 
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name 
    assert_equal ({}), vendor.inventory  
  end 
  
  def test_it_checks_stock 
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock("Peaches")
  end 
  
  def test_it_adds_stock
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    assert_equal 30, vendor.check_stock("Peaches") 
  end 
  
  def test_it_updates_inventory 
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock("Peaches", 30)
    vendor.stock("Peaches", 25)
    vendor.stock("Tomatoes", 12)
    assert_equal ({"Peaches"=>55, "Tomatoes"=>12}), vendor.inventory
  end 
end 
