class ListingsController < ApplicationController
  def index
    @listings = Listing.all.order(created_at: :desc)
  end

  def show
    @listing = Listing.find(params[:id])
    @most_recent_listing_summary = @listing.most_recent_listing_summary
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)

    if @listing.save
      ListingSummaryService.new(@listing).summarize_via_openai
      redirect_to @listing
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:body)
  end
end
