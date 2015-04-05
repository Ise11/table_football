json.array!(@matches) do |match|
  json.extract! match, :id, :winner, :loser, :match_date, :loser_score
  json.url match_url(match, format: :json)
end
