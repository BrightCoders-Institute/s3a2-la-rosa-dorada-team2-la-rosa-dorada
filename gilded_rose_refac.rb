class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      unless item.name == "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
        aged_items(item)
        caducado(item)
        aged_bonus(item)
        quality_down(item)
      end
    end
  end

  def aged_items(item)
    if (item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert") and item.quality < 50
      item.quality += 1
    end
  end
  
  def aged_bonus(item)
    if item.sell_in < 10 and (item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert")
      item.quality += 2
    elsif item.sell_in < 5 and (item.name == "Aged Brie" or item.name == "Backstage passes to a TAFKAL80ETC concert")
      item.quality += 3
    end
  end

  def caducado(item)
    if item.sell_in <= 0 and item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      item.quality = 0  
    end
  end

  def quality_down(item)
    if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
      item.quality -=1
    end
  end
  
end

class Item
  MINIMUM_VALUE = 0
  MAXIMUM_VALUE = 50
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def quality=(new_quality)
    @quality = [new_quality, MINIMUM_VALUE].max
    @quality = [@quality, MAXIMUM_VALUE].min
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
