
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe "initialize" do 
    it "requires that all items have a @sell_in value and @quality" do       
      expect{Item.new("foo")}.to raise_error(ArgumentError)
      expect{Item.new("foo", 10)}.to raise_error(ArgumentError)
      expect{Item.new("foo", 10, 10)}.to_not raise_error
    end
  end 

end