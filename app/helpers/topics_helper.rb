module TopicsHelper
  def topics_list
    Topic.pluck(:name)
  end

  def ordered_topics
    Topic.order(:name)
  end
end
