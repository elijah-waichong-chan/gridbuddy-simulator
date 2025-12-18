function [loadFactor] = loadFactorCalc(timeSinceMidnight_s)

    timeSinceMidnight_s = mod(timeSinceMidnight_s, 86400);

    % Convert seconds to hours for easier logic
    hour =  timeSinceMidnight_s / 3600;

    if hour < 6
        % Early morning: minimal load
        loadFactor = 10 + 5 * sin(pi * hour / 6);  % 10% to ~15%
    elseif hour < 9
        % Morning ramp-up
        loadFactor = 15 + 45 * ((hour - 6) / 3);  % 15% to 60%
    elseif hour < 17
        % Daytime average use
        loadFactor = 50 + 10 * sin(pi * (hour - 9) / 8);  % ~50–60%
    elseif hour < 21
        % Evening peak
        loadFactor = 60 + 40 * sin(pi * (hour - 17) / 4);  % up to 100%
    else
        % Nighttime taper
        loadFactor = 30 + 10 * cos(pi * (hour - 21) / 3);  % ~30% to 40%
    end

end