require ('pry-byebug')
require_relative('./models/bounties.rb')

bounty1 = Bounty.new (
  { 'name' => 'Peter',
    'species' => 'martian',
    'value' => '10',
    'location' => 'Mars'
  })

  bounty2 = Bounty.new (
    { 'name' => 'Mark',
      'species' => 'alian',
      'value' => '20',
      'location' => 'Jupiter'
    })



bounty1.save
bounty2.save

# bounty1.name='Sheila'
# bounty1.location = 'Venus'
# bounty1.update
#
p Bounty.return_by_location_and_name("Venus", "Sheila")
# p Bounty.return_lowest_value
  nil
