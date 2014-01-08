module TsmFetcher
  def self.start
    Thread.new do
      EM.run do
        puts "EmTester says hello from puts"
        Rails.logger.info "EmTester says hello from Rails.logger"
        # Tsm.refresh
        EM::PeriodicTimer.new(300) do
          puts "EmTester says hello from puts"
          Rails.logger.info "EmTester says hello from Rails.logger"
          # Tsm.refresh
        end
      end
    end
    die_gracefully_on_signal
  end

  def self.die_gracefully_on_signal
    Signal.trap("INT")  { EM.stop }
    Signal.trap("TERM") { EM.stop }
  end

end

TsmFetcher.start