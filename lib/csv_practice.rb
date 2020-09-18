require 'csv'
require 'awesome_print'

def get_all_olympic_athletes(filename)
  athletes_array_of_hashes = CSV.read("data/athlete_events.csv", headers: true).map(&:to_h)
  athletes_array_of_hashes.map do |athlete|
    athlete.select! { |key, value| %w(ID Name Height Team Year City Sport Event Medal).include? key }
  end
  return athletes_array_of_hashes
end

def total_medals_per_team(olympic_data)
  medals_per_team = {}
  olympic_data.map do |athlete|
    country = athlete["Team"]
    if %w(Gold Silver Bronze).include?(athlete["Medal"])
      if medals_per_team.has_key?(country)
        medals_per_team[country] += 1
      else
        medals_per_team[country] = 1
      end
    end
  end
  return medals_per_team
end

def get_all_gold_medalists(olympic_data)
  gold_medalists = olympic_data.select { |athlete| athlete["Medal"] == "Gold"}
  return gold_medalists
end