require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      user = User.new(name: '', email: 'temple@yahoo.com', password: 'precious5', password_confirmation: 'precious5').save
      expect(user).to eql(false)
    end

    it 'ensures password must be al least 6 characters' do
      user = User.new(name: 'precious', email: 'temple@yahoo.com', password: 'louis').save
      expect(user).to eql(false)
    end

    it 'ensures name must be al least 5 characters' do
      user = User.new(name: 'ella', email: 'temple@yahoo.com', password: 'precious').save
      expect(user).to eql(false)
    end

    it 'ensures email presence' do
      user = User.new(name: 'precious', email: '', password: 'precious5').save
      expect(user).to eql(false)
    end

    it 'creates user when everything is inputed correctly' do
      user = User.new(name: 'precious', email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(true)
    end

    it 'ensures email must be unique' do
      User.new(name: 'louis', email: 'temple@yahoo.com', password: 'precious5').save
      user = User.new(name: 'spetsnaz', email: 'temple@yahoo.com', password: 'precious5').save
      expect(user).to eql(false)
    end
  end
end