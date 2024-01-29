class Sale < ApplicationRecord


  def self.active
    self.where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

  def over?
    ends_on < Date.current
  end

  def upcoming?
  starts_on > Date.current
  end

  def active?
    !upcoming? && !over?
  end
  
end
