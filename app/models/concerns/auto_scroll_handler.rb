module AutoScrollHandler
  def scrollable_id
    "#{self.class.name.downcase}-#{id}"
  end
end
