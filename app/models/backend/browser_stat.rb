class Backend::BrowserStat < ActiveRecord::Base
  
  scope :failed, where(success: false)
  scope :last, lambda { |n| order('created_at DESC').limit(n) }
  
end
