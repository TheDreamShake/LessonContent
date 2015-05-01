require 'time'

class Event
end



def ask_user_for_selection
	puts "Options:
	1. Press 1 to add an event
	2. Press 2 to show events
	0. Press 0 to exit"
end

def list_all_events

	EVENTS.each_with_index do |event,index|
		puts "----- Event #{index +1} -----"
		puts " Name: #{event[:name]}"
		puts " Date: #{event[:date]}"
		puts " Start time: #{event[:starts_at]}"
		puts " End time: #{event[:ends_at]}"
		puts " invitees #{event[:invitees]} "
	end
end



def add_an_event
	new_event = {
		name: ask_for_event_name,
		date: ask_for_date,
		starts_at: ask_for_start_time,
		ends_at: ask_for_end_time,
		invitees: ask_for_invitees_list,
	}
	EVENTS << new_event
end

def ask_for_event_name
	event_name = ""

	while event_name.empty?
		puts "what is the event name?"
		event_name = gets.chomp
	end
	return event_name
end

def ask_for_date
	puts "ask_for_date"
	date = ""

	while date !~ /\d\d-\d\d-\d\d\d\d/

		
		puts "what is the date? e.g. 20-04-2014"
		date = gets.chomp
	end
	return date
end

def ask_for_start_time
	begin
        puts "what is start time? e.g. 11:00am"
	$start_time = Time.strptime(gets.chomp, "%I:%M%P")
	rescue ArgumentError
		puts "Remeber to use the format 09:00am"
		retry
	end
	
end


def ask_for_end_time
	begin
	
		puts "what is the end time? e.g. 10:10pm"
		end_time = Time.strptime(gets.chomp, "%I:%M%P")
		if end_time < $start_time
			raise ArgumentError
		end
	rescue ArgumentError
		retry
	end

end
#HW- END TIME EMPTY, ENSURE DATE IS LATER THAN OR EQUAL TO FIRST TIME

def ask_for_invitees_list
	invite = []
	while invite.empty?
		puts "Who is attending this event (email addresses seperated by a comma)"
		invite = gets.scan(/[a-zA-Z0-9]+@[a-zA-Z0-9]+\.com/)
	end


	return invite

end


def start!
	ask_user_for_selection
	case gets.chomp 
	when "1"
		add_an_event and start!
	when "2"
		list_all_events and start!
	when "0"
		exit()
	else
		start!
	end

end

start!

