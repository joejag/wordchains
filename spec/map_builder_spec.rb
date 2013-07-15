require 'wordchains'
include Wordchains

describe MapBuilder do

    context "building a tree data structure of dictionary words" do
        describe "#nearby_words" do
            it 'should return a list of mutable words for a given word' do
                subject = MapBuilder.new(%w(bat mat zoo))
                subject.nearby_words('cat').should eq %w(bat mat)
            end
            it "should not include the given word in the list" do
                subject = MapBuilder.new(%w(bat mat zoo))
                subject.nearby_words('bat').should eq %w(mat)
            end
        end

        describe "#build" do
            it "should make a map of all the nearby words" do
                expected = {'bat' => %w(mat), 'mat' => %w(bat), 'zoo' => []}
                subject = MapBuilder.new(%w(bat mat zoo))
                subject.build.should eq expected
            end
        end
    end

    context "#find_path" do
        it "should handle unsolvable problems" do
            subject = MapBuilder.new([])
            expect { subject.find_path('cat', 'dog') }.to raise_error
        end

        it "should solve answers given a linear dictionary" do
            subject = MapBuilder.new %w(cat cot cog dog)
            subject.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        it "should backtrack to a solution given a non linear dictionary" do
            subject = MapBuilder.new %w(cat cam cot cog dog)
            subject.find_path('cat', 'dog').should eq %w(cat cot cog dog)
        end

        context "solving the problem" do
            it "can turn lead into gold" do
                subject = MapBuilder.new read_dictionary(4)
                subject.find_path('lead', 'gold').should eq %w(lead load goad gold)
            end
        end
    end

end
