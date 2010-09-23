

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