require 'spec_helper'

RSpec.describe 'Simple test' do
    it "evaluates a non negative number" do
        expect(1).not_to be_negative  
    end
end