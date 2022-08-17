module PowerRankingsHelper
  def edit_label(power_ranking)
    power_ranking.rankings.empty? ? 'Add Rankings' : 'Edit Rankings'
  end
end
