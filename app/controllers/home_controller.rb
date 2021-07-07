class HomeController < ApplicationController
  def index
  end

  def zipcode
    @zip_query= params[:zipcode]

    if  params[:zipcode]==""
      @zip_query ="Please enter"
    elsif params[:zipcode]
      require 'net/http'
      require 'json'
     
      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' +@zip_query+ '&distance=0&API_KEY=7C687072-089F-42EA-AFA6-BF324B90580D'
      @uri= URI(@url)
      @response  = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)
  
      #chech for empty return result
      if @output.empty?
        @final_output="error"
      elsif !@output
        @final_output="error"
      else
        
     
          @final_output=@output[1]['AQI'] 
      
      end
          
      if @final_output =="error"
        @api_color="gray"

      elsif @final_output <=50
        @api_color = "green"
        @api_description="Good Air quality (0-50)"
      elsif @final_output >=51 && @final_output <=100
        @api_color ="yellow"
        @api_description="Moderate Air quality(51-100)"
      elsif @final_output >=101 && @final_output <=150
        @api_color ="orange"
        @api_description="Unhealthy for sensite groups (USG) (101-150)"
      elsif @final_output >=151 && @final_output <=200
        @api_color ="red"
        @api_description="Unhealthy Air quality (151-200)"
      elsif @final_output >=201 && @final_output <=300
        @api_color ="purple"
        @api_description="Very unhealthy Air quality(201-300)"
      elsif @final_output >=301 && @final_output <=500
        @api_color ="maroon"
        @api_description="Hazardous Air quality (301-500)"
      end



        
    end
  end
end
