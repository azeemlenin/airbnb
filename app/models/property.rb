class Property < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :tag
end
