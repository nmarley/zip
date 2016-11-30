require 'csv'
require 'active_record'

fn = 'zipcode.csv'

# active record magic...

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  database: 'test',
  username: 'test',
)

class State < ActiveRecord::Base
  has_many :cities
end
class City < ActiveRecord::Base
  belongs_to :state
  has_many :zip_codes

  def to_s
    "#{name}, #{state.abbr}"
  end
end
class ZipCode < ActiveRecord::Base
  belongs_to :city
end


# parse CSV file, load records into DB
CSV.parse(File.read(fn), headers: true).each do |rec|
  state = State.find_or_create_by(abbr: rec['state'])
  city = City.find_or_create_by(state: state, name: rec['city'])
  zip_code = ZipCode.find_or_create_by(city: city, code: rec['zip'])
end


