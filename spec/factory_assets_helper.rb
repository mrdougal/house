# encoding: UTF-8


# 2010-09-24
# Helper methods for testing uploading of the application


module TempfileInstanceMethods
  
  def original_filename
    @original_filename
  end
  
  def original_filename=(val)
    @original_filename = val
  end
  
end


def get_fixture(n = nil)
  
  # Assign a random file, if no name was provided
  n = all_files.shuffle.first if n.nil?
  
  puts "Using #{n} as an asset" if Rails.env.test?
  
  # The n will most likely be passed in with a path (or part of one)
  f_name = File.basename(n)
  f_path = asset_fixtures_path(n)



  # Duplicate the contents of the requested file into a tempfile
  # Granted this is all in Ruby, so it's not the fastest but since 
  # this is only for testing it should be ok…

  # Split the fixture name into basename and extension
  # this is so we can create a tempfile that preserves file extensions
  ext = File.extname(f_name)
  base_name = File.basename(f_name, ext)
  

  Tempfile.send :include, TempfileInstanceMethods
 
  # Use the Array form to enforce an extension in the filename:
  # file = Tempfile.new(['hello', '.jpg'])
  # file.path  # => something like: "/tmp/foo2843-8392-92849382--0.jpg"
  tmp_file = Tempfile.new([base_name, ext])
  tmp_file.original_filename = File.basename f_name

  # We need to mock the method orginal_filename
  # as :original_filename is a Rails extension on Tempfile
  # tmp_file.stub(:original_filename).and_return(f_name) if Rails.env.test?
  
  # Convert to binmode as it's faster?
  # Write the content of the file, then rewind
  tmp_file.binmode
  tmp_file.write(File.read(f_path))
  tmp_file.rewind

  tmp_file

  
end

def asset_fixtures_path(n = nil)
  File.join(File.expand_path("#{Rails.root}/spec"), 'fixtures/assets', n)
end


  def all_files
    [ images, videos, 
      composite,
      videos, fonts, 
      archives,
      office, 
      iwork, uploaded_08_iwork_docs ].flatten
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
  
  
  def uploaded_08_iwork_docs
    [ 'example-08.pages.zip', 
      'example-08.numbers.zip',
      'example-08.key.zip'].collect! {|i| "iwork/uploaded-08-docs/#{i}" }
    
  end
  
  
  def odd_filenames
    [ 'bacon and ham.txt', 
      'bacon".txt',
      'bacon:ham.txt',
      '†est.txt'].collect! {|i| "odd-filenames/#{i}" }
  end


