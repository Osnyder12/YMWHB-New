module PowerRankingsHelper
  def edit_label(power_ranking)
    power_ranking.rankings.empty? ? 'Add Rankings' : 'Edit Rankings'
  end

  def weeks_column(index:)
    beginning = [0, 4, 8, 12, 16 ]
    left_middle = [1, 5, 9, 13, 17]
    right_middle = [2, 6, 10, 14]
    last = [3, 7, 11, 15]

    if beginning.include?(index)
      start = 1
      end_col = 2
    elsif left_middle.include?(index)
      start = 2
      end_col = 3
    elsif right_middle.include?(index)
      start = 3
      end_col = 4
    elsif last.include?(index)
      start = 5
      end_col = 6
    end

    "col-start-#{start} col-end-#{end_col}"
  end
end
