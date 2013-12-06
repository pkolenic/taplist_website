class StaticPagesController < ApplicationController
  def home
  end

  def help
    @company = "RiisingSun"
  end
  
  def contact
  end
end
