class CreatePreferences < ActiveRecord::Migration[5.2]
  def change
    create_table :preferences do |t|
      t.integer :person_id
      t.integer :preferred_person_id
      t.integer :rank

      t.timestamps
    end
  end
end
