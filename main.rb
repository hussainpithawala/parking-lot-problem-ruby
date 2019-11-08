Dir[File.join(__dir__, "./lib/**/*.rb")].each do |file|
  require file
end

filename = ARGV[0]

command_processor = ::Processor::CommandProcessor.new
File.foreach(filename).with_index do |line|
  puts command_processor.process(line)
end