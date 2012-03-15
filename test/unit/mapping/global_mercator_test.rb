require 'test_helper'
require 'mapping/global_mercator'

class Mapping::GlobalMercatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "tms to google conversion produces correct results on first zoom level" do
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(0,0,1)
    assert_equal 0, gtc[:x]
    assert_equal 1, gtc[:y]
    assert_equal 1, gtc[:zoom]
    
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(0,1,1)
    assert_equal 0, gtc[:x]
    assert_equal 0, gtc[:y]
    assert_equal 1, gtc[:zoom]
  end
  
  test "tms to google conversion produces correct results on higher zoom levels" do
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(10,11,4)
    assert_equal 10, gtc[:x]
    assert_equal 4, gtc[:y]
    assert_equal 4, gtc[:zoom]
    
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(97,113,7)
    assert_equal 97, gtc[:x]
    assert_equal 14, gtc[:y]
    assert_equal 7, gtc[:zoom]
  end
  
  test "inverse conversion from google to tms does work at several zoom levels" do
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(0,0,1)
    tms = Mapping::GlobalMercator.google_to_tms_tile_code(gtc[:x], gtc[:y], gtc[:zoom])
    assert_equal gtc[:x], tms[:x]
    assert_not_equal gtc[:y], tms[:y]
    assert_equal 0, tms[:y]
    assert_equal gtc[:zoom], tms[:zoom]
    
    gtc = Mapping::GlobalMercator.tms_to_google_tile_code(10,11,4)
    tms = Mapping::GlobalMercator.google_to_tms_tile_code(gtc[:x], gtc[:y], gtc[:zoom])
    assert_equal gtc[:x], tms[:x]
    assert_not_equal gtc[:y], tms[:y]
    assert_equal 11, tms[:y]
    assert_equal gtc[:zoom], tms[:zoom]
  end
  
  test "tms to quad tree produces correct results" do
    path = Mapping::GlobalMercator.tms_to_quad_tree_tile_code(97,113,7)
    assert_equal '1102221', path
  end

  test "inverse mapping quad tree to tms produces correct results" do    
    tms = Mapping::GlobalMercator.quad_tree_to_tms_tile_code('1102221')
    assert_equal 97, tms[:x]
    assert_equal 113, tms[:y]
    assert_equal 7, tms[:zoom]
  end
  
end