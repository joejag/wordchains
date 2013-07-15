require_relative 'wordchains/word_diff.rb'
require_relative 'wordchains/iterative.rb'

class Hash
    def sort_by_values
        self.sort {|a,b| a[1] <=> b[1] }
    end
end

module Wordchains
end
