# ArrayToActiverecord

Convert Array to ActiveRecord::Relation without database access

## Support Version

ActiveRecord v4.2 ~ v6.0.0.rc1

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'array_to_activerecord'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install array_to_activerecord

## Usage

```ruby
array = [ Customer.find(1), Customer.find(2), Customer.find(3) ]
# Customer Load (0.1ms)  SELECT  `customers`.* FROM `customers` WHERE `customers`.`id` = 1 LIMIT 1
# Customer Load (0.1ms)  SELECT  `customers`.* FROM `customers` WHERE `customers`.`id` = 2 LIMIT 1
# Customer Load (0.1ms)  SELECT  `customers`.* FROM `customers` WHERE `customers`.`id` = 3 LIMIT 1

# Convert without database access
records = ArrayToActiverecord.convert(array, model_class: Customer)
```

## Testing

```
bundle exec rake
```

### Testing with multiple versions of ActiveRecord

First, you need to install the dependencies for each appraisal

```
bundle exec appraisal install
```

Next, run tests across all ActiveRecord versions

```
bundle exec appraisal rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/potato2003/array_to_activerecord.
