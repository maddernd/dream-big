require "test_helper"

class PlanetTest < ActiveSupport::TestCase

  test "journey fixture exists" do
    assert_equal 135138681, journeys(:journey_2).id
    assert_equal planets(:planet).journey_id, journeys(:journey_2).id
  end

  test "should save when journey_id(FK) exists in journeys table" do
    planet = Planet.new
    planet.journey_id = journeys(:journey_2).id
    assert planet.save, "planet not saved"
  end

  test "should error when goal_id(FK) does not exist in goals table" do
    planet = Planet.new
    planet.journey_id = 123456789426
    assert_raises(ActiveRecord::InvalidForeignKey) do planet.save
    end
  end

  test "planet record should save" do
    planet = Planet.new
    planet.journey_id = journeys(:journey_2).id
    planet.name = "test name"
    assert planet.save, "planet not saved"
  end

  test "should modify journey id and save existing planet record " do
    planet = planets(:planet)
    planet.journey_id = journeys(:journey_3).id
    planet.save
    assert_equal( journeys(:journey_3).id, planet.journey_id, "journey id not modified")
    end 

    test "should modify planet name and save existing planet record " do
      planet = planets(:planet)
      planet.name = planets(:planet_2).name
      planet.save
      assert_equal( planets(:planet_2).name, planet.name, "planet name not modified")
      end 

end
