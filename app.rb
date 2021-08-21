require_relative 'middleware/gettime'

class App

	def call(env)
		def call(env)
    @request = Rack::Request.new(env)

    result = GetTime.new(@request.params['format']).call
    @response = if result.success?
                  Rack::Response.new(result.body, 200)
                else
                  Rack::Response.new(result.body, 400)
                end

    @response.finish
  end
	end
end
