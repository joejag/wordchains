require 'wordchains'
include Wordchains

describe Iterative do

    describe "#possible_next_words" do 
        it "should return all possible next words" do
            s = Iterative.new(%w(bat mat zoo))
            s.possible_next_words(%w(cat), 'cat').should eq %w(bat mat)
        end

        it "should not suggest words we have already used" do
            s = Iterative.new(%w(cat bat))
            s.possible_next_words(%w(cat), 'cat').should eq %w(bat)
        end
    end

    describe "#best_match_from_possibilities" do
        it "should suggest the word with the least distance to the target word" do
            s = Iterative.new(%w(bat mat))
            s.next_word([], 'cat', 'mat').should eq 'mat'
        end
    end

    describe "#next_word" do 
        it "should use #possible_next_words & #best_match_from_possibilities to find next word" do
            s = Iterative.new(%w(bat mat))
            s.best_match_from_possibilities(%w(bat mat), 'but').should eq 'bat'
        end
    end

    describe "#find_path" do
        it "handles unsolvable problems" do
            s = Iterative.new([])
            expect { s.find_path('cat', 'dog') }.to raise_error
        end
        it "can solve answers given a linear dictionary" do
            s = Iterative.new(%w(cat cot cog dog))
            s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        it "can backtrack to a solution" do
            s = Iterative.new(%w(cat cam cot cog dog))
            s.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        context "solving the problem" do
            it "can turn lead into gold" do
                s = Iterative.new read_dictionary(4)
                s.find_path('lead', 'gold').should eq %w(lead load goad gold)
            end
        end
    end


end
