#!/usr/bin/env ruby

require 'test/unit'

def palindrome?(str)
    str = str.tr('^A-Za-z','').downcase
    str.reverse == str
end

def count_words(str)
    str = str.tr('^A-Za-z',' ').downcase

    hash = Hash.new(0)
    if str.respond_to?("split")
        str.split(" ").each do |word|
                hash[word] += 1
        end
    end
     hash
end

def same23?(array)

    hash = Hash.new(0)
    for i in array
            hash[i] += 1
    end
     (hash.length == 2) && (((hash.values[0] == 2) && (hash.values[1] == 3)) ||
                                  ((hash.values[0] == 3) && (hash.values[1] == 2)))
end

class Testing < Test::Unit::TestCase
    def test_simple

        #palindrome?
        assert_equal(true, palindrome?("A man, a plan, a canal -- Panama"))
        assert_equal(true, palindrome?("Madam, I'm Adam!"))
        assert_equal(false, palindrome?("Abracadabra"))
        assert_equal(true, palindrome?(""))

        #count_words
        assert_equal({"a"=>3, "man"=>1, "plan"=>1, "canal"=>1, "panama" =>1},
            count_words("A man, a plan, a canal -- Panama"))
        assert_equal({"some"=>2, "meaningless"=>1, "words"=>2, "and"=>1, "more"=>1},
            count_words("Some meaningless words, and some more words."))


        #same23?
        assert_equal(true, same23?(["a", "a", "a", "b", "b"]))
        assert_equal(false, same23?(["a", "b", "c", "b", "c"]))
        assert_equal(false, same23?(["a", "a", "a", "a", "a"]))
        assert_equal(true, same23?(["b", "b", "b", "a", "a"]))
        #assert_equal(true, same23?(["b", "b", "b", "a", "a","a"]))
    end
end