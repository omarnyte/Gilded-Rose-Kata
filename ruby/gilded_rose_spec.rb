require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "Item initialize" do 
    it "requires that all items have a @sell_in value and @quality" do       
      expect{Item.new("foo")}.to raise_error(ArgumentError)
      expect{Item.new("foo", 10)}.to raise_error(ArgumentError)
      expect{Item.new("foo", 10, 10)}.to_not raise_error
    end
  end 

  describe "#update_quality" do
    it "lowers both @sell_in and @quality for every item at the end of each day" do 
      items = [Item.new("foo", 10, 10)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(9)
      expect(gr.items[0].quality).to eq(9)
    end 

    it "degreades quality twice as fast once the sell date has passed" do 
      items = [Item.new("foo", 0, 10)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(-1)
      expect(gr.items[0].quality).to eq(8)
    end 

    it "never brings down quality to a negative value" do 
      items = [Item.new("foo", 10, 0)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(9)
      expect(gr.items[0].quality).to eq(0)
    end 

    it "increases the quality of 'Aged Brie' the older it gets" do 
      items = [Item.new("Aged Brie", 10, 10)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(9)
      expect(gr.items[0].quality).to eq(11)
    end 

    it "never incrases the quality of an item to be more than 50" do 
      items = [Item.new("Aged Brie", 10, 50)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(9)
      expect(gr.items[0].quality).to eq(50)
    end 

    it "never decereases @sell_in or @quality for 'Sulfuras'" do 
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(gr.items[0].sell_in).to eq(10)
      expect(gr.items[0].quality).to eq(80)
    end 

    it "handles the incrase of 'Backstage passes to a TAFKAL80ETC concert'" do 
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10)]
      gr = GildedRose.new(items)
      gr.update_quality
      expect(items[0].sell_in).to eq(5)
      expect(items[0].quality).to eq(12)

      gr.update_quality
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(15)

      5.times do 
        gr.update_quality
      end 

      expect(items[0].sell_in).to eq(-1)
      expect(items[0].quality).to eq(0)
    end     
  end 
end