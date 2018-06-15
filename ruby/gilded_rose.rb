class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items.map do |item|
      item = klass_for(item.name).new(item.sell_in, item.quality)
    end 
  end

  def klass_for(name)
    case name 
    when "foo"
      Foo
    when "Aged Brie"
      Aged_Brie
    when "Sulfuras, Hand of Ragnaros"
      Sulfuras
    when "Backstage passes to a TAFKAL80ETC concert"
      Backstage_Pass
    end 
  end 
  
  def update_quality()
    @items.each do |item|
      item.update_quality
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class Foo < Item 
  attr_accessor :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end 

  def update_quality()
    puts "updating Foo quality"
    @sell_in -= 1 
    return if @quality == 0
    
    @quality -= 1 
    @quality -= 1 if @sell_in < 0
  end 
end 

class Aged_Brie < Item 
  attr_accessor :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end 

  def update_quality()
    puts "updating Aged Brie quality"
    @sell_in -= 1 
    @quality += 1 if @quality < 50
  end 
end 

class Sulfuras < Item 
  attr_accessor :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end 

  def update_quality()
    puts "updating Sulfuras quality"
    return
  end 
end 

class Backstage_Pass < Item 
  attr_accessor :sell_in, :quality

  def initialize(sell_in, quality)
    @sell_in = sell_in
    @quality = quality
  end 

  def update_quality()
    puts "updating Backstage Pass quality"
    @sell_in -= 1 

    if @sell_in < 0 
      @quality = 0 
    elsif @sell_in < 5 
      @quality += 3
    elsif @sell_in < 10 
      @quality += 2 
    end 
  end 
end 