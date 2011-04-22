class IntroController < ApplicationController

  def index
    if current_user
      redirect_to :controller => "users", :action => "index"
    end
  end

end
