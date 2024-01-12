require File.join(File.dirname(__FILE__), 'gilded_rose_refac')
require 'rspec'

describe GildedRose do
  describe '#update_quality' do
    it 'increases quality for Aged Brie over time' do
      aged_brie = Item.new("Aged Brie", 5, 10)
      gilded_rose = GildedRose.new([aged_brie])
      gilded_rose.update_quality
      expect(aged_brie.quality).to be > 10
    end

    it 'increases quality for Backstage passes based on sell_in' do
      backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)
      gilded_rose = GildedRose.new([backstage_passes])
      gilded_rose.update_quality
      expect(backstage_passes.quality).to be > 20
    end

    it 'does not change quality for Sulfuras' do
      sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
      gilded_rose = GildedRose.new([sulfuras])
      gilded_rose.update_quality
      expect(sulfuras.quality).to eq(80)
    end

    it 'decreases quality for normal items over time' do
      normal_item = Item.new("Normal Item", 3, 20)
      gilded_rose = GildedRose.new([normal_item])
      gilded_rose.update_quality
      expect(normal_item.quality).to be < 20
    end

    it 'sets quality to zero for expired items' do
      expired_item = Item.new("Expired Item", 0, 30)
      gilded_rose = GildedRose.new([expired_item])
      gilded_rose.update_quality
      expect(expired_item.quality).to eq(0)
    end

    it 'decreases quality twice as fast for Conjured items' do
      conjured_item = Item.new("Conjured Mana Cake", 5, 10)
      gilded_rose = GildedRose.new([conjured_item])
      gilded_rose.update_quality
      expect(conjured_item.quality).to be < 10
    end

    # Agrega más pruebas según sea necesario
  end
end
