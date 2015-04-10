def balanced(text)
	s = []
	text.scan(/[(){}]|\[|\]/) do |l|
		if %w!( [ {!.include? l
			case l 
			when "("; s << ")"
			when "["; s << "]"
			when "{"; s << "}"
			end
		elsif %w!) ] }!.include? l
			return false if s.empty? or s.pop != l
		end
	end

	s.empty? # balanced if stack is empty
end

puts "balanced" if balanced(%q{this teXt contains [pars (()()) (and(can be) very ) complex]. But ((it) is) [balanced].})
puts "not balanced" unless balanced(%q{this is (()))() not balanced.})
