require "sinatra"
require "pry"


def get_words(word)
  @words = File.readlines("shakespeare-complete.txt").map(&:strip).reject(&:empty?)

  @new_words = []
  @words.each do |word|
    @word = word.downcase.gsub(/[^A-Za-z ]/, '')
    @new_words << @word
  end

  single_array = @new_words.reduce(:concat)

  better_array = single_array.split(' ')

  occurance = better_array.each_with_object(Hash.new(0)) { |word,counts| counts[word] += 1 }
end

def find_matches(word, occurance)
  first_characters = word[0..1]
  @matches = []
  if occurance[first_characters].nil? || occurance[first_characters] == 0
    flash[:notification] = "Sorry, no match! Choose again."
  else
    occurance.each do |key, value|
      if key[0..1] == first_characters
        @matches << key
      end
    end
  end
end

def display_matches
  ##limit to 25 most used
end

get "/" do
  erb :index
end


get "/search" do
  word = params[:search]
  occurance = get_words(word)
  @matches = find_matches(word, occurance)
  erb :results
end
