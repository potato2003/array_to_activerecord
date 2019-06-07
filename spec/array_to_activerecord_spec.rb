require 'array_to_activerecord'

RSpec.describe ArrayToActiverecord do

  describe ".convert" do
    subject { ArrayToActiverecord.convert(array, model_class: model_class) }
    let(:model_class) { nil }

    context "when give an array including ActiveRecord instances" do
      let(:customer_a) { create_customer(name: "customer_a") }
      let(:customer_b) { create_customer(name: "customer_b") }
      let(:customer_c) { create_customer(name: "customer_c") }
      let(:array) { [ customer_a, customer_b, customer_c ] }

      it { is_expected.to be_kind_of(ActiveRecord::Relation) }
      it("should match ids") { expect(subject.ids).to match(array.map(&:id)) }
      it("has where clause") { expect(p subject.to_sql).to_not be_empty }
    end

    context "when give an array including non-ActiveRecord instances" do
      let(:array) { [""] }
      it { expect{ subject }.to raise_error(ArgumentError) }
    end

    context "when give an empty array" do
      let(:array) { [] }
      it { expect{ subject }.to raise_error(ArgumentError) }

      context "and using model_class option" do
        let(:model_class) { Customer }

        it { is_expected.to be_kind_of(ActiveRecord::Relation) }
        it { is_expected.to be_empty }
      end
    end
  end
end

# Definitions for testing
class Customer < ActiveRecord::Base; end

def create_customer(name: nil, email: nil)
  Customer.create!(
    name: name,
    email: email || "#{name}@example.com",
    registered_at: Time.now,
  )
end
