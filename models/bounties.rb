require ('pg')
class Bounty

  attr_accessor :name, :species, :value, :location
  attr_reader :id

  def initialize (bounty_options)
    @id = bounty_options['id'].to_i if bounty_options['id']
    @name = bounty_options['name']
    @species = bounty_options['species']
    @value = bounty_options['value']
    @location = bounty_options['location']
  end

  def save
    db = PG.connect({dbname: 'bounties', host:'localhost'})
    sql = "INSERT INTO bounties
    (
      name,
      species,
      value,
      location
    )
    VALUES (
      $1, $2, $3, $4
    )
    RETURNING *
    "
    values = [@name, @species, @value, @location]
    db.prepare("save",sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close
  end

  def delete
    db = PG.connect({dbname: 'bounties', host:'localhost'})
    sql = "DELETE FROM BOUNTIES WHERE id= $1"
    values = [@id]
    db.prepare("delete",sql)
    db.exec_prepared("delete",values)
    db.close
  end


  def update
    db = PG.connect({dbname: 'bounties', host: 'localhost'})
    sql = "UPDATE bounties
    SET(
      name,
      species,
      value,
      location
    )
    = (
      $1, $2, $3, $4
    )
    WHERE  id = $5
    "
    values = [@name, @species, @value, @location, @id]
    db.prepare("my_update",sql)
    db.exec_prepared("my_update",values)
    db.close
  end
  #
  def self.return_by_id(id)
    db = PG.connect( {dbname: 'bounties', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE id = $1"
    values= [id]
    db.prepare("chosen",sql)
    chosen_bounties = db.exec_prepared("chosen",values)
    db.close
    return chosen_bounties.map { |chosen_bounty| Bounty.new(chosen_bounty)}
  end

  def self.return_by_location_and_name(place,name)
    db = PG.connect( {dbname: 'bounties', host: 'localhost'})
    sql = "SELECT * FROM bounties WHERE location = $1 and name= $2"
    values= [place,name]
    db.prepare("chosen",sql)
    chosen_bounties = db.exec_prepared("chosen",values)
    db.close
    return chosen_bounties.map { |chosen_bounty| Bounty.new(chosen_bounty)}
  end

  def self.return_lowest_value
    db = PG.connect( {dbname: 'bounties', host: 'localhost'})
    sql = "SELECT MIN(value) FROM bounties"
    values= []
    db.prepare("lowest",sql)
    lowest_bounties = db.exec_prepared("lowest",values)
    db.close
    return lowest_bounties[0]
  end






end
