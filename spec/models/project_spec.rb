require 'spec_helper'

describe Project do
  # let!(:project) { Project.create }
  # name {"Graham"}
  # goal  { 123 }

  let(:project) {Project.create(:name => "Graham", :description => 'A project', :goal => '123', :deadline => "2013-12-06 00:41:00", :user_id => '1', :start_time => "2013-12-05 00:41:00", :category_id => 1)}
  
  it 'must have name' do 
    project.name.should == "Graham"
    project.name.should_not == nil

    project.should be_valid
  end

  
  it 'must have goal' do 
    project.goal.should == 123

    project.should be_valid

  end

  it 'goal must not be nil' do 
    project.goal = nil

    project.should_not be_valid

  end

  it 'must have a deadline' do 
    project.deadline = nil

    project.should_not be_valid
  end

  it 'the deadline should be in the future' do

  end

  it 'should return 100 when fully funded' do
    user = User.create(:username => "bob", :email => 'bob@bob.com', :password => "pass")
    project.contributions.build(:user => user, :amount => 123).save

    project.funded.should == 100
  end

  it 'should return contrib amount when less then 100%' do
    user = User.create(:username => "bob", :email => 'bob@bob.com', :password => "pass")
    project.contributions.build(:user => user, :amount => 75).save

    project.funded.should == 61
  end

  it 'should return 100 when amount is greater than funding goal' do
    user = User.create(:username => "bob", :email => 'bob@bob.com', :password => "pass")
    project.contributions.build(:user => user, :amount => 175).save

    project.funded.should == 100
  end
end
