require 'rubygems'
require 'bundler/setup'

# Libraries
require 'csv'

# Models
require_relative 'models/item'
require_relative 'models/receipt_item'
require_relative 'models/receipt'

class Main
  attr_accessor :receipt_items

  def initialize(receipt_items = [])
    @receipt_items = receipt_items
  end

  def output_recipe(receipt_items)
    system 'clear'
    receipt = Receipt.new(receipt_items)

    puts "Sales Taxes: #{receipt.total_receipt_tax}"
    puts "Total Price: #{receipt.total_item_cost_with_tax}"
  end

  def load_items_from_input(quantity, name, price)
    receipt_items << ReceiptItem.load_receipt_item(
        quantity: quantity.strip.to_i,
        item_name: name.strip,
        item_price: price.to_f
    )
  end

  def load_items_from_file(file)
    # Default params
    file = "inputs/#{file}"

    CSV.open(file).each do |row|
      receipt_items << ReceiptItem.load_receipt_item(
          quantity: row[0].strip.to_i,
          item_name: row[1].strip,
          item_price: row[2].strip.to_f
      )
    end

    receipt_items
  end
end


main = Main.new

# Check for arguments for testing
if ARGV[0]
  receipt_items = main.load_items_from_file(ARGV[0])
  main.output_recipe(receipt_items)
else
  loop do
    system 'clear'
    puts 'Choose your type of input:'
    puts 'Default input (1)'
    puts 'Input from CSV (2)'
    puts 'Exit (e)'
    chose = gets.chomp

    case chose.to_s
    when '1'
      system 'clear'
      print 'Enter item name: '
      name = gets.chomp
      print 'Enter quantity: '
      quantity = gets.chomp
      print 'Enter item price: '
      price = gets.chomp

      receipt_items = main.load_items_from_input(quantity, name, price)
      main.output_recipe(receipt_items)
      break
    when '2'
      system 'clear'
      puts 'Choose file for input:'
      input_files = Dir.entries("inputs").select {|f| !File.directory? f}
      input_files.each_with_index do |file, i|
        puts "#{file} (#{i})"
      end

      file_chose = gets.chomp

      # Check input to be number
      unless /\A[-+]?\d+\z/.match(file_chose)
        system 'clear'
        puts 'Wrong input'
        gets
        next
      end

      begin
        receipt_items = main.load_items_from_file(input_files[file_chose.to_i])
        main.output_recipe(receipt_items)
        break
      rescue
        system 'clear'
        puts 'No such file'
        gets
      end
    when 'e'
      break
    else
      system 'clear'
      puts 'Wrong input'
      gets
    end
  end
end