require_relative '../http'

describe HTTP::Request do
  context "GET request" do
    before(:each) do
      double_socket = double 'Socket'
      arr = [
        "GET / HTTP/1.1",
        "Content-Length: 200",
        ""
      ]
      double_socket.stub(:gets) { arr.shift }
      @req = HTTP::Request.new(double_socket)
    end
    
    it "Get headers" do
      @req.headers.should == {"Content-Length" => "200", nil=>nil}
    end
    
    it "Get path" do
      @req.path.should == "/"
    end
    
    it "Get request" do
      @req.request.should == "GET"
    end
    
    it "Get version" do
      @req.version.should == "HTTP/1.1"
    end
  end
end

describe HTTP::Response do
  context 'Basic response' do
    context 'Test empty attributes' do
      it 'Default headers' do
        subject.headers.should == {}
      end
      
      it 'Default code' do
        subject.code.should == 200
      end
      
      it 'Default code message' do
        subject.code_message.should == 'OK'
      end
      
      it 'Default response' do
        @res = <<-RES
200 HTTP/1.1 OK
Content-Length: 0
Content-Type: text/plain

RES
        subject.to_s.should == @res
      end
    end
  end
end