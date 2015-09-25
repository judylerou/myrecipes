require 'test_helper'

class ChefTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.new(chefname: 'Jon', email: 'jon@email.com')
  end
  
  test 'chef should be valid' do
    assert @chef.valid?
  end
  
   test 'chef name should be present' do
    @chef.chefname = " "
    assert_not @chef.valid?
  end
  
  test 'chef name not too long' do
    @chef.chefname = "a"*41
    assert_not @chef.valid?
  end
  
 test 'chef name not too short' do
    @chef.chefname = "aa"
    assert_not @chef.valid?
  end
  
  test 'email should be present' do
    @chef.email = " "
    assert_not @chef.valid?
  end
  
  test 'email length should be within bounds' do
    @chef.email = "a"*101 + '@example.com'
    assert_not @chef.valid?
  end
   
   test 'email address should be unique' do
    dup_chef = @chef.dup
    dup_chef.email = @chef.email.upcase
    @chef.save
    assert_not dup_chef.valid?
   end
   
    test 'email must accept valid address' do
      valid_addresses =%w[user@abc.com R_TDD-DS@abc.hello.org user@example.com first.last@com.au laura+joe@monk.cm]
      valid_addresses.each do |va|
      @chef.email = va
      assert @chef.valid?, '#{va.inspect} should be valid'
      end
    end
    
    test 'email should reject invalid address' do
      invalid_addresses = %w[user@example, user_some_what.org, user.name@example, eee@io_lk.com]
      invalid_addresses.each do |ia|
        @chef.email = ia
        assert_not @chef.valid? '#{ia.inspect} should be invalid'
      end
    end
    
    
    
  
  
  
end