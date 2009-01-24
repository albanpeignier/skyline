class String
  def to_iso
    Iconv.new('ISO-8859-15','UTF-8').iconv(self)
  end
end
