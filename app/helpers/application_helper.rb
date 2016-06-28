module ApplicationHelper
  def activity_title activity
    case activity.activity_type
    when "follow"
      t "activities.follow"
    when "markread"
      t "activities.markread"
    when "markfav"
      t "activities.markfav"
    when "writereview"
      t "activities.writereview"
    when "writecmt"
      t "activities.writecmt"
    end
  end
end
