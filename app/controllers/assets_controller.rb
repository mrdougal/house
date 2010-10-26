class AssetsController < ApplicationController
  
  before_filter :get_asset, :only => [:update, :show, :edit, :destroy, :preview]
  
  # GET /assets
  # GET /assets.xml
  def index
    @assets = Asset.all

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

    if @asset.preview.exists?

      # We have an image to send down the pipe
      file_path = @asset.preview.path
    else
      
      # We don't have a file to send down the wire
      # Either the preview hasn't been created yet, or we were unable to create one
      file_path = @asset.preview.missing_path
      
    end

    send_file file_path, :type => "image/png", :disposition => "inline"  
    
  end
  
  
  # Thumbnails
  #
  #
  # GET /assets/1/small
  # GET /assets/1/small.png
  def small
    
  end  
  
  # GET /assets/1/medium
  # GET /assets/1/medium.png
  def medium
    
  end  
  
  # GET /assets/1/large
  # GET /assets/1/large.png
  def large
    
  end  
  
  
  
  
  
  private
  
  def get_asset
    @asset = Asset.find(params[:id])
  end
  
end
