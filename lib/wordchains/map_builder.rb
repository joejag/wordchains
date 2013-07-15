class MapBuilder

    def initialize(dictionary)
        @dictionary = dictionary
    end

    def nearby_words target 
        @dictionary.select do |word|
            WordDiff.distance_between(word, target) == 1
        end
    end

    def build
        result = {}
        @dictionary.each do |word|
            result[word] = nearby_words(word)
        end
        result
    end

    def best_match_from_possibilities(possible, target)
        candidates = {}
        possible.each { |word| candidates[word] = WordDiff.distance_between(word, target) }
        candidates.sort_by_values.first[0]
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
