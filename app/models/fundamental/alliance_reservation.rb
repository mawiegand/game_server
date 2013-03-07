class Fundamental::AllianceReservation < ActiveRecord::Base

  belongs_to :alliance, :class_name => "Fundamental::Alliance", :foreign_key => "alliance_id", :inverse_of => :reservation

end
