module Fundamental::CharactersHelper

  def character_paginate(c)  
   
   anzahl = Fundamental::Character.where("lower(identifier) < ('#{c.downcase}')").count + 1
   page = (anzahl / 50.0).ceil 
   
    return page;
  end
  
end
