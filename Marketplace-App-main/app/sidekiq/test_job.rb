class TestJob
  include Sidekiq::Job

  def perform(*args)
    puts "funciona ", (args)
  end
end
