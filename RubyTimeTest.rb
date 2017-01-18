require 'date'

# Wait for user to enter the correct input before proceeding
# Function accepts one argument myvar, which can be of any data type
# Function has no returns
def waitforinput(myvar)
	puts "Please enter " + myvar.to_s + " to continue."
	name = gets.chomp
	if name.to_s != myvar.to_s
		puts "That was not the correct input"
		waitforinput(myvar)
	else
		puts "The program will now proceed"
	end
end


#This is a function to change a toggle variable state
#Variables are converted to a string, allowing for any type of input
#The return of the function is toggle in its new state.
def changetoggle(toggle, stateOne, stateTwo)
	toggles = toggle.to_s
	stateOnes = stateOne.to_s
	stateTwos = stateTwo.to_s
	if toggles == stateOnes
		toggle = stateTwo
	else toggles == stateTwos
		toggle = stateOne
	end
	return toggle
end

# Logs the time spent in each mode
# Function has no returns: requires two public arrays
# Had issues getting the correct values of time inputs, use the following:
# (Time.now.to_f * 1000).floor
def logtoggletime(toggle, startTime, endTime, arrayOn, arrayOff)
	millistime = endTime - startTime
	if toggle == "On"
		arrayOn << millistime
	elsif toggle == "Off"
		arrayOff << millistime
	end
end


arrayOn = []
arrayOff = []
toggle = "On"
onmode = "On"
offmode = "Off"
waitforinput("s")
starttime = (Time.now.to_f * 1000).floor
startround = starttime
avar = true
while avar == true
	puts "Press x to change toggle"
	input = gets.chomp
	endround = (Time.now.to_f * 1000).floor
	if input.to_s == "x"
		logtoggletime(toggle, startround, endround, arrayOn, arrayOff)
		toggle = changetoggle(toggle, onmode, offmode)
		puts "toggle is " + toggle.to_s + "."
	elsif input.to_s == "v"
		logtoggletime(toggle, startround, endround, arrayOn, arrayOff)
		puts "The game is now ending"
		endtime = endround
		avar = false
	else
		puts "That is not a valid input. Press x to toggle or v to quit"
	end
	startround = endround
end
totalGameTime = endtime - starttime
puts "Total game time is " + totalGameTime.to_s
sumOn = 0
sumOff = 0
arrayOn.each {|x| sumOn = sumOn + x}
arrayOff.each{|x| sumOff = sumOff + x}

puts "Total On time: " + sumOn.to_s
puts "Total Off time " + sumOff.to_s
puts "Variance : " + (totalGameTime - (sumOn + sumOff)).to_s
puts "Time spent By round:"
puts "On time by round"
arrayOn.each {|x| puts x}
puts "Off time by round"
arrayOff.each{|x| puts x}
