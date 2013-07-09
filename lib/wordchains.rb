require "wordchains/version"

class Hash
    def sort_by_values
        self.sort {|a,b| a[1] <=> b[1] }
    end
end

module Wordchains

    class Solver
        def initialize(word_list)
            @word_list = word_list
        end

        def find_path(from, to)
            @word_list.delete from

            path = [from]
            while path.last != to
                word = suitable_next_word(path, path.last, to)
                if word != nil
                    path << word
                else 
                    raise Exception.new('unsolvable') if path == [from]
                    @word_list.delete path.pop
                end
            end
            path
        end

        def suitable_next_word(words_in_path, cur_word, target)
            candidates = {}
            possible_next_words(words_in_path, cur_word, target).each do |word|
                candidates[word] = WordDiff.distance_between(word, target)
            end
            return nil if candidates.empty?
            candidates.sort_by_values.first[0]
        end

        def possible_next_words(words_in_path, cur_word, target)
            @word_list.select do |word|
                not words_in_path.include? word and WordDiff.distance_between(word, cur_word) == 1
            end
        end
    end

    class WordDiff
        def self.distance_between(a,b)
            differences = 0
            (0..a.size).each do |letter_index|
                differences += 1 if  a[letter_index] != b[letter_index]
            end
            differences
        end
    end

end
