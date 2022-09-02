module PowerRankingsHelper
  def edit_label(power_ranking)
    power_ranking.rankings.empty? ? 'Add Rankings' : 'Edit Rankings'
  end

  def weeks_column(index:)
    add = index + 1

    if add == 4
      add = 1
      index = 0
    elsif add == 10
      add = 1
      index = 0
    else
      "finish writing method"
    end

    start = index + add
    end_col = start + 2

    "col-start-#{start} col-end-#{end_col}"
  end
end
