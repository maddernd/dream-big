require "test_helper"

class AvatarTest < ActiveSupport::TestCase
  def setup
    # create student
    @student = Student.create(firstName: "John Doe")

    # create avatar head, hair, torso, and accessory records
    @avatar_head = AvatarHead.create(imgpath: "path_to_head_image.jpg")
    @avatar_hair = AvatarHair.create(imgpath: "path_to_hair_image.jpg")
    @avatar_torso = AvatarTorso.create(imgpath: "path_to_torso_image.jpg")
    @avatar_accessory = AvatarAccessory.create(imgpath: "path_to_accessory_image.jpg")

    # create avatar record
    @avatar = Avatar.create(
      student: @student,
      avatar_head: @avatar_head,
      avatar_hair: @avatar_hair,
      avatar_torso: @avatar_torso,
      avatar_accessory: @avatar_accessory,
    )
  end

  test "avatar belongs to association with student is valid" do
    assert_equal @student, @avatar.student
  end

  test "avatar belongs to association with avatar head is valid" do
    assert_equal @avatar_head, @avatar.avatar_head
  end

  test "avatar belongs to association with avatar hair is valid" do
    assert_equal @avatar_hair, @avatar.avatar_hair
  end

  test "avatar belongs to association with avatar torso is valid" do
    assert_equal @avatar_torso, @avatar.avatar_torso
  end

  test "avatar belongs to association with avatar accessory is valid" do
    assert_equal @avatar_accessory, @avatar.avatar_accessory
  end

  test "modifying avatar accessory and saving existing avatar record works" do
    @avatar.avatar_accessory = AvatarAccessory.create(imgpath: "path_to_new_accessory_image.jpg")
    @avatar.save
    assert_equal @avatar.avatar_accessory.imgpath, "path_to_new_accessory_image.jpg"
  end

  test "modifying avatar hair and saving existing avatar record works" do
    @avatar.avatar_hair = AvatarHair.create(imgpath: "path_to_new_hair_image.jpg")
    @avatar.save
    assert_equal @avatar.avatar_hair.imgpath, "path_to_new_hair_image.jpg"
  end

  test "modifying avatar head and saving existing avatar record works" do
    @avatar.avatar_head = AvatarHead.create(imgpath: "path_to_new_head_image.jpg")
    @avatar.save
    assert_equal @avatar.avatar_head.imgpath, "path_to_new_head_image.jpg"
  end

  test "modifying avatar torso and saving existing avatar record works" do
    @avatar.avatar_torso = AvatarTorso.create(imgpath: "path_to_new_torso_image.jpg")
    @avatar.save
    assert_equal @avatar.avatar_torso.imgpath, "path_to_new_torso_image.jpg"
  end
end
