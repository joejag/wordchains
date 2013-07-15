require_relative 'wordchains/word_diff.rb'
require_relative 'wordchains/iterative.rb'
require_relative 'wordchains/tree.rb'

class Hash
    def sort_by_values
        self.sort {|a,b| a[1] <=> b[1] }
    end
end

module Wordchains
    def read_dictionary(max_word_length)
        a = []
        open('dictionary.txt').each_line { |word| a << word.chomp }
        a.select { | word| word.size == max_word_length}
    end
end
