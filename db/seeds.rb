User.create!(email: "first@user.com",
                      first_name: "Andrew",
                      last_name: "Ye",
                      phone_number: "38050478",
                      password: "password",
                      password_confirmation: "password"
)

User.create!(email: "admin@user.com",
                      first_name: "Admin",
                      last_name: "User",
                      phone_number: "38050000",
                      password: "password",
                      password_confirmation: "password",
                      role: 1
)

# Routes with changes: Sofia - Rome on March 10, 2016
Route.create!(route_number: 2001,
                          start_point:  "Sofia",
                          end_point:  "Warsaw",
                          depart: "2016-03-10 05:22:00",
                          arrive: "2016-03-10 06:28:00",
                          price: 50
)
Route.create!(route_number: 2002,
                          start_point:  "Warsaw",
                          end_point:  "Milan",
                          depart: "2016-03-10 06:55:00",
                          arrive: "2016-03-10 08:12:00",
                          price: 45
)
Route.create!(route_number: 2003,
                          start_point:  "Milan",
                          end_point:  "Rome",
                          depart: "2016-03-10 09:00:00",
                          arrive: "2016-03-10 09:47:00",
                          price: 20
)
Route.create!(route_number: 2004,
                          start_point:  "Sofia",
                          end_point:  "Milan",
                          depart: "2016-03-10 06:22:00",
                          arrive: "2016-03-10 07:39:00",
                          price: 50
)
Route.create!(route_number: 2005,
                          start_point:  "Sofia",
                          end_point:  "Warsaw",
                          depart: "2016-03-10 08:48:00",
                          arrive: "2016-03-10 10:03:00",
                          price: 18
)
Route.create!(route_number: 2006,
                          start_point:  "Sofia",
                          end_point:  "Milan",
                          depart: "2016-03-10 05:22:00",
                          arrive: "2016-03-10 06:28:00",
                          price: 40
)
Route.create!(route_number: 2010,
                          start_point:  "Sofia",
                          end_point:  "Rome",
                          depart: "2016-03-10 12:32:00",
                          arrive: "2016-03-10 13:55:00",
                          price: 38
)

cities= ["Rome", "Brussels", "Warsaw", "New York", "Washington",
            "Milan", "Kyiv", "London", "Berlin", "Madrid", "Barcelona", "Paris"]

500.times do |n|
  route_number = 101 + n
  start_point = cities[rand(cities.length)]
  reduced_cities = cities - Array(start_point)
  end_point = reduced_cities[rand(reduced_cities.length)]
  depart = Faker::Time.forward(5, :morning)
  arrive = depart + rand(100..400).minutes
  price = rand(100..1000)
  Route.create!(route_number: route_number,
                          start_point:  start_point,
                          end_point:  end_point,
                          depart: depart,
                          arrive: arrive,
                          price: price
  )
end

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name}@user.com"
  phone_number = Faker::PhoneNumber.cell_phone
  User.create!(email: email,
                      first_name: first_name,
                      last_name: last_name,
                      phone_number: phone_number,
                      password: "password",
                      password_confirmation: "password"
  )
end

route = Route.find(8)
User.last(5).each do |user|
  user.tickets.create(route_id: route.id)
end
