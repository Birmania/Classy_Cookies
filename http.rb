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
      @text = ""
      @headers = {}
      @code = 200
      @code_message = "OK"
    end
    
    def write(text)
      @text += text
    end
    
    attr_accessor :code
    attr_accessor :code_message
    attr_accessor :headers
    
    def to_s
      rval = []
      
      rval.push(@code.to_s + " HTTP/1.1 " + @code_message)
      rval.push("Content-Length: #{@text.length}")
      rval.push("Content-Type: text/plain")
      @headers.each{|header,value| rval.push("#{header}: #{value}")}
      rval.push("")
      rval.push(@text)
      
      rval.join("\n")
    end
  end
end