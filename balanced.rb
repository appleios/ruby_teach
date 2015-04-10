class String
	def balanced?
		s = []
		self.scan(/[(){}]|\[|\]/) do |l|
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
end

puts "balanced" if %q{this text contains [pars (()()) (and(can be) very ) complex]. But ((it) is) [balanced].}.balanced?
puts "not balanced" unless %q{this is (()))() not balanced.}.balanced?
