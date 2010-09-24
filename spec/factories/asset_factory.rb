

  Factory.define :asset do |f|
    # f.name { random_string }
    # f.email { random_email_address }
  end

  Factory.define :processed_asset, :parent => :asset  do |f|
    
    f.preview_generated_at { 3.hours.ago }

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



  def open_file(name)
    File.open(File.join(File.dirname(__FILE__), 'fixtures', name), 'r')
  end

  def file_path( *paths )
    File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
  end


  def all_files
    [ images, videos, 
      composite,
      videos, fonts, 
      archives,
      office, iwork ].flatten
  end


  def can_preview
    [ images, videos, 
      composite,
      videos, fonts,
      office, iwork ].flatten
  
  end

  def images
    [ 'example.jpg',
      'example.gif',
      'example.png',
      'example.psd' ]
  end

  def composite
    [ 'example.pdf',
      'example.ai.ps',
      'example.ai',
      'example.eps' ]
  end

  def videos
    [ 'example.mov' ]  
  end

  def fonts
    [ ]
  end

  def archives
    [ 'example.zip',
      'example.tar.gz',
      'example.pdf.gz' ]
  end

  def office
    [ 'example.doc', 'example.docx', 
      'example.ppt','example.ppsx', 
      'example.xls', 'example.xlsx']
  end

  def iwork
  [ 'example.pages', 
    'example.numbers',
    'example.key']
  end
  
  
  
  