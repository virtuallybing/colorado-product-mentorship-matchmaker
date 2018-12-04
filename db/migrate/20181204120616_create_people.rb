class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.boolean :is_mentor, default: false
      t.boolean :is_mentee, default: false

      t.timestamps
    end
  end
end
