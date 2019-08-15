# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

set :output, {:error => '~/Desktop/z.error.log', :standard => '~/Desktop/z.standard.log'}

every :minute do
  runner "Order.find_by(status: :cart).where('created_at < ?', 1.minute.ago)"
end

# Learn more: http://github.com/javan/whenever
