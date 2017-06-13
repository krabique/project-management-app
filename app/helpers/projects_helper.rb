module ProjectsHelper
  def cloudinary_start_path
    return "https://res.cloudinary.com/#{ENV['CLOUDINATY_CLOUD_NAME']}/"
  end
  
  def link_to_cloudinary(path, parameters)
    type = cloudinary_link_type(path)
    "#{cloudinary_start_path}#{type}/upload/#{parameters}/#{path}"
  end
  
  def link_to_cloudinary(path)
    type = cloudinary_link_type(path)
    "#{cloudinary_start_path}#{type}/upload/#{path}"
  end
  
  def is_image_path?(path)
    path =~ /\.(?:jpg|gif|png)/
  end
  
  def cloudinary_link_type(path)
    is_image_path?(path) ? 'image' : 'raw'
  end
  
  def representation_image(document)
    if is_image_path?(document.cloudinary_uri)
      link_to cl_image_tag(document.cloudinary_uri, :crop => :fill, 
        :width => 120, :height => 80), 
        link_to_cloudinary(document.cloudinary_uri), 
        target: "_blank"
    elsif current_user.dark_style
      link_to image_tag('documents/default_dark.png', 
        :width => 80, :height => 80), 
        link_to_cloudinary(document.cloudinary_uri), 
        target: "_blank"
    else
      link_to image_tag('documents/default.png', 
        :width => 80, :height => 80), 
        link_to_cloudinary(document.cloudinary_uri), 
        target: "_blank"
    end
  end
end
