# 1
def sum(text)
	s = 0
	text.scan(/\d+/) {|x| s+= x.to_i}
	s
end

s = "12 abc 45 def 678"
puts sum(s)

# by Petr Gurinov
s.scan(/\d+/).inject(0) { |result, elem| result + elem.to_i } 

# 2
class String
	def is_email?
		self =~ /^[a-zA-Z0-9.]+@[a-zA-Z0-9.]+$/
	end
end

puts "aziz.latypov@mail.ru".is_email? 	? "Yes" : "No"
puts "123-mail.ru".is_email? 			? "Yes" : "No"
puts "123.mail.ru".is_email? 			? "Yes" : "No"

# 3 
class String
	def is_float?
		self =~ /^[+-]?[0-9]+\.[0-9]*$/
	end
end

puts "10.0".is_float? ? "Yes" : "No"
puts "10.".is_float? 	? "Yes" : "No"
puts "10".is_float? 	? "Yes" : "No"

# 4
text = "There're. Four. Sentences. And six Words."
puts text.split(".").length
puts text.scan(/[a-zA-Z'-]+/).length

# 5
text = "This is a test and you are asked to remove an the array of special words"
words = %w{is are a an the}

def remove(text, words)
	splittedToWords = text.split(/\s+/) # split by spaces
	newText = splittedToWords.select {|w| !words.include? w}
	newText.join(' ')
end

text.split(/\s+/).delete_if { |w| words.include? w }  # by Dima Sablin
text.split(/\s+/) - words                             # by Elbek Juraev

puts remove(text, words)

# 6 # analogue for 5.times {...}
def ntimes(n, &b)
	for i in 1..n do
		yield
	end
end

i = 1 # this i differs from one used in for loop
j = 1
ntimes(5) { puts "#{i},#{j}"; j+=1 }

# 7
def func(hash = {})
	hash.each {|k,v| puts k.to_s.reverse }
end

func :abc => "123", :def => "456"

# 8
filename = "8.in.txt"
total  = 0
File.open(filename).each do |line|
	total += line.scan(/(\w+\d+|\d+\w+)+/).length
end

puts total

# 9
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

# and more advanced version

class String
	def regexp_with(ary)
		/#{(ary.collect { |w| Regexp.escape w }).join('|')}/
	end
	def balanced?(open = %w!( [ {!, close = %w!) ] }!)
		s = []
		regex = self.regexp_with(open + close)
		# p regex
		self.scan(regex) do |l|
			i = open.index(l)
			# puts "i=>#{i}, l=>#{l}"
			if i
				s << close[i]
			else
				return false if s.empty? or s.pop != l
			end
		end
	
		s.empty? # balanced if stack is empty
	end
end

text = %q{this text contains [pars (()()) (and(can be) very ) complex]. But ((it) is) [balanced].}
puts "balanced" if text.balanced?
puts "not balanced" unless %q{this is (()))() not balanced.}.balanced?

x = "+ - + - + + - -"
puts "#{x}.balanced? is #{x.balanced?(["+"],["-"])}"

x = "+ - + - + - -"
puts "#{x}.balanced? is #{x.balanced?(["+"],["-"])}"

# 10
class Array

	def quick_sort(&cmp)
		result = self.clone
		lcmp = block_given? ? cmp : lambda { |x,y| x<y } # by Dima Sablin
		__quick_sort(result, 0, self.length-1, lcmp)
		result
	end

	def merge_sort(&cmp)
		result = self.clone
		lcmp = block_given? ? cmp : lambda { |x,y| x<y } # by Dima Sablin
		__quick_sort(result, 0, self.length-1, lcmp)
		result
	end

private

	def __quick_sort(a, left, right, cmp)
		n = right - left
		return if n < 2

		p = left+n/2; t = a[p]
		i, j = left, right
		loop do
			i+= 1 while cmp.call a[i], t
			j-= 1 while cmp.call t, a[j]
			break if i>=j
			a[i], a[j] = a[j], a[i] # swap
			i += 1
			j -= 1
		end
		__quick_sort(a, left, i, cmp)
		__quick_sort(a, i, right, cmp)
	end

	def __merge_sort(ary, left, right, cmp)
		n = right - left
		return if n < 2

		p = left+n/2
		a = __merge_sort(ary, left, p, cmp)
		b = __merge_sort(ary, p, right, cmp)
		__merge(a, b, cmp)
	end

	def __merge(a, b, cmp)
		return a if b.empty?
		return b if a.empty?

		n = a.length + b.length
		ary = Array.new(n)
		i = j = k = 0
		while k < n do
			if cmp.call a[i], b[j] then
				ary << a[i]; i += 1
			else
				ary << a[j]; j += 1
			end
			k += 1
		end
		ary
	end
end

# n = Array.new
# n.__quick_sort(0,0,0) # Error: private method call

a = [11, -2, 53, 24, -15]
cmp = -> x,y { x > y } # equal to: cmp = lambda {|x,y| x < y}

qs = a.quick_sort {|x,y| x > y }
puts "quick_sort: #{qs.inspect}"

ms = a.merge_sort(&cmp)
puts "merge_sort: #{ms.inspect}"

# 11
class Array
	def choose(&b)
		r = []
		self.each {|e| r << e if b.call(e) }
		r
	end
end

x = [1,2,3,4,5,6,7,8].choose { |x| x%2 == 0 }
puts x.inspect
