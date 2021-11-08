require 'json'
require 'open-uri'

class GameController < ApplicationController
  def new
    @grid = []
    @letters = ('a'..'z').to_a
    10.times do
      @grid << @letters.sample
    end
  end

  def score
    @input = params[:answer]
    @grid = params[:grid]
    url = "https://wagon-dictionary.herokuapp.com/#{@input}"
    user_serialized = URI.open(url).read
    presence = JSON.parse(user_serialized)
    @result = if presence["found"] && validate(@input)
                "Congratulation! #{@input} is a valid english word!"
              else
                "Sorry but #{@input} does not seem to be a valid English word..."
              end
  end

  def validate(input)
    split = input.split(//)
    split.each do |letter|
      letter.include?(@grid)
    end
  end
end
