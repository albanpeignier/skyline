class Contact < ActiveForm

  attr_accessor :name, :number

  def filtered_display_name
    @name.gsub(/&/,' ').gsub(/\s+/,' ')
  end

  def number=(number)
    @number = number.gsub(/[ \.]/,'')
  end

end
