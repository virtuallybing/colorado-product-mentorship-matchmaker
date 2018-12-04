class Person < ApplicationRecord
  has_many :preferences
  has_many :preferred_people, through: :preferences, source: 'preferred_person'

  scope :mentors, -> { where(is_mentor: true).order(created_at: :asc) }
  scope :mentees, -> { where(is_mentee: true).order(created_at: :asc) }
end
