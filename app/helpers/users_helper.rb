module UsersHelper
  def full_name user
    return user.first_name + " " + user.last_name
  end
end
