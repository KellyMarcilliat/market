class Market 
  attr_reader   :name,
                :vendors 
  def initialize(name)
    @name = name 
    @vendors = []
  end 
  
  def add_vendor(vendor_obj)
    @vendors << vendor_obj
  end 
  
  def vendor_names 
    @vendors.map do |vendor| 
      vendor.name 
    end 
  end 
  
  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory[item] > 0 
    end 
  end 
  
  def sorted_item_list
    total_inventory.keys.sort 
  end 
  
  #helper to sorted_item_list
  def total_inventory
    mkt_inv = Hash.new(0)
    @vendors.map do |vendor|
      vendor.inventory.map do |key, value|
        mkt_inv[key] += value 
      end 
    end 
    return mkt_inv 
  end 
  
  def sell(item, quantity)
    if total_inventory[item] < quantity 
      false
    else
      transact(item, quantity) 
      true 
    end 
  end 
  
  #helper to sell 
  def transact(item, quantity)
    while quantity > 0 do 
      @vendors.map do |vendor|
        if vendor.check_stock(item) >= quantity
          vendor.stock(item, (- 1 * quantity))
          quantity = 0
        else 
          initial_inventory = vendor.inventory[item]
          vendor.stock(item, (-1 * initial_inventory))
          quantity = quantity - initial_inventory
        end 
      end
    end
  end  
end 