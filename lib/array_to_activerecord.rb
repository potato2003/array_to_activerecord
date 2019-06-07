require "active_record"

module ArrayToActiverecord
  def self.convert(array, model_class: nil)
    model_class = determine(array) if model_class.nil?

    Converter.new(model_class).convert(array)
  end

  private

  def self.determine(array)
    model = array[0] if array.is_a? Array

    unless model.is_a? ActiveRecord::Base
      raise(ArgumentError,
        "Failed to determine model_class because array is empty, " \
        "or array item is non ActiveRecord model. " \
        "You can resolve by using model_class option"
      )
    end

    model.class
  end
end

module ArrayToActiverecord
  class Converter
    def initialize(model_class)
      @model_class = model_class
    end

    def convert(array)
      @relation = new_relation
      @relation = @relation.where(id: array.map(&:id)) # add query info used by `to_sql` method etc.
      load_records(array)

      @relation
    end

    private

    def new_relation
      @model_class.all
    end

    def load_records(array)
      v5_0 = Gem::Version.create("5.0")
      v4_0 = Gem::Version.create("4.0")

      if v5_0 < activerecord_version
        @relation.send(:load_records, array)
      elsif v4_0 < activerecord_version
        @relation.instance_variable_set(:@records, array)
        @relation.instance_variable_set(:@loaded, true)
      else
        raise "ActiveRecord version #{ActiveRecord.gem_version} is not supported"
      end
    end

    def activerecord_version
      return @activerecord_version if @activerecord_version

      if ActiveRecord.respond_to? :gem_version # version 5.0 ~
        @activerecord_version = ActiveRecord.gem_version
      elsif ActiveRecord.respond_to? :version # version 4.0 ~
        @activerecord_version = ActiveRecord.version
      else
        @activerecord_version = nil
      end
    end
  end
end
