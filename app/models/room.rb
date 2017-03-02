class Room < ApplicationRecord
  validates :name, uniqueness: true, presence: true, length: { minimum: 4, maximum: 16}
end
