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
end
