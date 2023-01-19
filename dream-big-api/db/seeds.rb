require "csv"
require "faker"
require "bcrypt"
I18n.reload!

# The data can be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

def read_csv_path_for_model(file_name)
  Rails.root.join("db", "resources", "#{file_name}.csv")
end

def import_from_csv(model, attributes)
  "" "
  Imports data from a CSV file and creates records in the specified model using the specified attributes.

  Parameters:
  - model (class): The model in which you want to create records.
  - attributes (list): A list of attributes that you want to set for each record.

  Returns:
  - None
  " ""
  model_name_as_lowercase = "#{model}".downcase
  plural_model_name = model_name_as_lowercase[-1] == "y" ? "#{model_name_as_lowercase.delete_suffix("y")}ies" : "#{model_name_as_lowercase}s"
  path = read_csv_path_for_model(plural_model_name)

  CSV.foreach(path, headers: true).map do |row|
    item = {}

    attributes.each do |attr|
      item[attr] = row[attr]
    end

    model.insert(item)
  end
end

def create_user_with_password(username, email, password, role)
  hashed_password = BCrypt::Password.create(password)
  user = User.create(username: username, email: email, password_digest: hashed_password, role: role)
  user.save!
  return user
end

def seed_data_parent_child(parent_model, parent_attributes, child_model, child_attributes, num)
  "" "
  Seeds data for a parent model and a child model, creating records for both models.

  Parameters:
  - parent_model (class): The parent model for which you want to create records.
  - parent_attributes (dict): A dictionary of attributes and values for the parent model.
  - child_model (class): The child model for which you want to create records.
  - child_attributes (dict): A dictionary of attributes and values for the child model.
  - num (int): The number of records that you want to create for both the parent and child models.

  Returns:
  - None
  " ""
  parent_items = []
  child_items = []
  for i in 1..num
    parent_item = {}
    parent_attributes.each do |attr, val|
      parent_item[attr] = "#{val.call()}"
    end

    parent_item = parent_model.create(parent_item)
    parent_item.save!

    child_item = {}
    child_item["#{parent_model}_id".downcase] = parent_item.id
    child_attributes.each do |attr, val|
      child_item[attr] = "#{val.call()}"
    end
    child_item = child_model.create(child_item)
  end

  puts "Seeded #{num} #{parent_model} and #{child_model} records"
end

def seed_child_data(parent_items, child_model, child_attributes, num_per_parent = 1)
  "" "
  Seeds data for a child model, creating records and linking them to the specified parent items.

  Parameters:
  - parent_items (list): A list of parent items to which the child records will be linked.
  - child_model (class): The child model for which you want to create records.
  - child_attributes (list): A list of attributes for the child model.
  - num_per_parent (int): The number of child records that you want to create for each parent item (default is 1).

  Returns:
  - list: A list of the created child records.
  " ""
  items = []
  parent_items.each do |parent_item|
    for i in 1..num_per_parent
      child_item = {}
      parent_name = parent_item.class.name.scan(/[A-Z][a-z]+/).join("_")
      child_item["#{parent_name}_id".downcase] = parent_item.id
      child_attributes.each do |attr|
        child_item[attr] = "#{parent_item.id}"
      end
      child_item = child_model.create!(child_item)
      items.append(child_item)
    end
  end

  puts "Seeded #{parent_items.length()} #{child_model} records"
  return items
end

def seed_sequence_data(model, attributes, num)
  "" "
  Seeds data for a model by creating records with sequential attribute values.

  Parameters:
  - model (class): The model for which you want to create records.
  - attributes (list): A list of attributes for the model.
  - num (int): The number of records that you want to create.

  Returns:
  - list: A list of the created records.
  " ""
  items = []
  last_id = model.last ? model.last.id : 0
  for i in last_id + 1..num + last_id
    item = {}
    attributes.each do |attr|
      item[attr] = "#{attr}_#{i}"
    end
    item = model.create(item)
    item.save!
    items.append(item)
  end
  puts "Seeded #{num} #{model} records"
  return items
end

def create_record(model, attributes, num = 1)
  "" "
  Creates a specified number of records for the given model, with the given attributes and values.

  Parameters:
  - model (class): The model for which you want to create records.
  - attributes (dict): A dictionary of attributes and the values you want to set for them.
  - num (int): The number of records that you want to create (default is 1)

  Returns:
  - list: A list of the created records.
  " ""
  items = []
  for i in 1..num
    item = {}
    attributes.each do |attr, val|
      item[attr] = val
    end
    item = model.create!(item)
    items.append(item)
  end

  puts "Created #{num} #{model} records"
  return items
end



# The transaction block ensures that if any of the following function calls fail, 
# all of the changes made in the block will be rolled back, 
# leaving the database in its original state.
ActiveRecord::Base.transaction do
  """
  The seed_sequence_data function creates a number of records for a given model with specified attributes and values. 
  In this case, it creates 4 Category records with the attributes 'name' and 'description', 
  and 1 Role record with the attribute 'role_description'.
  """
  categories = seed_sequence_data(Category, ["name", "description"], 4)
  roles = seed_sequence_data(Role, ["role_description"], 1)

  # The create_user_with_password function creates a new User record with the given username, email, password, and role.
  user = create_user_with_password("admin", "admin@admin.com", "admin", roles[0])

  # The seed_child_data function creates child records for a given list of parent records. 
  # In this case, it creates 1 Student record for the user, 1 Journey record for the student, and 3 Planet records for the journey.
  students = seed_child_data([user], Student, ["firstName", "lastName", "phone", "address"], 1)
  journeys = seed_child_data(students, Journey, [], 1)
  planets = seed_child_data(journeys, Planet, ["name"], 3)

  # Finally, the loop iterates through each category and creates a new Section record, linking it to the current category and the first planet.
  categories.each do |category|
    create_record(Section, {
      category_id: category.id,
      planet_id: planets[0].id,
    })
  end
end
