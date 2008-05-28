class Employee < ActiveResource::Base
  self.site = 'http://nanna.bekk.no:4806'
  
  def self.authenticate(login,password)
    employee = create(:login => login, :password => password)
    employee.id
  rescue ActiveResource::UnauthorizedAccess
    nil
  end
  
end