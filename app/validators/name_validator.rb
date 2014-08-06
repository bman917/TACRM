class NameValidator < ActiveModel::Validator
  def validate(record)
    if record.person?
      result = find_profile(record, [:first_name,:middle_name,:last_name,:birth_day])
    else
      result = find_profile(record, [:name, :business_type])
    end

    if result && result.count > 0
      if record.person?
        record.errors[:base] << "Name '#{record.full_name}' has already been taken"
      else
        record.errors[:base] << "Corporate Name '#{record.full_name}' has already been taken"
      end

    end
  end

  def find_profile(record, options)
    options_sql = []
    options_val = []
    
    options.each do |o|
      val = record.send(o)
      if val
        options_sql.push "#{o.to_s} LIKE ?"
        options_val.push val
      else
        options_sql.push "#{o.to_s} is NULL"
      end
    end

    # puts "options_val: #{options_val}"
    options_val.unshift(options_sql.join(" AND "))
    # puts "shifted: #{options_val}"
    
    Profile.where(options_val)
  end
end