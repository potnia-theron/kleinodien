# Serves the constant DATE_ACCURACY_MASK
# https://stackoverflow.com/questions/22894649/rails-partial-dates
module DateAccuracy
  DATE_ACCURACY_MASK = {year: 4, month: 6, day: 7}.freeze
  DATE_ACCURACY_VALUES = DATE_ACCURACY_MASK.map { |key, value| [key, key.to_s, value] }.flatten.freeze
end
