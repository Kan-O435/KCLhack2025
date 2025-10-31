class HeaderSanitizer
  def initialize(app)
    @app = app
  end

  def call(env)
    begin
      status, headers, body = @app.call(env)
    rescue => e
      # If app crashes, re-raise
      raise
    end

    # Rebuild response using Rack::Response to sanitize headers automatically
    response = Rack::Response.new([], status, {})
    
    # Safely copy headers - catch any nil key errors
    begin
      if headers.is_a?(Hash)
        headers.each do |key, value|
          next if key.nil? || key.to_s.strip.empty?
          response.set_header(key.to_s, value.to_s)
        end
      elsif headers.respond_to?(:to_ary)
        # Array of [key, value] pairs
        headers.to_ary.each do |pair|
          next unless pair.is_a?(Array) && pair.length == 2
          key, value = pair
          next if key.nil? || key.to_s.strip.empty?
          response.set_header(key.to_s, value.to_s)
        end
      else
        # Try each_pair if available
        headers.each_pair do |key, value|
          next if key.nil? || key.to_s.strip.empty?
          response.set_header(key.to_s, value.to_s)
        end
      end
    rescue => e
      # If header copying fails, try minimal sanitization
      sanitized = {}
      if headers.is_a?(Hash)
        headers.each do |key, value|
          next if key.nil?
          sanitized[key.to_s] = value.to_s
        end
      end
      response.headers.replace(sanitized)
    end

    # Write body and return
    body.each { |chunk| response.write(chunk) } if body.respond_to?(:each)
    
    response.finish
  end
end


