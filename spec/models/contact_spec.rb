require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Contact do
  before(:each) do
    @valid_attributes = {
      :name => "James Brown",
      :number => "+33.38392921212"
    }
  end

  it "should create a new instance given valid attributes" do
    Contact.new(@valid_attributes).should be_valid
  end

  it "should remove spaces and dots from number" do
    Contact.new(:number => "1 2.3").number.should == "123"
  end

end
