class MapBuilder

    def initialize(dictionary)
        @dictionary = dictionary
    end

    def nearby_words(dictionary, target)
        dictionary.select do |word|
            WordDiff.distance_between(word, target) == 1
        end
    end

    def build
        result = {}
        @dictionary.each do |word|
            result[word] = []
        end

        result.keys.each do |word|
            result.keys.each do |known_word|
                if WordDiff.distance_between(word, known_word) == 1
                    result[known_word] << word
                end
            end
        end
        result
    end

    def best_match_from_possibilities(possible, target)
        Iterative.new(@dictionary).best_match_from_possibilities(possible, target)
    end

    def find_path(from, to)
        path = [from]
        @tree = build()
        while path.last != to
            words = @tree[path.last]
            if not words.empty?
                path << best_match_from_possibilities(words, to)
            elsif path == [from]
                raise Exception.new('unsolvable')
            else
                # backtrack
                @tree[path.last].delete path.pop
            end
        end
        path
    end

end
