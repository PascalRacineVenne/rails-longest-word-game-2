require 'open-uri'

class GamesController < ApplicationController
  
  def new
    vowels = %w[A E I O U Y]
    @letters = Array.new(5) { vowels.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - vowels).sample }
    @letters = @letters.shuffle
  end

  def score
    # get all the letters in an array
    @letters = params[:letters].split
    # create an instance variable with the answer.upcse
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @is_english = is_english?(@word)
  end

  def included?(word, letters)
    # iterate over each character of the word
    word.chars.all? do |letter|
      # for each letter count how many times they're contained in word and letters
      # and compare it to make sure that it's not exceeding the possibilities.
      word.count(letter) <= letters.count(letter)
    end
  end

  def is_english?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = URI.open(url).read
    data = JSON.parse(response)
    data['found']
  end

end
