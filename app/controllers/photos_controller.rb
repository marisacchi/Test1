class PhotosController < ApplicationController

	def destroy
		@photo = Photo.find(params[:id])
		listing = @photo.listing

		@photo.destroy
		@photos = Photo.where(listing_id: listing.id)

		respond_to :js
	end
end
