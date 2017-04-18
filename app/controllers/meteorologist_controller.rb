require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_no_space = @street_address.gsub(" ","+")
    url_coordinates = "https://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_no_space}"
      # ==========================================================================
      # Your code goes below.
      #
      # The street address that the user typed is in the variable @street_address.
      # ==========================================================================
      parsed_data_coordinates = JSON.parse(open(url_coordinates).read)
      @latitude = parsed_data_coordinates["results"][0]["geometry"]["location"]["lat"]
      @longitude = parsed_data_coordinates["results"][0]["geometry"]["location"]["lng"]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    url_weather = "https://api.darksky.net/forecast/2a9e6b19b6c5121e0c6cc9516f670783/#{@latitude},#{@longitude}"

    parsed_data_weather = JSON.parse(open(url_weather).read)
    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================



    @current_temperature = parsed_data_weather["currently"]["temperature"]

    @current_summary = parsed_data_weather["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_weather["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_weather["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_weather["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
