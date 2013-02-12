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
    

end