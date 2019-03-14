global BridgeAddress
global apiKey
set BridgeAddress to "10.0.0.4"
set apiKey to "TOKEN"

global turnOn
global turnOff
set turnOn to the quoted form of "{\"on\": true,\"hue\": 0, \"sat\": 0,\"bri\": 200,\"transitiontime\": 0}"
set turnOff to the quoted form of "{\"on\": false,\"hue\": 0, \"sat\": 0,\"transitiontime\": 0}"

run evaluateState
script flasher

	set OfficeLampState to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/"

	set the_String to OfficeLampState
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try

	set OfficeLamppower to (item 3 of these_items)
	set OfficeLampbri to (item 5 of these_items)
	set OfficeLamphue to (item 7 of these_items)
	set OfficeLampsat to (item 9 of these_items)
	set OfficeLampct to (item 14 of these_items)
	set OfficeLampx to (item 11 of these_items)
	set OfficeLampy to (item 12 of these_items)


	set Yellow1 to "{\"hue\": " & 16384 & ", \"sat\": 255,\"bri\": " & OfficeLampbri & ",\"transitiontime\": 0}"
	set Yellow1 to the quoted form of Yellow1


	delay 1

	repeat 1 times
		delay 1
		do shell script "curl --request PUT --data " & Yellow1 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/state/"
	end repeat


	set OfficeLampRestore to "{\"on\": true,\"bri\": " & OfficeLampbri & ",\"hue\": " & OfficeLamphue & ",\"xy\": " & OfficeLampx & "," & OfficeLampy & ",\"sat\": " & OfficeLampsat & ",\"ct\": " & OfficeLampct & ",\"transitiontime\": 0}"
	set OfficeLampRestore to the quoted form of OfficeLampRestore

	do shell script "curl --request PUT --data " & OfficeLampRestore & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/state/"
end script


script evaluateState

	set OfficeLampState to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/"

	set the_String to OfficeLampState
	try
		set oldDelims to AppleScript's text item delimiters
		set AppleScript's text item delimiters to {":", ","}
		set these_items to the text items of the_String
		set AppleScript's text item delimiters to oldDelims
	on error
		set AppleScript's text item delimiters to oldDelims
	end try
	set OfficeLamppower to (item 3 of these_items)
	set OfficeLampbri to (item 5 of these_items)
	set OfficeLamphue to (item 7 of these_items)
	set OfficeLampsat to (item 9 of these_items)
	set OfficeLampct to (item 14 of these_items)
	set OfficeLampx to (item 11 of these_items)
	set OfficeLampy to (item 12 of these_items)

	if OfficeLamppower = "true" then
		run flasher
	else
		do shell script "curl --request PUT --data " & turnOn & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/state/"
		delay 2

		set OfficeLampState to do shell script "curl --request GET http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/"

		set the_String to OfficeLampState
		try
			set oldDelims to AppleScript's text item delimiters
			set AppleScript's text item delimiters to {":", ","}
			set these_items to the text items of the_String
			set AppleScript's text item delimiters to oldDelims
		on error
			set AppleScript's text item delimiters to oldDelims
		end try

		set OfficeLamppower to (item 3 of these_items)
		set OfficeLampbri to (item 5 of these_items)
		set OfficeLamphue to (item 7 of these_items)
		set OfficeLampsat to (item 9 of these_items)
		set OfficeLampct to (item 14 of these_items)
		set OfficeLampx to (item 11 of these_items)
		set OfficeLampy to (item 12 of these_items)


		set Yellow1 to "{\"hue\": " & 16384 & ", \"sat\": 255,\"bri\": " & OfficeLampbri & ",\"transitiontime\": 0}"
		set Yellow1 to the quoted form of Yellow1

		delay 1

		repeat 1 times
			delay 1
			do shell script "curl --request PUT --data " & Yellow1 & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/state/"
		end repeat

		do shell script "curl --request PUT --data " & turnOff & " http://" & BridgeAddress & "/api/" & apiKey & "/lights/3/state/"
	end if
end script
