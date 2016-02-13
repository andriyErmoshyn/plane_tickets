User.create!(email: "first@user.com",
                      first_name: "Andrew",
                      last_name: "Ye",
                      phone_number: "38050478",
                      password: "password",
                      password_confirmation: "password"
  )

from_cities = ["Kyiv", "London", "Berlin", "Madrid", "Barcelona", "Paris"] 
to_cities= ["Rome", "Brussels", "Warsaw", "New York", "Washington", "Milan"]

20.times do
  start_point = from_cities[rand(from_cities.length)]
  end_point = to_cities[rand(to_cities.length)]
  depart = Faker::Time.forward(1, :morning) 
  arrive = Faker::Time.forward(1, :afternoon) 
  price = rand(100..1000)
  Route.create!(start_point: start_point,
                          end_point:  end_point,
                          depart: depart,
                          arrive: arrive,
                          price: price
    )
end
