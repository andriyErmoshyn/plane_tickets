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

cities= ["Rome", "Brussels", "Warsaw", "New York", "Washington", 
            "Milan", "Kyiv", "London", "Berlin", "Madrid", "Barcelona", "Paris"]

100.times do |n|
  route_number = 101 + n
  start_point = cities[rand(cities.length)]
  reduced_cities = cities - Array(start_point)
  end_point = reduced_cities[rand(reduced_cities.length)]
  depart = Faker::Time.forward(10, :morning) 
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

route = Route.find(3)
User.last(5).each do |user|
  user.tickets.create(route_id: route.id)
end
