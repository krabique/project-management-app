class Project < ApplicationRecord
  serialize :developers, Array
  serialize :managers, Array
end
