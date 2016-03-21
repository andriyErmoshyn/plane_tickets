require 'faker'

FactoryGirl.define do
  factory :route do
    route_number { Faker::Number.number(3) }
    start_point     { Faker::Address.city }
    end_point       { Faker::Address.city }
    depart           { Faker::Time.forward(1, :morning) }
    arrive            { Faker::Time.forward(1, :afternoon) }
    price             { Faker::Number.decimal(2) }


  #Creating routes for changes
  #First: with 1 change
  factory :sofia_milan do
    start_point     { 'Sofia' }
    end_point       { 'Milan' }
    depart           { '2016-03-25 06:00' }
    arrive            { '2016-03-25 07:15' }
  end

  factory :milan_rome_1 do
    start_point     { 'Milan' }
    end_point       { 'Rome' }
    depart           { '2016-03-25 09:00' }
    arrive            { '2016-03-25 10:18' }
  end

  #Second: with 2 changes
  factory :sofia_warsaw do
    start_point     { 'Sofia' }
    end_point       { 'Warsaw' }
    depart           { '2016-03-25 06:27' }
    arrive            { '2016-03-25 07:40' }
  end

  factory :warsaw_milan do
    start_point     { 'Warsaw' }
    end_point       { 'Milan' }
    depart           { '2016-03-25 08:30' }
    arrive            { '2016-03-25 09:54' }
  end

  factory :milan_rome_2 do
    start_point     { 'Milan' }
    end_point       { 'Rome' }
    depart           { '2016-03-25 10:30' }
    arrive            { '2016-03-25 11:50' }
  end

  #This one is too late and should not be shown as a result
  factory :sofia_milan_late do
    start_point     { 'Sofia' }
    end_point       { 'Milan' }
    depart           { '2016-03-25 15:30' }
    arrive            { '2016-03-25 16:50' }
  end
  end
end
