module QuestionsHelper
  def truncate_action_text(content, length, **args_hash)
    sanitize content.to_s.truncate(length, args_hash)
  end
end
