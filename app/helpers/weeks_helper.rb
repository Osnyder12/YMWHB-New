module WeeksHelper
  def pr_avatar(power_ranking:)
    power_ranking.avatar.url.nil? ? 'burrow.png' : power_ranking.avatar.url
  end
end