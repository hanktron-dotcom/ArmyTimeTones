  % Repeating Daily Bugle Clock Script

% List of bugle calls and their respective times
bugleCalls = {

   % '2214', 'first_call.mp3';         % 0655 - First Call
   % '2157', 'reveille.mp3';           % 0700 - Reveille
   % '2158', 'retreat.mp3';            % 1655 - Retreat
   % '2159', 'to_the_color.mp3';       % 1700 - To the Color
   % '2201', 'call_to_quarters.mp3';   % 1900 - Call to Quarters
   % '2202', 'tattoo.mp3';             % 2000 - Tattoo
   % '2202', 'taps.mp3';               % 2200 - Taps

    '0655', 'first_call.mp3';         % 0655 - First Call
    '0700', 'reveille.mp3';           % 0700 - Reveille
    '1655', 'retreat.mp3';            % 1655 - Retreat
    '1700', 'to_the_color.mp3';       % 1700 - To the Color
    '1900', 'call_to_quarters.mp3';   % 1900 - Call to Quarters
    '2000', 'tattoo.mp3';             % 2000 - Tattoo
    '2200', 'taps.mp3';               % 2200 - Taps
};

% Get today's date and construct full datetime objects for the schedule
todayDate = datetime('now', 'Format', 'yyyy-MM-dd'); % Get today's date
callTimes = cellfun(@(time) datetime([char(todayDate), ' ', time], 'InputFormat', 'yyyy-MM-dd HHmm'), bugleCalls(:, 1), 'UniformOutput', false);
callTimes = [callTimes{:}]'; % Convert to a column array of datetime

disp('Bugle times (initial schedule):');
disp(callTimes); % Debugging output

% Main loop to check time and play bugle calls
while true
    currentTime = datetime('now'); % Always get current time from the system
    disp(['Current time: ', datestr(currentTime, 'yyyy-MM-dd HH:mm:ss')]); % Debugging output
    
    % Check each bugle call
    for i = 1:length(callTimes)
        disp(['Checking: ', bugleCalls{i, 2}, ' at ', datestr(callTimes(i), 'yyyy-MM-dd HH:mm:ss')]); % Debugging output
        
        % If the current time matches the scheduled time
        if currentTime >= callTimes(i) && currentTime < callTimes(i) + seconds(59)
            % Play the bugle call
            try
                [y, Fs] = audioread(bugleCalls{i, 2}); % Read audio file
                sound(y, Fs); % Play sound
                disp(['Playing: ', bugleCalls{i, 2}, ' at ', datestr(currentTime, 'yyyy-MM-dd HH:mm:ss')]); % Debugging output
            catch ME
                disp(['Error playing file: ', bugleCalls{i, 2}]);
                disp(ME.message);
            end
            
            % Reschedule the call for the next day
            callTimes(i) = callTimes(i) + days(1); % Move to the next day
            disp(['Next scheduled time for ', bugleCalls{i, 2}, ': ', datestr(callTimes(i), 'yyyy-MM-dd HH:mm:ss')]); % Debugging output
        end
    end
    
    pause(1); % Prevent high CPU usage by pausing for 1 second
end
