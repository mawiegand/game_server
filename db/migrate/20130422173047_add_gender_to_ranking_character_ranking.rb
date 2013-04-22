class AddGenderToRankingCharacterRanking < ActiveRecord::Migration
  def up
    add_column :ranking_character_rankings, :gender, :string

    Fundamental::Character.all.each do |character|
      unless character.ranking.nil?
        character.ranking.gender = character.gender
        character.ranking.save
      end
    end
  end

  def down
    remove_column :ranking_character_rankings, :gender
  end

end
