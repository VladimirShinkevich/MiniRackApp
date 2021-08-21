class GetTime

	TIME_FORMAT = {
		'year' => '%Y',
		'month' => '%m',
		'day' => '%d',
		'hour' => '%H',
		'minute' => '%M',
		'second' => '%S'
	}.freeze

	Result = Struct.new(:body) do 
		def success?
			body.include?('-')
		end
	end

	def initialize(data)
		@data = data
	end

	def call
		if !@data.nil?
			return Result.new(convert_user_format) if valid_input_data?
			Result.new("Unknown time format - #{unknown_time_format}")
		else
			Result.new("Invalid time format")
		end
	end

	private

	def valid_input_data?
		(@data.split(',') - TIME_FORMAT.keys).empty?
	end

	def unknown_time_format
		@data.split(',') - TIME_FORMAT.keys
	end

	def convert_user_format
		format = @data.split(',').reduce(' ') do |sum, param|
			"#{sum}#{TIME_FORMAT}-"
		end

		Time.now.strftime(format)
	end
end