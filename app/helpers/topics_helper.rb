module TopicsHelper
  def topics_list
    Tag.pluck(:name)
  end
end
