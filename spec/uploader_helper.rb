

# 2010-09-24
# Helper methods for testing uploading of the application

def get_file(name)
  
  fxtr_file = File.join(File.dirname(__FILE__), 'fixtures/assets', name)
  tmp_file = File.expand_path("tmp/cache/assets/#{Time.now.to_i}/#{File.basename(name)}", )

  FileUtils.mkdir_p(File.dirname(tmp_file))
  FileUtils.cp(fxtr_file, tmp_file)
  
  tmp_file
  
end

# def file_path( *paths )
#   File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', *paths))
# end





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
      'example.psd' ].collect! {|i| "images/#{i}" }
  end

  def composite
    [ 'example.pdf',
      'example.ps',
      'example.ai',
      'example.eps',
      'example.svg' ].collect! {|i| "composite/#{i}" }
  end

  def videos
    [ 'example.mov',
      'example-h.264.mov' ].collect! {|i| "videos/#{i}" }
  end

  def fonts
    [ 'datafork true type.dfont',
      'opentype.otf',
      'postscript',
      'windows true type.ttf'].collect! {|i| "fonts/#{i}" }
  end

  def archives
    [ 'example.zip',
      'example.ai.gz' ].collect! {|i| "archives/#{i}" }
  end

  def office

    [ 'example.doc', 'example.docx',  # doc
      'example.ppt','example.pptx',   # ppt
      'example.xls', 'example.xlsx'   # excel 
      ].collect! {|i| "office/#{i}" }
  end

  def iwork
  [ 'example.pages', 
    'example-08.pages',
    'example.numbers',
    'example.key'].collect! {|i| "iwork/#{i}" }
  end
  


