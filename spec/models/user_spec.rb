describe User do
  before do
    @user = FactoryGirl.build(:user)
  end
  
  # let(:user) { User.create(:username => "Matt", :email => "Matt@awesomesauce.com", :password => "1234", :password_confirmation => "1234") }

  it 'must have a username' do 
    # user.username = nil
    # user.should be_valid

    #user = User.new( :username => "poop", :email => 'poop@poop.com',
       # :password => 'poop', :password_confirmation => 'poop' )
    
    @user.should be_valid
  end

  it 'must have a password' do
    @user.password = nil
    @user.should_not be_valid
  end

  it 'must have an email' do
    @user.email = nil
    @user.should_not be_valid
  end

  it 'must have a unique email' do
    @user2 = FactoryGirl.create(:user)
    @user2.should_not be_valid

    @user.email = "Doe@doe.com"
    @user.should_not be_valid

  end

  it 'should add up contributions' do
    @user.contributions.build(:amount => 100).save
    @user.contributions.build(:amount => 200).save
    @user.amount_contributed.should == 300
  end


end