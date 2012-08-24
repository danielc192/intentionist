class SearchController < ApplicationController
  def index
  end


  def create
    if params[:intent] == "eat" then 
      @output_type = "restaurant_name"
    end
    
    @node = Node.first
    begin
       @node = Node.find_by_output_type(@output_type)
       if @node.input_type == "address" then break
         else
           @node = Node.find_by_output_type(@node.input_type)
         end
    end while @node.input_type != "address"
    
    @result = [[params[:query], "query"], [params[:address], "address"]]
    
    while true
      @node.input = @result
      @result << @node.provider.execute(@node.output_type)
      if @node.output_type == @output_type then
        break
      end
      @node = Node.find_by_input_type(@node.output_type)
    end
   end
end
