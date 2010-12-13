# encoding: UTF-8

class AssetsController < ApplicationController
  
  before_filter :get_asset, :except => [ :index, :new, :create ]
  
  # The preview and thumbnails need to have a preview first
  before_filter :check_have_preview, :only => [ :preview, :small, :medium, :large ] 
  
  
  # GET /assets
  # GET /assets.xml
  def index
    @assets = Asset.ordered

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to(@asset, :notice => "#{@asset} was successfully created") }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to(@asset, :notice => "#{@asset} was successfully updated") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to(assets_url, :notice => "#{@asset} was successfully deleted" ) }
      format.xml  { head :ok }
    end
  end
  
  
  # GET /assets/1/preview
  # GET /assets/1/preview.png
  #
  # If the preview exists we send that down the pipe to the user
  # otherwise we ask the preview model for a missing_path
  # this will take into consideration if we haven't yet attempted to create an index
  def preview

    # Check to see if the image has been modified since they last requested the file
    # if it hasn't then we'll give them a 302, otherwise we'll send the file down the file

    if stale?(:etag => @asset.cache_key, :last_modified => @asset.preview.created_at.utc)
    
      respond_to do |format|
        format.png {
       
          # Send the file down the pipe...
          send_file @asset.preview.path, :type => "image/png", :disposition => "inline", :status => 200
        }
      end
    end
  end
  
  
  # Thumbnails
  #
  #
  # GET /assets/1/small
  # GET /assets/1/small.png
  def small
    
    if stale?(:etag => @asset.cache_key, :last_modified => @asset.preview.created_at.utc)
    
      respond_to do |format|
        format.png {
       
          # Send the file down the pipe...
          send_file @asset.thumbnails[:small].path, :type => "image/png", :disposition => "inline", :status => 200
        }
      end
    end
  end  
  
  # GET /assets/1/medium
  # GET /assets/1/medium.png
  def medium

    if stale?(:etag => @asset.cache_key, :last_modified => @asset.preview.created_at.utc)
    
      respond_to do |format|
        format.png {
       
          # Send the file down the pipe...
          send_file @asset.thumbnails[:medium].path, :type => "image/png", :disposition => "inline", :status => 200
        }
      end
    end
    
  end  
  
  # GET /assets/1/large
  # GET /assets/1/large.png
  def large
    
    
    if stale?(:etag => @asset.cache_key, :last_modified => @asset.preview.created_at.utc)
    
      respond_to do |format|
        format.jpg {
       
          # Send the file down the pipe...
          send_file @asset.thumbnails[:large].path, :type => "image/jpg", :disposition => "inline", :status => 200
        }
      end
    end
    
  end  
  
  
  
  
  
  private
  
  def get_asset
    @asset = Asset.find(params[:id])
  end
  
  
  # If the asset doesn't have a preview, we need to send down a generic image
  # 
  # Either the preview hasn't been created yet, or we were unable to create one
  #
  # There is a http status code for this situation...
  # 
  # 202 Accepted
  # The request has been accepted for processing
  # but the processing has not been completed. 
  # The request might or might not eventually be acted upon
  # as it might be disallowed when processing
  #
  def check_have_preview

    unless @asset.preview.exists?
    
      if action_name.downcase == 'preview'
        essence = @asset.preview 
      else
        essence = @asset.thumbnails[action_name.to_sym]
      end
      
      send_file essence.missing_path, 
                  :type => "image/#{essence.format}", 
                  :disposition => "inline", 
                  :status => 202
    end
    
    
    
  end
  
end
