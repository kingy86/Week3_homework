require('pry')
require_relative('db/sqlrunner.rb')
require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')


Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({
  "name" => "Mark",
  "funds" => "20"
  })
customer1.save()

customer2 = Customer.new({
  "name" => "Laura",
  "funds" => "30"
})
customer2.save()
customer2.name = 'Rosie'
customer2.update

film1 = Film.new({
  "title" => "Leon",
  "price" => "5"
  })
film1.save()

film2 = Film.new({
  "title" => "Pulp Fiction",
  "price" => "7"
  })
film2.save()
film2.price = "5"
film2.update()

ticket1 = Ticket.new({
  "customer_id" => customer1.id,
  "film_id" => film2.id
  })
ticket1.save()

ticket2 = Ticket.new({
  "customer_id" => customer2.id,
  "film_id" => film1.id
  })
ticket2.save()


  binding.pry
  nil
