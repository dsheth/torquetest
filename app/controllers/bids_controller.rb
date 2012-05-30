class BidsController < ApplicationController
  # GET /bids
  # GET /bids.json
  def index
    @bids = Bid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bids }
    end
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
    @bid = Bid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bid }
    end
  end

  # GET /bids/new
  # GET /bids/new.json
  def new
    @bid = Bid.new
    @auction = Auction.find(params[:auction])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bid }
    end
  end

  # GET /bids/1/edit
  def edit
    @bid = Bid.find(params[:id])
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(params[:bid])
    @bid.placed_time = Time.zone.now #potential problem here because we are using the datetime of the server.  If using multiple servers, will need to use a different strategy.
    @auction = Auction.find(params[:auction][:id])
    @bid.auction = @auction;
    @bid.user = current_user;
    if @bid.invalid?
       format.html { render :action => "new" }
       format.json { render :json => @bid.errors, :status => :unprocessable_entity }
       return
    end
    message = ''
  
    if @auction.expiration < @bid.placed_time 
      message = 'Auction already expired'
      @bid.status = 'auction_expired'
      @bid.save
    elsif @auction.highest_bid.nil?
      message = 'Successful bid placed'
      @bid.status = 'current_highest_bid'
      @auction.highest_bid = @bid
      @auction.transaction do
        @bid.save
        @auction.save
      end
    elsif  @auction.highest_bid.amount < @bid.amount
      message = 'Successful bid placed'
      @bid.status = 'current_highest_bid'
      @old_bid = @auction.highest_bid
      @old_bid.status = 'former_highest_bid'
      @auction.highest_bid = @bid
      @auction.transaction do
        @bid.save
        @auction.save
        @old_bid.save
      end
    else # bid too low
	  message = 'Bid amount too low'
	  @bid.status = 'bid_too_low'
	  @bid.save
	  
    end
    respond_to do |format|
      format.html { redirect_to @bid, :notice => message }
      format.json { render :json => @bid, :status => :created, :location => @bid }
    end
  end

  # PUT /bids/1
  # PUT /bids/1.json
  def update
    @bid = Bid.find(params[:id])

    respond_to do |format|
      if @bid.update_attributes(params[:bid])
        format.html { redirect_to @bid, :notice => 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bid.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid = Bid.find(params[:id])
    @bid.destroy

    respond_to do |format|
      format.html { redirect_to bids_url }
      format.json { head :no_content }
    end
  end
end
