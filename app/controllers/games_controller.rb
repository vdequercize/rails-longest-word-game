require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    charset = ('A'..'Z').to_a
    @letters = Array.new(10) { charset.sample }.join(" ")
  end

  def score
    attempt = params["answer"]
    if attempt.upcase!.chars.all? { |letter| attempt.count(letter) > params["letters"].count(letter) }
      @score = "These letters were not in the grid"
  elsif
    dictionnay_return_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{attempt}").read
    dictionary_return = JSON.parse(dictionnay_return_serialized)
    dictionary_return.key?("error") ? @score = "This is not an english word" : @score = "Well done, #{attempt} is an english word from the grid"
    end
  end
end
