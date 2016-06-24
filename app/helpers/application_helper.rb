module ApplicationHelper
  def gravatar_for(user, option = {width: 80, height: 80})
    gravatar_url = user.avatar.url
    if gravatar_url.nil?
      gravatar_url = t "image.avatar"
    end
    image_tag gravatar_url, alt: user.fullname, class: "gravatar",
      size: "#{option[:width]}x#{option[:height]}"
  end

  def grpicture_for(book, option = {width: 80, height: 80})
    grpicture_url = book.picture.url
    if grpicture_url.nil?
      grpicture_url = t "image.picture"
    end
    image_tag grpicture_url, alt: book.title, class: "grpicture",
      size: "#{option[:width]}x#{option[:height]}"
  end
end
