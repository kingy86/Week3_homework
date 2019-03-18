require_relative("../db/sqlrunner.rb")

class Film
attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.delete_all
    sql = "DELETE from films;"
    SqlRunner.run(sql)
  end

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers
    sql = 'SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;'
    value = [@id]
    customer_information = SqlRunner.run(sql, values)
    return Film.new.map_items(customer_information)
  end
end
