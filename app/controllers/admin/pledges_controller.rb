module Admin
  class PledgesController < Admin::AdminController
    def index
      @pledges = SmsPledge.all.map do |pledge|
        {
          name: pledge.donor.name,
          amount: pledge.amount,
          phone: pledge.donor.phone_number,
          message: pledge.message
        }
      end
    end
  end
end
