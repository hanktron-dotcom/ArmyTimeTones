function bugleLogic(action, varargin)
    % Function to manage bugle call logic
    
    % Define the bugle call map
    persistent BugleCalls
    if isempty(BugleCalls)
        BugleCalls = containers.Map( ...
            {'Reveille', 'First Call', 'Mess Call', 'Assembly', 'Recall', 'Retreat', 'Tattoo', 'Taps'}, ...
            {'reveille.mp3', 'first_call.mp3', 'mess_call.mp3', 'assembly.mp3', ...
             'recall.mp3', 'retreat.mp3', 'tattoo.mp3', 'taps.mp3'} ...
        );
    end
    
    switch action
        case 'play'
            % Play the selected bugle call
            callName = varargin{1}; % Name of the call
            if ~strcmp(callName, 'Off') % Ensure it's not "Off"
                soundFile = BugleCalls(callName); % Get the file path
                [y, Fs] = audioread(soundFile); % Load audio
                sound(y, Fs); % Play sound
            end
        case 'validateTime'
            % Validate the time format
            enteredTime = varargin{1};
            if isempty(regexp(enteredTime, '^\d{4}$', 'once')) || ...
               str2double(enteredTime(1:2)) >= 24 || str2double(enteredTime(3:4)) >= 60
                error('Invalid time format. Please use HHMM (e.g., 1000).');
            end
        otherwise
            error('Unknown action.');
    end
end
