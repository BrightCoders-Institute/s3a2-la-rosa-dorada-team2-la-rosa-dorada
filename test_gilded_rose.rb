require 'minitest/autorun'
require File.join(File.dirname(__FILE__), 'gilded_rose_refac')

class TestGildedRose < Minitest::Test
  def setup
    # Crea objetos de prueba según tus necesidades
    @aged_brie = Item.new("Aged Brie", 5, 10)
    @backstage_passes = Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 20)
    @sulfuras = Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @normal_item = Item.new("Normal Item", 3, 20)
    @conjured_item = Item.new("Conjured Mana Cake", 5, 10)
  end

  def test_aged_brie_quality_increases_over_time
    gilded_rose = GildedRose.new([@aged_brie])
    gilded_rose.update_quality
    assert_operator @aged_brie.quality, :>, 10  # La calidad debería aumentar
  end

  def test_backstage_passes_quality_increases_based_on_sell_in
    gilded_rose = GildedRose.new([@backstage_passes])
    gilded_rose.update_quality
    assert_operator @backstage_passes.quality, :>, 20  # La calidad debería aumentar
  end

  def test_sulfuras_quality_does_not_change
    gilded_rose = GildedRose.new([@sulfuras])
    gilded_rose.update_quality
    assert_equal 80, @sulfuras.quality  # No hay cambios esperados
  end

  def test_normal_item_quality_decreases_over_time
    gilded_rose = GildedRose.new([@normal_item])
    gilded_rose.update_quality
    assert_operator @normal_item.quality, :<, 20  # La calidad debería disminuir
  end

  def test_caducado_item_quality_drops_to_zero
    expired_item = Item.new("Expired Item", 0, 30)
    gilded_rose = GildedRose.new([expired_item])
    gilded_rose.update_quality
    assert_equal 0, expired_item.quality  # La calidad debe ser cero
  end

  def test_conjured_item_quality_decreases_twice_as_fast
    gilded_rose = GildedRose.new([@conjured_item])
    gilded_rose.update_quality
    assert_operator @conjured_item.quality, :<, 10  # La calidad debería disminuir más rápido
  end

end
