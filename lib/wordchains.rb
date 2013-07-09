require "wordchains/version"

module Wordchains
    class Solver

        def initialize(word_list)
            @word_list = word_list
        end

        def find_path(from, to)
            @word_list.delete from

            path = [from]
            while path.last != to
                candidate = suitable_next_word(path, path.last, to)
                if candidate != nil
                    path << candidate
                else 
                    return [] if path == [from]
                    @word_list.delete path.pop
                end
            end
            path
        end

        def suitable_next_word(path, cur_word, target)
            candidates = {}
            @word_list.each do |word|
                next if path.include? word
                next if WordDiff.diff?(cur_word, word) != 1
                candidates[word] = WordDiff.diff?(word, target)
            end

            return nil if candidates.size == 0
            candidates.sort {|a,b| a[1] <=> b[1] }.first[0]
        end
    end

    class WordDiff
        def self.reduced_dict(word_list, size_desired)
            word_list.select { | word| word.size == size_desired}
        end

        def self.diff?(a,b)
            differences = 0
            (0..a.size).each do |letter_index|
                differences += 1 if  a[letter_index] != b[letter_index]
            end
            differences
        end
    end
end
