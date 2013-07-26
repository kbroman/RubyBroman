#!/usr/bin/env ruby

# various crap related to classes and objects
# following Ch 6 in Peter Cooper's _Beginning Ruby_ 

# object variables: @blah
# class variables: @@blah
# global variables: $blah


# inheritance; 'super'
class Person
  def initialize(name)
    @name = name
  end
  def name
    return @name
  end
end

class Doctor < Person
  def name
    "Dr. " + super
  end
end

person = Person.new("Hyde")
doctor = Doctor.new("Jekyll")
puts person.name
puts doctor.name


# redefining methods in a class
class Dog
  def initialize(name)
      @name = name
  end

  def name
    return @name
  end

  def talk
    puts 'Bark'
  end
end

dog = Dog.new('Fido')
puts dog.name
dog.talk

class Dog
  def talk
    puts 'Woof'
  end
end

puts dog.name
dog.talk

puts dog.methods.join(" ")

# instance variables
class Person2
  attr_accessor :name, :age
end

p = Person2.new
p.name = "Fred"
p.age = 35
p p.instance_variables

# polymorphism
class Animal
  attr_accessor :name
  def initialize (name) 
    @name = name
  end
end

class Cat < Animal
  def talk 
    'Meow!'
  end
end

class Dog2 < Animal
  def talk 
    'Woof'
  end
end

animals = [Cat.new("Fisher"), Dog2.new("Jasper"), Cat.new("Francis")]
animals.each {|z| puts z.talk}
puts animals.map { |z| z.talk }.join(" ")

# scope of constants
def circle_circumference(radius)
  2 * Pi * radius
end

Pi = Math.asin(1)*2
puts circle_circumference(10)

class OtherPlanet
  Pi = 22 / 7

  def OtherPlanet.circle_circumference(radius)
    radius * 2 * Pi
  end
end

puts OtherPlanet.circle_circumference(10)
puts circle_circumference(10)
puts Pi
puts OtherPlanet::Pi

# mix-in
module UsefulFeatures
  def class_name
    self.class.to_s
  end
end

class Person2
  include UsefulFeatures
end

x = Person2.new
puts x.class_name
