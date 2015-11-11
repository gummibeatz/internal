class DeveloperImporter
  require 'csv'

  def self.import(file)
    devs = []
    CSV.foreach(file.path) do |row|
      next if $. == 1
      name = row[0]
      email = row[1]
      github = row[2]
      first_name = row[3]
      last_name = row[4]
      application_id = row[5]
      borrow_laptop = row[6]
      tshirt_size = row[7]
      dietary_concerns = row[8]
      emergency_contact = row[9]
      gender = row[10]
      race_ethnicity = row[11]
      immigrant = row[12]
      education_status = row[13]
      income = row[14]
      dob = row[15].split('/')
      age = row[16]
      phone = row[22]
      personal_device = row[23]
      referral = row[24]
      how_did_you_hear = row[25]
      link_to_linkedin = row[27]
      link_to_online_portfolio = row[28]
      free_lunch = row[29]
      veteran = row[30]
      first_generation_college = row[31]
      hs = row[32]
      hs_gpa = row[33]
      sat_score = row[34]
      undergrad_school = row[35]
      undergrad_major = row[36]
      credits_earned = row[37]
      undergrad_gpa = row[38]
      grad_school = row[39]
      grad_major = row[40]
      grad_gpa = row[41]
      attended_public_university = row[42]
      is_current_student = row[43]
      degree_pursuing = row[44]
      current_institution = row[45]
      current_major = row[46]
      current_gpa = row[47]
      employment_status = row[48]
      employer = row[49]
      job_title = row[50]
      coding_background = row[59]
      address_1 = row[17]
      address_2 = row[18]
      city = row[19]
      state = row[20]
      zip = row[21]

      d = Developer.new
      d.full_name = name.downcase
      d.first_name = first_name.downcase
      d.last_name = last_name.downcase
      d.email = email
      d.github_username = github
      d.application_id = application_id
      d.borrows_laptop = borrow_laptop == "1" ? true : false
      d.race_ethnicity = race_ethnicity.gsub!(/^ *|(?<= ) | *$/, "")
      d.immigrant = immigrant == "Yes" ? true : false
      d.education_status = ["Some High School", "High School Graduate or Equivalent", "Some College - not currently pursuing a degree", "Pursuing an Associate Degree", "Possess an Associate Degree", "Pursuing a Bachelor's Degree", "Possess a Bachelor's Degree", "Pursuing a Graduate Degree", "Possess a Graduate Degree"].index education_status
      d.current_annual_income = income
      d.age = age
      d.phone = phone
      d.personal_device = {"iPhone smartphone" => :iphone, "Android smartphone" => :android}[personal_device]
      d.linkedin_url = link_to_linkedin
      d.online_portfolio_url = link_to_online_portfolio
      d.free_or_reduced_lunch = free_lunch == "Yes" ? true : false
      d.veteran = veteran == "Yes" ? true : false
      d.first_generation_college_student = first_generation_college == "Yes" ? true : false
      d.high_school_gpa_cents = (hs_gpa.to_f * 100).to_i
      d.sat_score = sat_score[/\d+/].to_i == 0? sat_score : sat_score[/\d+/].to_i
      d.undergrad_college_or_university = undergrad_school
      d.undergrad_major = undergrad_major
      d.number_of_undergrad_credits_cents = credits_earned != nil ? (credits_earned[/\d+/].to_f * 100).to_i : 0
      d.undergrad_gpa_cents = (undergrad_gpa.to_f * 100).to_i
      d.graduate_college_or_university = grad_school
      d.graduate_concentration = grad_major
      d.graduate_gpa_cents = (grad_gpa.to_f * 100).to_i
      d.public_or_community_college = attended_public_university == "No" ? false : true
      d.is_current_student = is_current_student == "Yes" ? true : false
      d.current_concentration = current_major
      d.current_gpa_cents = (current_gpa.to_f * 100).to_i
      d.current_employment_status = ["Student", "Retired", "Not employed and not looking for work", "Not employed, but looking for work", "Self-employed", "Employed Part-Time", "Employed Full-Time"].index employment_status
      d.current_employer = employer
      d.current_job_title = job_title

      d.coding_background = ["No exposure", "Limited exposure to coding", "Some self-directed/online learning", "Workshop or other training", "Some college-level coursework"].index coding_background

      d.gender = ["Female", "Male"].index(gender)
      d.date_of_birth = DateTime.new(dob[2].to_i, dob[0].to_i, dob[1].to_i)

      if d.save
        d.addresses.create({
          address_1: address_1,
          address_2: address_2,
          city: city,
          state: state,
          zip: zip
        })
        devs << d
      end
    end
    devs
  end


  def self.import_android(file)
    devs = []
    CSV.foreach(file.path) do |row|
      next if $. == 1
      first_name = row[0]
      last_name = row[1]
      district = row[2]
      github = row[3]
      age = row[7]
      email = row[8]
      phone = row[9]
      dob = row[11].split('/')


      d = Developer.new
      d.full_name = name.downcase
      d.first_name = first_name.downcase
      d.last_name = last_name.downcase
      d.email = email
      d.github_username = github
      d.application_id = application_id
      d.borrows_laptop = borrow_laptop == "1" ? true : false
      d.race_ethnicity = race_ethnicity.gsub!(/^ *|(?<= ) | *$/, "")
      d.immigrant = immigrant == "Yes" ? true : false
      d.education_status = ["Some High School", "High School Graduate or Equivalent", "Some College - not currently pursuing a degree", "Pursuing an Associate Degree", "Possess an Associate Degree", "Pursuing a Bachelor's Degree", "Possess a Bachelor's Degree", "Pursuing a Graduate Degree", "Possess a Graduate Degree"].index education_status
      d.current_annual_income = income
      d.age = age
      d.phone = phone
      d.personal_device = {"iPhone smartphone" => :iphone, "Android smartphone" => :android}[personal_device]
      d.linkedin_url = link_to_linkedin
      d.online_portfolio_url = link_to_online_portfolio
      d.free_or_reduced_lunch = free_lunch == "Yes" ? true : false
      d.veteran = veteran == "Yes" ? true : false
      d.first_generation_college_student = first_generation_college == "Yes" ? true : false
      d.high_school_gpa_cents = (hs_gpa.to_f * 100).to_i
      d.sat_score = sat_score[/\d+/].to_i == 0? sat_score : sat_score[/\d+/].to_i
      d.undergrad_college_or_university = undergrad_school
      d.undergrad_major = undergrad_major
      d.number_of_undergrad_credits_cents = credits_earned != nil ? (credits_earned[/\d+/].to_f * 100).to_i : 0
      d.undergrad_gpa_cents = (undergrad_gpa.to_f * 100).to_i
      d.graduate_college_or_university = grad_school
      d.graduate_concentration = grad_major
      d.graduate_gpa_cents = (grad_gpa.to_f * 100).to_i
      d.public_or_community_college = attended_public_university == "No" ? false : true
      d.is_current_student = is_current_student == "Yes" ? true : false
      d.current_concentration = current_major
      d.current_gpa_cents = (current_gpa.to_f * 100).to_i
      d.current_employment_status = ["Student", "Retired", "Not employed and not looking for work", "Not employed, but looking for work", "Self-employed", "Employed Part-Time", "Employed Full-Time"].index employment_status
      d.current_employer = employer
      d.current_job_title = job_title

      d.coding_background = ["No exposure", "Limited exposure to coding", "Some self-directed/online learning", "Workshop or other training", "Some college-level coursework"].index coding_background

      d.gender = ["Female", "Male"].index(gender)
      d.date_of_birth = DateTime.new(dob[2].to_i, dob[0].to_i, dob[1].to_i)

      if d.save
        d.addresses.create({
          address_1: address_1,
          address_2: address_2,
          city: city,
          state: state,
          zip: zip
        })
        devs << d
      end
    end
    devs
  end
end

