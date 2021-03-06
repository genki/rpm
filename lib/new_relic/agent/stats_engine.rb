require 'new_relic/agent/stats_engine/metric_stats'
require 'new_relic/agent/stats_engine/samplers'
require 'new_relic/agent/stats_engine/transactions'

module NewRelic::Agent
  class StatsEngine
    include MetricStats
    include Samplers
    include Transactions
    # race condition
#    include Transactions::Shim if NewRelic::Control.instance['disable_scope_tracking']
    
    def initialize
      # Makes the unit tests happy
      Thread::current[:newrelic_scope_stack] = nil
      spawn_sampler_thread
    end
    
    def log
      NewRelic::Control.instance.log
    end
    
  end
end
