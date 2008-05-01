class UnitsController < ApplicationController
  layout 'base'
  
  # GET /units
  # GET /units.xml
  def index
    @units = Unit.find(:all)

    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @units }
    end
  end

  # No HTML view
  # GET /units/1.xml
  def show
    @unit = Unit.find(params[:id])

    respond_to do |format|
      format.xml  { render :xml => @unit }
    end
  end

  # GET /units/new
  # GET /units/new.xml
  def new
    @unit = Unit.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @unit }
    end
  end

  # GET /units/1/edit
  def edit
    @unit = Unit.find(params[:id])
  end

  # POST /units
  # POST /units.xml
  def create
    @unit = Unit.new(params[:unit])

    respond_to do |format|
      if @unit.save
        flash[:notice] = l(:flash_notice_unit_created)
        format.html { redirect_to Unit.new }
        format.xml  { render :xml => @unit, :status => :created, :location => @unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /units/1
  # PUT /units/1.xml
  def update
    @unit = Unit.find(params[:id])

    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        flash[:notice] = l(:flash_notice_unit_updated)
        format.html { redirect_to Unit.new }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /units/1
  # DELETE /units/1.xml
  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy

    flash[:notice] = l(:flash_notice_unit_deleted)
    respond_to do |format|
      format.html { redirect_to Unit.new }
      format.xml  { head :ok }
    end
  end
end
