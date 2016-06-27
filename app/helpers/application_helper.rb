module ApplicationHelper
  def grimage_for object, option = {width: 80, height: 80}
    if object.class == User
      @gr_url = object.avatar.url
    else
      @gr_url = object.picture.url
    end
    image_tag @gr_url, class: "gr",
      size: "#{option[:width]}x#{option[:height]}"
  end
end
