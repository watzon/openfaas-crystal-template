require "json"

module Handler
  def self.run(req : String)
    return JSON::Any.new("Hello, Crystal. You said: #{req}")
  end
end
