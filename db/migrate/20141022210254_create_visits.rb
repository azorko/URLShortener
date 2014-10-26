class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :submitted_url_id
      t.integer :submitter_id
      t.integer :num_visits
      t.timestamps
    end
  end
end
