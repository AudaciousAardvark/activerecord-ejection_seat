# frozen_string_literal: true

require "spec_helper"

RSpec.describe ActiveRecord::EjectionSeat::Ejectable do
  let(:user_model) { User.new(name: "Max", age: 28) }
  let(:user_struct) { Types::User.new(name: "Max", age: 28) }

  describe "#eject" do
    it "converts from ActiveRecord model to given Sorbet struct" do
      expect(user_model.eject).to eq(user_struct)
    end
  end

  describe "#to_struct" do
    it "is an alias for #eject" do
      expect(user_model.to_struct).to eq(user_struct)
    end
  end

  describe ".buckle" do
    it "converts into ActiveRecord model from given Sorbet struct" do
      new_user = User.buckle(user_struct)

      expect(new_user).to be_a(User)
      expect(new_user.name).to eq("Max")
      expect(new_user.age).to eq(28)
    end

    context "when invalid class is passed in" do
      it "raises an ArgumentError" do
        pet = Types::Pet.new(name: "Java", breed: "Long-haired Cat")

        expect { User.buckle(pet) }.to raise_error(ArgumentError)
      end
    end
  end

  describe ".from_struct" do
    it "is an alias for .buckle" do
      new_user = User.from_struct(user_struct)

      expect(new_user).to be_a(User)
      expect(new_user.name).to eq("Max")
      expect(new_user.age).to eq(28)
    end
  end
end
