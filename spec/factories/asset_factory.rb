

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
  
  Factory.define :thumb do |t|
    
    t.name    :large
    t.size    '800x800'
    t.crop    false
    t.format :jpg
    
  end
  
  Factory.define :thumb_medium, :parent => :thumb do |t|

    t.name    :medium
    t.size    '150x150'
    t.format  :png

  end
  
  Factory.define :thumb_small, :parent => :thumb_medium do |t|
    
    t.name :small
    t.size '40x40'
    t.crop true
  end


