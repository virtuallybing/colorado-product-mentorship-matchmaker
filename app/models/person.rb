class Person < ApplicationRecord
  has_many :preferences
  has_many :preferred_people, through: :preferences, source: 'preferred_person'

  scope :mentors, -> { where(is_mentor: true).order(created_at: :asc) }
  scope :mentees, -> { where(is_mentee: true).order(created_at: :asc) }

  def rank_of(preferred_person_id)
    @ranks ||= Hash[preferences.pluck(:preferred_person_id, :rank)]
    @ranks.fetch(preferred_person_id) { Float::INFINITY }
  end
end
