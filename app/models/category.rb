class Category < ApplicationRecord
  validates_presence_of :name
  has_many :restaurants, dependent: :nullify
  # has_many :restaurants, dependent: :restrict_with_exception
  # has_many :restaurants, dependent: :restrict_with_error
end
