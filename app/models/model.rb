class Model < ApplicationRecord
  has_many :shoes
  validates :name, uniqueness: true

  def self.find_or_create! name
    find_by_name(name) || create!(name: name) 
  end
end
