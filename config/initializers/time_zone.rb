class ActiveSupport::TimeWithZone
    def as_json(options = {})
        strftime('%m-%d-%Y')
    end
end
