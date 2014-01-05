require "debugger"

def load_dictionary()
  File.readlines("dictionary.txt").map(&:chomp)

end

def find_adjacent_words(word, dictionary)
  dictionary.select do |dictionary_word|
    match = 0
    word.length.times do |index|
      match += 1 if word[index] == dictionary_word[index]
    end
    match == word.length - 1 
  end
end

def find_chain(start_word, end_word, dictionary)
  word_list = dictionary.select { |word| word.length == start_word.length }

  current_words = [start_word]
  visited_words = {start_word => true}

  until current_words.empty?
    word = current_words.shift

    adjacent_words = find_adjacent_words(word, word_list)
    adjacent_words = adjacent_words.select { |next_word| !visited_words.has_key?(next_word)}

    adjacent_words.each do |word1|
      visited_words[word1] = word

      if word1 == end_word
        puts build_chain(visited_words, word1).reverse
        return "FOUND MATCH"
      end

    end
    current_words += adjacent_words

  end

  puts "NO MATCH POSSIBLE"
end

def build_chain(visited_words, word)
  return [word] if visited_words[word] == true
  [word] + build_chain(visited_words, visited_words[word])
end