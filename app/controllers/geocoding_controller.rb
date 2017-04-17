require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end


  def street_to_coords
    @street_address = params[:user_street_address]
    @street_address_string = @street_address.to_s
    @street_address_no_space = @street_address.gsub(" ","+")



    url = "https://maps.googleapis.com/maps/api/geocode/json?address="+"@street_address_no_space"
      # ==========================================================================
      # Your code goes below.
      #
      # The street address that the user typed is in the variable @street_address.
      # ==========================================================================

      parsed_data = JSON.parse(open(url).read)


      @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

      @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

      render("geocoding/street_to_coords.html.erb")
    end
  end
