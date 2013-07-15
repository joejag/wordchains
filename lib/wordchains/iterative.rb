class Iterative

    def initialize(dictionary)
        @dictionary = dictionary
    end

    def find_path(from, to)
        @dictionary.delete from

        path = [from]
        while path.last != to
            word = next_word(path, path.last, to)
            if word != nil
                path << word
            elsif path == [from]
                raise Exception.new('unsolvable')
            else
                # backtrack
                @dictionary.delete path.pop
            end
        end
        path
    end

    def next_word(words_in_path, cur_word, target)
        possible = possible_next_words(words_in_path, cur_word)
        return nil if possible.empty?
        best_match_from_possibilities(possible, target)
    end

    def possible_next_words(words_in_path, cur_word)
        @dictionary.select do |word|
            not words_in_path.include? word and WordDiff.distance_between(word, cur_word) == 1
        end
    end

    def best_match_from_possibilities(possible, target)
        candidates = {}
        possible.each { |word| candidates[word] = WordDiff.distance_between(word, target) }
        candidates.sort_by_values.first[0]
    end
end
