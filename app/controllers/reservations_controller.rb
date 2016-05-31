class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]

	def preload
		listing = Listing.find(params[:listing_id])
		today = Date.today
		reservations = listing.reservations.where("start_date >= ? OR end_date >= ?", today, today)

		render json: reservations
	end


	def preview
		start_date = Date.parse(params[:start_date])
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.create(reservation_params)

		if @reservation
			# send request to PayPal
			values = {
				business: 'mjane_58-facilitator@hotmail.com',
				cmd: '_xclick',
				upload: 1,
				notify_url: 'http://5dfb6ea4.ngrok.io/notify',
				amount: @reservation.total,
				item_name: @reservation.listing.listing_name,
				item_number: @reservation.id,
				quantity: '1',
				return: 'http://5dfb6ea4.ngrok.io/your_trips'
			}

			redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
		else
			redirect_to @reservation.listing, alert: "Oops, something went wrong..."
		end
	end

	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		status = params[:payment_status]

		reservation = Reservation.find(params[:item_number])

		if status = "Completed"
			reservation.update_attributes status: true
		else
			reservation.destroy
		end

		render nothing: true
	end

	protect_from_forgery except: [:your_trips]
	def your_trips
		@trips = current_user.reservations.where("status = ?", true)
	end

	def your_reservations
		@listings = current_user.listings
	end

	private

		def is_conflict(start_date, end_date)
			listing = Listing.find(params[:listing_id])

			check = listing.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
			check.size > 0? true : false
		end

		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date, :price, :total, :listing_id)
		end
end
