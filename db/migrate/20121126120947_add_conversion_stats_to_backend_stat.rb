class AddConversionStatsToBackendStat < ActiveRecord::Migration
  def up
    add_column :backend_stats, :total_logged_in_once,   :integer, :default => 0, :null => false
    add_column :backend_stats, :total_ten_minutes,      :integer, :default => 0, :null => false
    add_column :backend_stats, :total_second_day,       :integer, :default => 0, :null => false
    add_column :backend_stats, :total_active,           :integer, :default => 0, :null => false
    add_column :backend_stats, :total_long_term_active, :integer, :default => 0, :null => false
    
    Backend::Stat.all.each do |stat|
      stat.total_logged_in_once   = Fundamental::Character.non_npc.where(["created_at < ?", stat.created_at]).logged_in_once.count
      stat.total_ten_minutes      = Fundamental::Character.non_npc.where(["created_at < ?", stat.created_at]).ten_minutes.count
      stat.total_second_day       = Fundamental::Character.non_npc.where(["created_at < ?", stat.created_at]).second_day.count
      stat.total_active           = Fundamental::Character.non_npc.where(["created_at < ?", stat.created_at]).active.count
      stat.total_long_term_active = Fundamental::Character.non_npc.where(["created_at < ?", stat.created_at]).long_term_active.count
      stat.save
    end
  end
  
  def down
    remove_column :backend_stats, :total_logged_in_once
    remove_column :backend_stats, :total_ten_minutes
    remove_column :backend_stats, :total_second_day
    remove_column :backend_stats, :total_active
    remove_column :backend_stats, :total_long_term_active
  end
end
