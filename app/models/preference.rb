class Preference < ApplicationRecord
  belongs_to :person, class_name: 'Person'
  belongs_to :preferred_person, class_name: 'Person'
end
