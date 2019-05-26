module Xmrto
  (1..14).map do |i|
    clazz = "class Error#{i.to_s.rjust(3, "0")} < StandardError; end"
    eval(clazz)
  end
end
