class GildedRose
  attr_accessor :items

  def initialize(items)
    @items = items.map do |item|
      case item.name 
      when "foo"
        item = Foo.new(item.sell_in, item.quality)
      when "Aged Brie"
        item = Aged_Brie.new(item.sell_in, item.quality)
      when "Sulfuras, Hand of Ragnaros"
        item = Sulfuras.new(item.sell_in, item.quality)
      when "Backstage passes to a TAFKAL80ETC concert"
        item = Backstage_Pass.new(item.sell_in, item.quality)
      end 
    end 
  end

  def update_quality()
    @items.each do |item|
      item.update_quality

    #   if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
    #     if item.quality > 0
    #       if item.name != "Sulfuras, Hand of Ragnaros"
    #         item.quality = item.quality - 1
    #       end
    #     end
    #   else
    #     if item.quality < 50
    #       item.quality = item.quality + 1
    #       if item.name == "Backstage passes to a TAFKAL80ETC concert"
    #         if item.sell_in < 11
    #           if item.quality < 50
    #             item.quality = item.quality + 1
    #           end
    #         end
    #         if item.sell_in < 6
    #           if item.quality < 50
    #             item.quality = item.quality + 1
    #           end
    #         end
    #       end
    #     end
    #   end
    #   if item.name != "Sulfuras, Hand of Ragnaros"
    #     item.sell_in = item.sell_in - 1
    #   end
    #   if item.sell_in < 0
    #     if item.name != "Aged Brie"
    #       if item.name != "Backstage passes to a TAFKAL80ETC concert"
    #         if item.quality > 0
    #           if item.name != "Sulfuras, Hand of Ragnaros"
    #             item.quality = item.quality - 1
    #           end
    #         end
    #       else
    #         item.quality = item.quality - item.quality
    #       end
    #     else
    #       if item.quality < 50
    #         item.quality = item.quality + 1
    #       end
    #     end
    #   end
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