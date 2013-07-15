class WordDiff
    def self.distance_between(a,b)
        differences = 0
        (0..a.size).each do |letter_index|
            differences += 1 if a[letter_index] != b[letter_index]
        end
        differences
    end
end
