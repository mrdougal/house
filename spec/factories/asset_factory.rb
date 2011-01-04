

  Factory.define :asset do |f|
    
    f.file { get_fixture("images/example.jpg") }

  end

  Factory.define :processed_asset, :parent => :asset  do |f|
    
    f.preview_created_at { 3.hours.ago }

  end

  Factory.define :thumbnail_set do |f|
    
      {
      :small  => { :size => '40x40' },
      :medium => { :size => '150x150' },
      :large  => { :size => '800x800', :format => :jpg }
    }
    
  end
  
  Factory.define :thumb, :class => Thumbnail do |t|
    
    t.parent { Factory :processed_asset }
    t.name    :large
    t.dimensions {{ :width => 800, :height => 800 }}
    t.crop   false 
    t.format :jpg
    
  end
  
  
  # This is an alias, to the base thumb class
  Factory.define :thumb_large, :parent => :thumb do |t| end
  
  Factory.define :thumb_medium, :parent => :thumb do |t|

    t.name    :medium
    t.dimensions {{ :width => "150", :height => "150" }}
    t.format  :png

  end
  
  Factory.define :thumb_small, :parent => :thumb_medium do |t|
    
    t.name :small
    t.dimensions {{ :width => "40", :height => "40" }}
    t.crop true
  end


