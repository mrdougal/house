
# 2010-09-22
# Looks after files within the system

class Asset
  
  
  include Mongoid::Document
  
  field :name
  field :size
  
  field :file
  
  def to_s
    'file'
  end
  
  # def file
  #   
  # end
  
  def file=(new_file)
    
    @file
    
    if new_file and new_file.respond_to?(:original_filename)
      self[:file] = new_file.original_filename
    else
      
      'cheese'
    end
    # self[:file] = new_file.path
  end
  
  
  
  private
  
  def original_filename(new_file)
    if new_file and new_file.respond_to?(:original_filename)
      new_file.original_filename
    elsif path
      File.basename(path)
    end
  end
  
end
