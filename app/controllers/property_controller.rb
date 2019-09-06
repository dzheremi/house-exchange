class PropertyController < ApplicationController

  before_filter :is_logged_in

  def new
    @property = Property.new
  end

  def save
    @property = Property.new(property_params)
    @property.user = current_user
    if @property.save
      upload_io = params[:image]
      unless upload_io == nil
        @image = PropertyImage.new
        @image.property = @property
        @image.order = 0
        @image.file_name = Rails.root.join('public', 'uploads', @property.id.to_s + '_' + upload_io.original_filename).to_s
        File.open(@image.file_name, 'wb') do |file|
          file.write(upload_io.read)
        end
        @image.save
      end
      flash[:notice] = 'Your property has been added to our database!'
      redirect_to :action=>'list'
    else
      flash[:error] = 'Your property could not be added to our database!'
      render :action=>'new'
    end
  end

  def list
    @properties = current_user.properties
  end

  def edit
    @property = Property.find(params[:id])
    unless @property.user == current_user
      flash[:error] = 'You are not allowed to edit that property!'
      redirect_to :action=>'list'
    end
  end

  def update
    @property = Property.find(params[:id])
    if @property.user == current_user
      if @property.update(property_params)
        flash[:notice] = 'Your property has been updated!'
        redirect_to :action=>'list'
      else
        flash[:error] = 'Your property could not be updated!'
        render :action=>'edit'
      end
    else
      flash[:error] = 'You are not allowed to edit that property!'
      redirect_to :action=>'list'
    end
  end

  def delete
    @property = Property.find(params[:id])
    if @property.user == current_user
      if @property.delete
        flash[:notice] = 'Your property has been deleted!'
      else
        flash[:error] = 'Your property could not be deleted!'
      end
    else
      flash[:error] = 'You are not allowed to delete that property!'
    end
    redirect_to :action=>'list'
  end

  private
  def property_params
    params.require(:property).permit(:title, :address_1, :address_2, :suburb, :state, :post_code, :description)
  end
end
