require "test_helper"

class PlanetTest < ActiveSupport::TestCase
  test "planet fixture exists" do
    planet = planets(:planet_1)
    journey = journeys(:journey_1)
    assert_equal planet.journey_id, journey.id
    assert_equal planet.name, "test_planet one"
  end

  test "planet should be valid with valid journey" do
    planet = Planet.new(journey_id: journeys(:journey_2).id)
    assert planet.valid?, "planet should be valid"
  end

  test "planet should not be valid with invalid journey" do
    planet = Planet.new(journey_id: 123456)
    assert_not planet.valid?, "planet should not be valid"
  end

  test "planet record should be saved with valid journey" do
    planet = Planet.new(journey_id: journeys(:journey_2).id, name: "test name")
    assert planet.save, "planet not saved"
  end

  test "planet's journey should be updated when modified" do
    planet = planets(:planet_1)
    planet.journey_id = journeys(:journey_3).id
    assert planet.save, "planet not saved"
    assert_equal(journeys(:journey_3).id, planet.journey_id, "journey id not modified")
  end

  test "planet's name should be updated when modified" do
    planet = planets(:planet_1)
    planet.name = planets(:planet_2).name
    assert planet.save, "planet not saved"
    assert_equal(planets(:planet_2).name, planet.name, "planet name not modified")
  end
end
