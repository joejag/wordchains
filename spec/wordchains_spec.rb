require 'wordchains'

include Wordchains

describe Wordchains do

    describe "WordDiff" do
        it "tells you the letters diference between two words" do
            WordDiff.distance_between('cat', 'dog').should eq 3
            WordDiff.distance_between('cat', 'cat').should eq 0
        end
    end

    describe "#suitable_next_word" do 
        it "find best next option" do
            s = Solver.new(%w(bat mat))
            s.suitable_next_word([], 'cat', 'mat').should eq 'mat'
        end
    end

    describe "#find_path" do
        it "handles unsolvable problems" do
            s = Solver.new([])
            expect { s.find_path('cat', 'dog') }.to raise_error
        end

        it "can solve answers in the same order in the wordlist" do
            s = Solver.new(%w(cat cot cog dog))
            s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        it "can backtrack to a solution" do
            s = Solver.new(%w(cat cam cot cog dog))
            s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        it "can turn lead into gold" do
            s = Solver.new read_dictionary(4)
            s.find_path('lead', 'gold').should eq %w(lead load goad gold)
        end

    end

    def read_dictionary(max_word_length)
        a = []
        open('dictionary.txt').each_line { |word| a << word.chomp }
        a.select { | word| word.size == max_word_length}
    end
end
