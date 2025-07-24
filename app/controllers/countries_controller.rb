class CountriesController < ApplicationController
  def index
    @countries = Country.order(:name)
  end
end
