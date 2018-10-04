# Given an array of unique integers ordered from least to greatest, write a
# method that returns an array of the integers that are needed to
# fill in the consecutive set.

def missing_numbers(nums)
  min_num = nums.min
  max_num = nums.max
  (min_num...max_num).to_a.delete_if{|el| nums.include?(el)}
end

# Write a method that returns the nth prime number
def nth_prime(n)
  return nil if n == 0
  count = 0
  i = 1
  while count < n
    i += 1
    if is_prime?(i)
      count += 1
    end
  end
  i
end

def is_prime?(num)
  (2...num).count {|x| num % x == 0} == 0
end

class Hash
  # Hash#select passes each key-value pair of a hash to the block (the proc
  # accepts two arguments: a key and a value). Key-value pairs that return true
  # when passed to the block are added to a new hash. Key-value pairs that return
  # false are not. Hash#select then returns the new hash.
  #
  # Write your own Hash#select method by monkey patching the Hash class. Your
  # Hash#my_select method should have the functionailty of Hash#select described
  # above. Do not use Hash#select in your method.

  def my_select(&prc)
    hash = Hash.new
    self.each do |key, val|
      hash[key] = val if prc.call(key,val)
    end
    hash
  end
end

# A palindrome is a word or sequence of words that reads the same backwards as
# forwards. Write a method that returns the length of the longest palindrome in
# a given string. If there is no palindrome longer than two letters, return false.

def longest_palindrome(string)
  num = 0
  arr = string.chars
  arr.each_with_index do |ltr, idx|
    if ltr == string[idx + 1]
      num = 2 if num < 2
      i = 1
      frst = idx - i
      lst = idx + 1 + i
      while string[frst] && string[lst] && palindrome?(string[frst..lst])
        i += 1
        num = i * 2
        frst = idx - i
        lst = idx + 1 + i
      end
    elsif ltr == string[idx+2]
      num = 3 if num < 3
      i = 1
      frst = idx - i
      lst = idx + 2 + i
      while string[frst] && string[lst] && palindrome?(string[frst..lst])
        i += 1
        num = i * 2 + 1
        frst = idx - i
        lst = idx + 1 + i
      end
    end
  end
  return false if num == 0
  num
end

def palindrome?(str)
  str == str.reverse
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    i = 0
    arr = Array.new
    while self[i]
      arr[i] = prc.call(self[i])
      i += 1
    end
    return self if !arr[i]
    arr
  end
end

class Array
  # Write an Array method that returns a bubble-sorted copy of an array.
  # Do NOT call the built-in Array#sort method in your implementation.
  def bubble_sort(&prc)
    prc ||= Proc.new{|num1,num2| num1 <=> num2}
    sorted = false
    arr = self.dup
    until sorted
      sorted = true
      arr.each_with_index do |el, idx|
        break if idx + 1 == arr.length
        if prc.call(arr[idx], arr[idx+1]) > 0
          sorted = false
          arr[idx], arr[idx+1] = arr[idx+1], arr[idx] 
        end
      end
    end
    arr
  end

  # You are not required to implement this; it's here as a suggestion :-)
  def bubble_sort!(&prc)

  end
end

# The following is a skeleton of three classes you will be asked to define to
# pass the related specs. Please read the specs carefully to determine the
# functionality and instance variables you should give each class. Show us your
# object-oriented programming skills!

class Cat
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def meow
    "meow"
  end

  def receive_love
    meow
  end
end

class Dog
  attr_accessor :name, :breed
  BREEDS = ['Husky', 'Black Labrador', 'German Shepherd', 'Chihuahua']

  def initialize(name, breed)
    @name = name
    @breed = breed
  end

  def play_with(cat)
    cat.receive_love
  end

  def self.make_a_pup
    Dog.new("pup", BREEDS.sample)
  end

end

class Human
  def initialize(name)
    @name = name
    @happy = false
  end

  def happy?
    @happy
  end

  def receive_love
    @happy = true
  end
end
