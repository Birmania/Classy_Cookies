module HTTP
  class Request
    
    def initialize(socket)
      @socket = socket
      
      # request parsing
      @request, @path, @version = socket.gets.chomp.split(" ")
      
      @headers = {}
      begin
        header = socket.gets
        header_name, header_val = header.chomp.split(': ')
        @headers[header_name] = header_val
      end until header.chomp.empty?
    end
    
    attr_accessor :headers
    
    attr_accessor :path
    
    attr_accessor :request
    
    attr_accessor :version
  end
    
  class Response
    def initialize()
      @headers = {}
      @code = 200
      @code_message = "OK"
    end
    
    attr_reader :code
    attr_reader :code_message
    attr_reader :headers
    
    def to_s
      rval = <<-RES
200 HTTP/1.1 OK
Content-Length: 0
Content-Type: text/plain

RES
    end
  end
end