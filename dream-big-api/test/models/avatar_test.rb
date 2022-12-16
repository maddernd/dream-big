require "test_helper"

class AvatarTest < ActiveSupport::TestCase
  
  test "avatar fixture exists for foreign key" do
    assert_equal 1, avatar(:avatar).id
    assert_equal avatar(:avatar).id, students(:student).id
  end

  test "avatar hair fixture exists for foreign key" do
    assert_equal 1, avatar_hair(:hair).id
    assert_equal avatar_hair(:hair).id, avatar(:avatar).avatar_hairs_id
  end

  test "avatar head fixture exists for foreign key" do
    assert_equal 1, avatar_head(:head).id
    assert_equal avatar_head(:head).id, avatar(:avatar).avatar_head_id
  end

  test "avatar torso fixture exists for foreign key" do
    assert_equal 1, avatar_torso(:torso).id
    assert_equal avatar_torso(:torso).id, avatar(:avatar).avatar_torsos_id
  end

  test "avatar accessories fixture exists for foreign key" do
    assert_equal 1, avatar_accessories(:accessory).id
    assert_equal avatar_accessories(:accessory).id, avatar(:avatar).avatar_accessories_id
  end

  test "should modify avatar accessories id and save avatar record " do
    avatar = avatar(:avatar)
    avatar.avatar_accessories_id = avatar_accessories(:accessory_2).id
    avatar.save
    assert_equal( avatar_accessories(:accessory_2).id, avatar.avatar_accessories_id, "accessories_id not modified")
    end 
    
  test "should modify avatar hairs id and save avatar record " do
    avatar = avatar(:avatar)
    avatar.avatar_hairs_id = avatar_hair(:hair_2).id
    avatar.save
    assert_equal( avatar_hair(:hair_2).id, avatar.avatar_hairs_id, "hairs_id not modified")
  end

  test "should modify avatar head id and save avatar record " do
    avatar = avatar(:avatar)
    avatar.avatar_head_id = avatar_head(:head_2).id
    avatar.save
    assert_equal( avatar_head(:head_2).id, avatar.avatar_head_id, "head_id not modified")
  end

  test "should modify avatar torsos id and save avatar record " do
    avatar = avatar(:avatar)
    avatar.avatar_torsos_id = avatar_torso(:torso_2).id
    avatar.save
    assert_equal(avatar_torso(:torso_2).id, avatar.avatar_torsos_id, "torsos_id not modified")
  end

end