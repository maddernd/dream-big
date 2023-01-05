require "csv"
require "faker"
I18n.reload!

# The data can be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

def read_csv_path_for_model(file_name)
  Rails.root.join('db', 'resources', "#{file_name}.csv")
end

# The attributes must match the database schema
# Used to pass only specific values from the csv in an object format.
def import_from_csv(model, attributes)
  model_name_as_lowercase = "#{model}".downcase
  plural_model_name = model_name_as_lowercase[-1] == 'y' ? "#{model_name_as_lowercase.delete_suffix('y')}ies" : "#{model_name_as_lowercase}s"
  path = read_csv_path_for_model(plural_model_name)

  CSV.foreach(path, headers: true).map do |row|
    item = {}

    attributes.each do |attr|
      item[attr] = row[attr]
    end

    model.insert(item)
  end
end

def seed_data_parent_child(parent_model, parent_attributes, child_model, child_attributes, num)
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

def seed_child_data(parent_items, child_model, child_attributes, num_per_parent=1)
  items = []
  parent_items.each do |parent_item|
    for i in 1..num_per_parent
      child_item = {}
      parent_name = parent_item.class.name.scan(/[A-Z][a-z]+/).join("_")
      child_item["#{parent_name}_id".downcase] = parent_item.id
      child_attributes.each do |attr|
        child_item[attr] = "#{parent_item.id}"
      end
      child_item = child_model.create(child_item)
      child_item.save!
      items.append(child_item)
    end
  end

  puts "Seeded #{parent_items.length()} #{child_model} records"
  return items
end

def seed_sequence_data(model, attributes, num)
  items = []
  last_id = model.last ? model.last.id : 0
  for i in last_id+1..num+last_id
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

import_from_csv(User, ['name', 'username','email','password_digest'])
