[![Build Status](https://travis-ci.org/potato2003/array_to_activerecord.svg?branch=master)](https://travis-ci.org/potato2003/array_to_activerecord)
[![Gem Version](https://badge.fury.io/rb/array_to_activerecord.svg)](https://badge.fury.io/rb/array_to_activerecord)

# ArrayToActiverecord

Convert Array to ActiveRecord::Relation without database access

## Support Version

ActiveRecord v4.2 ~ v6.0.0.rc1

Currently, Testing matrix of Ruby/ActiveRecord versions on Travis CI.

| ActiveRecord \ Ruby | 2.3 | 2.4 | 2.5 | 2.6 |
| ------------------- | --- | --- | --- | --- |
| 4.2                 |  ✓  |  ✓  |  -  |  -  |
| 5.0                 |  ✓  |  ✓  |  ✓  |  -  |
| 5.1                 |  ✓  |  ✓  |  ✓  |  -  |
| 5.2                 |  -  |  ✓  |  ✓  |  ✓  |
| 6.0.rc1             |  -  |  -  |  ✓  |  ✓  |

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
records = ArrayToActiveRecord.convert(array, model_class: Customer)
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
