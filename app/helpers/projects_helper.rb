module ProjectsHelper
  def link_to_cloudinary(path, parameters)
    "https://res.cloudinary.com/krabique48/image/upload/#{parameters}/#{path}"
  end
  
  def link_to_cloudinary(path)
    "https://res.cloudinary.com/krabique48/image/upload/#{path}"
  end
end
