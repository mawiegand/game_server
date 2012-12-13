class Ranking::AllianceRanking < ActiveRecord::Base
  
  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :ranking

  scope :non_empty, where('num_members > 0')

  def self.update_ranks(sort_field=:overall_score, rank_field=:overall_rank)
    rankings = Ranking::AllianceRanking.find(:all, :order => "#{sort_field.to_s} DESC")
    rank = 1
    rankings.each do |entry| 
      entry[rank_field] = rank
      entry.save
      rank += 1
    end
  end

end
