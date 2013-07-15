require 'wordchains'
include Wordchains

describe WordDiff do

    describe "#distance_between" do
        context "lets you know the letters difference between two words" do

            it "should say when all the letters are different" do
                WordDiff.distance_between('cat', 'dog').should eq 3
            end

            it "should say no difference given the same word" do
                WordDiff.distance_between('cat', 'cat').should eq 0
            end
        end
    end

end
