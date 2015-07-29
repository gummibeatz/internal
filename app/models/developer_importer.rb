class DeveloperImporter
  def self.import(file)
    CSV.foreach(file.path) do |row|
      next if $. == 1
      email = row[1]
      github = row[2]
      first_name = row[3]
      last_name = row[4]
      application_id = row[5]
      tshirt_size = row[7]
      gender = row[10]
      immigrant = row[12]
      income = row[14]
      age = row[16]
      dob = row[15].split('/')
      phone = row[22]
      personal_device = row[23]
      veteran = row[31]
      free_lunch = row[29]
      hs = row[32]
      hs_gpa = row[33]

      address_1 = row[17],
      address_2 = row[18],
      city = row[19],
      state = row[20],
      zip = row[21]

      d = Developer.new
      d.first_name = first_name
      d.last_name = last_name
      d.email = email
      d.github_username = github
      d.application_id = application_id
      d.tshirt_size = ["X-Small", "Small", "Medium", "Large", "X-Large"].index tshirt_size
      d.immigrant = immigrant == "Yes" ? true : false
      d.current_annual_income = income
      d.age = age
      d.phone = phone
      d.high_school = hs
      d.high_school_gpa_cents = (hs_gpa.to_f * 100).to_i
      d.personal_device = {"iPhone smartphone" => :iphone, "Android smartphone" => :android}[personal_device]
      d.veteran = veteran == "Yes" ? true : false
      d.gender = ["Female", "Male"].index gender
      d.date_of_birth = DateTime.new(dob[2].to_i, dob[0].to_i, dob[1].to_i)
      d.free_or_reduced_lunch = free_lunch == "Yes" ? true : false
      if d.save
        d.addresses.create({
          address_1: address_1,
          address_2: address_2,
          city: city,
          state: state,
          zip: zip
        })
      end
    end
  end
end

