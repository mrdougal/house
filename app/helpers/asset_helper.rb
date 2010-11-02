module AssetHelper
  
  # Outputs html to display an image
  def asset_image_tag asset, size = :preview
    
    url = case when size == :small
            small_asset_url(asset)
          when size == :medium
            medium_asset_url(asset)
          when size == :large
            large_asset_url(asset)
          else
            preview_asset_url(asset)
          end
    
    tag :img, { :src => url, :class => size.to_s }
  end
  
  
end
