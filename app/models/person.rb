class Person < ApplicationRecord
  has_many :preferences
  has_many :preferred_people, through: :preferences, source: 'preferred_person'
end
