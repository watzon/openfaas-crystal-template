require "./function/handler"

request = STDIN.gets_to_end
response = Handler.run(request)

puts response
