module TsmFetcher
  def self.start
    Thread.new do
      EM.run do
        EM::PeriodicTimer.new(300) do
          Rails.logger.info "Refresh TSM data"
          Tsm.refresh
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