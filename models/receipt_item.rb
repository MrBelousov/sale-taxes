class ReceiptItem
  # Getters
  attr_reader :quantity, :item

  def initialize(quantity, item)
    @quantity = quantity
    @item = item
  end

  def self.load_receipt_item(quantity: 1, item_name: nil, item_price: nil)
    item = Item.new(item_name, item_price)
    new(quantity, item)
  end

  def total_item_cost_with_tax
    item.item_cost_with_tax * quantity
  end

  def total_item_tax
    item.tax * quantity
  end
end
