class String
  def is_number?
    true if Float(self) rescue false
  end
end

class Provider < ActiveRecord::Base
  attr_accessible :apikey, :name, :url, :read_chain
  has_many :nodes

  def inputs=(input)
    @inputs = input
  end

  def inputs
    @inputs
  end

  def generate_url
    url = self.url
    url.scan(/%(\w+)%/).each do |type|
      if url.scan(/%(\w+)%/) then
        inputs.each do |input|
          if input[1].to_s.downcase == type[0].downcase then
            url.sub!("%#{input[1]}%", input[0])
          end
        end
      end
    end
      unless self.apikey.empty? then
        url += "&key=" + self.apikey
      else
        url
      end
  end

  def execute(output_type)
    clnt = HTTPClient.new
    result = JSON.parse(clnt.get_content(URI.encode(self.generate_url)))
    w = result
    self.read_chain.split(",").each do |s|
      if /\[(.*)\]/.match(s).nil? then
        if s.is_number? then
          w = w[s.to_i]
        else
          w = w[s.strip]
        end
      else
        ret = []
        s.split(";").each do |s|
          s.gsub!(/[\[\]]/, "")
          ret << w[s.strip]
        end
        return [ret.join(","), output_type]
      end
   end
  end
end
