class Item
  # Getters
  attr_reader :name, :price, :default_item_tax,
              :base_item_tax, :imported_item_tax, :round_number

  def initialize(name, price)
    @name = name
    @price = price.to_f

    @default_item_tax = 0.0
    @base_item_tax = 0.1
    @imported_item_tax = 0.05
    @round_number = 20.00
  end

  def item_cost_with_tax
    price + tax
  end

  def tax_percent
    unless %i(book food medicine).include?(item_type)
      base_tax = base_item_tax
    else
      base_tax = 0
    end

    if imported?
      imported_tax = imported_item_tax
    else
      imported_tax = 0
    end

    default_item_tax + base_tax.to_f + imported_tax.to_f
  end

  def tax
    (price * tax_percent * round_number).round / round_number
  end

  def item_type
    case
    when name.include?('book')
      :book
    when name.include?('pill')
      :medicine
    when name.include?('chocolate')
      :food
    else
      :other
    end
  end

  def imported?
    true if name.include?('imported')
  end
end