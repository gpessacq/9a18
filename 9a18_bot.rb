require 'twitter'
require 'yaml'

progress_multiplier = 11
progress_mark = "\u{2588}"
remainder_mark = "\u{2591}"

config_dir = 'config'
config = YAML.load(File.read("#{config_dir}/twitter.yml"))
twitter = Twitter::REST::Client.new(config.map { |key, value| [key.to_sym, value] })

right_now = Time.now.getlocal("-03:00")
current_hour = right_now.hour
times_multiplier = current_hour - 9

the_progress = times_multiplier * progress_multiplier
the_progress_unit = the_progress / 5
the_remainder_unit = 20 - the_progress_unit

if times_multiplier >= 9
  the_progress_unit = 20
  the_remainder_unit = 0
  the_progress = 100
end

progressbar = "#{progress_mark * the_progress_unit}#{remainder_mark * the_remainder_unit} #{the_progress}%"

if current_hour.between?(9,18) and right_now.wday.between?(1,5)
  twitter.update(progressbar)
end
