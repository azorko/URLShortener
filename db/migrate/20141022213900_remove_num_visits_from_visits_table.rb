class RemoveNumVisitsFromVisitsTable < ActiveRecord::Migration
  def up
    remove_column :visits, :num_visits
  end
  
  def down
  end
end
