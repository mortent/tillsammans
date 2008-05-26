class Time
  def midnight
    self.class.send(self.utc? ? :utc : :local, self.year, self.month, self.mday, 0)
  end
  
  def notes # 20080515T000000
    self.utc.strftime("%Y%m%dT%H%M%SZ")
  end

  def to_datetime
    ::DateTime.civil(year, month, day, 0, 0, 0, 0)
  end if RUBY_VERSION < '1.9'
end