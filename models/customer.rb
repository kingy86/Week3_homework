require_relative("../db/sqlrunner.rb")

class Customer
attr_reader :id
attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE from customers;"
    SqlRunner.run(sql)
  end

  def films
    sql = 'SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1;'
    value = [@id]
    film_information = SqlRunner.run(sql, values)
    return Customer.new.map_items(film_information)
  end


end
