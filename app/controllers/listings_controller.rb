class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]


  def index
    @listings = current_user.listings
  end

  def show
    @photos = @listing.photos
    @booked = Reservation.where("listing_id = ? AND user_id = ?", @listing.id, current_user.id).present? if current_user

    @reviews = @listing.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save

      if params[:images]
        params[:images].each do |image|
          @listing.photos.create(image: image)
        end
      end

      @photos = @listing.photos
      redirect_to edit_listing_path(@listing), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @listing.user.id
      @photos = @listing.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @listing.update(listing_params)

      if params[:images]
        params[:images].each do |image|
          @listing.photos.create(image: image)
        end
      end

      redirect_to edit_listing_path(@listing), notice: "Updated..."
    else
      render :edit
    end
  end

  private
    def set_listing
      @listing = Listing.find(params[:id])
    end


    def listing_params
      params.require(:listing).permit(:listing_type, :experience_type, :accommodate, :street, :suburb, :city, :state, :post_code, :country, :expert_level, :fitness_level, :listing_name, :summary, :price, :active, :is_snb, :is_mtb, :is_ski, :is_golf, :is_surf, :is_car, :is_kayak, :is_paddle, :is_fitness, :is_yoga, :is_snorkel, :is_star, :is_fish, :is_hik, :is_trek, :is_other)
    end
end
