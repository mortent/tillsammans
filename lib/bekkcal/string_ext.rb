class NilClass
  def blank?
    true
  end
end

class String
  def blank?
    self.strip == ''
  end
end

class Array
  def name(n)
    find{|e| e['@name'] == n}
  end
end