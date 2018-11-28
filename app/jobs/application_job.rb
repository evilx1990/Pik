class ApplicationJob < ActiveJob::Base
  self.queue_adapter = :resque
  queue_as :mailer
end
