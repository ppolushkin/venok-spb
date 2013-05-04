module SessionsHelper

  def authenticate_user(name, password)
    if(name == 'admin' && password == 'mario2')
      true
    else
      false
    end    
  end

end
