class Student < Database::Model

  self.attribute_names =  [:id, :cohort_id, :first_name, :last_name, :email,
                           :gender, :birthdate, :created_at, :updated_at] 

  attr_reader :attributes, :old_attributes



  # def self.all
  #   Database::Model.execute("SELECT * FROM students").map do |row|
  #     Student.new(row)
  #   end
  # end

  def self.where(query, *args)
    Database::Model.execute("SELECT * FROM students WHERE #{self.class.to_s}s", *args).map do |row|
      Student.new(row)
    end
  end


  def cohort
    Cohort.where('id = ?', self[:cohort_id]).first
  end

  def cohort=(cohort)
    self[:cohort_id] = cohort[:id]
    self.save
    cohort
  end

end
