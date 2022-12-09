require "test_helper"

class RoleTest < ActiveSupport::TestCase

  test "roles fixture exists for foreign key" do
    assert_equal 1, roles(:role).id
  end    

  test "role record should save" do
    role = Role.new
    role.role_description = "Description of the role"
    assert role.save, "role not saved"
  end

  test "should modify role description and save existing role record " do
    role = roles(:role)
    role.role_description = "test role description"
    role.save
    assert_equal( "test role description", role.role_description, "role description not modified")
    end 

end
