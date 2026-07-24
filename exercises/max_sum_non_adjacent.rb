#!/usr/bin/env ruby

require 'minitest/autorun'

##
# Challenge: Get the maximal sum of non-adjacent values in an array.
# 
# Tags: dynamic programming, arrays.
# 
# Description:
# 
# There are n houses built in a line, each of which contains some value in it. A thief is
# going to steal the maximal value in these houses, but he cannot steal in two adjacent houses
# because the owner of a stolen house will tell his two neighbors on the left and right side.
# What is the maximal stolen value?
# 
# For example, if there are four houses with values {6, 1, 2, 7}, the maximal stolen value is
# 13 when the first and fourth houses are stolen.
# 
# Analysis:
# 
# A function f(i) is defined to denote the maximal stolen value from the first house to the
# ith house, and the value contained in the ith house is denoted as vi.When the thief reaches
# the ith house, he has two choices: to steal or not.Therefore, f(i) can be defined with the
# following equation:
# 
#     f(i) = max[vi + f(i - 2) when the ith house is stolen, f(i - 1) otherwise]
#     
# It would be much more efficient to calculate in bottom-up order than to calculate
# recursively. It looks like a 1D array with size n is needed, but actually it is only
# necessary to cache two values for f(i-1) and f(i-2) to calculate f(i).
#
# @see http://codercareer.blogspot.com/2013/02/no-44-maximal-stolen-values.html
class MaxSumNonAdjacent
  
  ##
  # Gets the maximal sum of non-adjacent values in an array.
  #
  # @param values [Array<Numeric>]
  #   The array of values. Never nil. Does not contain negative values.
  #
  # @return [Numeric]
  #   The maximal sum of non-adjacent values. Zero, if `values` is nil or empty.
  def self.get(values)
    return 0 if values.nil? || values.empty?

    value1 = values[0]
    return value1 if values.size == 1

    value2 = values[0..1].max
    return value2 if values.size == 2

    value = 0
    values[2..].each do |v|
      value = [value2, value1 + v].max
      value1 = value2
      value2 = value
    end

    value
  end
end

class MaxSumNonAdjacentTest < Minitest::Test
  def test_example
    assert_equal 13, MaxSumNonAdjacent.get([6, 1, 2, 7])
  end

  def test_empty
    assert_equal 0, MaxSumNonAdjacent.get([])
  end

  def test_single_value
    assert_equal 3, MaxSumNonAdjacent.get([3])
  end

  def test_two_values
    assert_equal 3, MaxSumNonAdjacent.get([1, 3])
  end

  def test_increasing_values
    assert_equal 11, MaxSumNonAdjacent.get([0, 1, 2, 3, 4, 5, 5])
  end
end
