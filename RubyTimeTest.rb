#Ruby Time Test
#
#Time Test game in Ruby as a test of skill in preparation for Rails

#Directions:
#Follow the game prompts.
#The game will ask the user to click 's' to begin the game
#From then on the user will have two options: press 'x' to turn mode on and off, or 'v' to quit
#Upon quitting the game, the user is provided stats on game length.

#date is required for getting the current time
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
#The return of the function is toggle in its new state.  Data type of new state not affected by string conversion.
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
# Had issues getting the correct values of time inputs, use the following for millis:
# (Time.now.to_f * 1000).floor
def logtoggletime(toggle, startTime, endTime, arrayOn, arrayOff)
	millistime = endTime - startTime
	if toggle == "On"
		arrayOn << millistime
	elsif toggle == "Off"
		arrayOff << millistime
	end
end

#Set game variables
#The array variables will store game on and off time
#The mode variables tell our change toggle function the options for our toggle
#The toggle starts in off mode
arrayOn = []
arrayOff = []
toggle = "On"
onmode = "On"
offmode = "Off"

#Wait for user to click 's' to begin game
waitforinput("s")

#This is the bulk of the game
#Accounting for the first round requires roundtime to be equal to starttime
#The game loops until the user selects 'v'
starttime = (Time.now.to_f * 1000).floor
startround = starttime
avar = true
while avar == true
	puts "Press x to change toggle or v to quit"
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

#Section sums up the arrays and compares to total game time
totalGameTime = endtime - starttime
sumOn = 0
sumOff = 0
arrayOn.each {|x| sumOn = sumOn + x}
arrayOff.each{|x| sumOff = sumOff + x}
variance = totalGameTime - (sumOn + sumOff)

#This last section outputs game stats to the user
puts "Total game time is " + totalGameTime.to_s
puts "Total On time: " + sumOn.to_s
puts "Total Off time " + sumOff.to_s
puts "Variance : " + variance.to_s
puts "Time spent By round:"
puts "On time by round"
arrayOn.each {|x| puts x}
puts "Off time by round"
arrayOff.each{|x| puts x}
