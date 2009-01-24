class Contact < ActiveForm

  attr_accessor :name, :number

  def number=(number)
    @number = number.gsub(/[ \.]/,'')
  end

end
