require 'rails_helper'

RSpec.describe User, :type => :model do
  it "whitelists users with the right email address" do
    expect(User.whitelisted?("adam.pash@gawker.com")).to be true
    expect(User.whitelisted?("adam.pash@gawker.coms")).to be false
    expect(User.whitelisted?("@io9.com")).to be false
    expect(User.whitelisted?("charliejane@io9.com")).to be true
  end
end
