class CreateBackendTutorialStats < ActiveRecord::Migration
  def up
    create_table :backend_tutorial_stats do |t|
      t.integer :cohort_size, :default => 0, :null => false
      t.timestamps
    end
    
    Backend::Stat.all.each do |stat|
      ts = Backend::TutorialStat.create
      ts.created_at  = stat.created_at
      ts.cohort_size = stat.dnu 
      ts.save
    end
    
  end
  
  def down
    drop_table :backend_tutorial_stats
  end
end
