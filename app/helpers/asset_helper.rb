module AssetHelper
  
  # Outputs html to display an image
  # Needs to be made more flexible
  def asset_image_tag asset, size = :preview
    
    tag :img, { :src => preview_asset_url(asset), :class => size.to_s }
  end
  
  
end
