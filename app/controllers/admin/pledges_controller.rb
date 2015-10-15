module Admin
  class PledgesController < Admin::AdminController
    def index
      @pledges = SmsPledge.order(created_at: :desc).all.map do |pledge|
        {
          created_at: pledge.created_at,
          name: pledge.donor.name,
          amount: pledge.amount,
          phone: pledge.donor.phone_number,
          message: pledge.message
        }
      end
    end
  end
end
