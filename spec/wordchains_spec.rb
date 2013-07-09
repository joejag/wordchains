require 'wordchains'

include Wordchains

describe Wordchains do

    it "tells you the letters diference between two words" do
        WordDiff.diff?('cat', 'dog').should eq 3
        WordDiff.diff?('cat', 'cat').should eq 0
    end

    it "solves cat to dogs" do
        s = Solver.new(%w(cat cot cog dog))
        s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
    end

    it "handles unsolvable problems" do
        s = Solver.new([])
        s.find_path('cat', 'dog').should eq [] 
    end

    it "solves cat to dogs - bad path added" do
        s = Solver.new(%w(cat cam cot cog dog))
        s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
    end

    describe "#suitable_next_word" do 
        it "find best next option" do
          s = Solver.new(%w(cat bat mat))
          s.suitable_next_word([], 'cat', 'mat').should eq 'mat'
        end
    end

    it "can turn lead into gold" do
        a = []
        open('dictionary.txt').each_line { |word| a << word.chomp }
        dict = WordDiff.reduced_dict(a, 4)

        s = Solver.new dict
        s.find_path('lead', 'gold').should eq %w(lead load goad gold)
    end
end
