class Receipt
  # Getters
  attr_reader :receipt_items

  def initialize(receipt_items = [])
    @receipt_items = receipt_items
  end

  def total_item_cost_with_tax
    receipt_items.map(&:total_item_cost_with_tax).reduce(&:+).round(2)
  end

  def total_receipt_tax
    receipt_items.map(&:total_item_tax).reduce(&:+).round(2)
  end
end
