# frozen_string_literal: true

Rack::Timeout.timeout = (ENV['TIMEOUT_IN_SECONDS'] || 30).to_i
