function [solarFactor, timeOfDay_State] = solarFactorCalc(timeSinceMidnight_s)

    timeSinceMidnight_s = mod(timeSinceMidnight_s, 86400);
    sunrise_s = 21600; %6am
    sunset_s  = 64800; %6pm
    transition_s = 7200; %2hour

    if timeSinceMidnight_s<sunrise_s || timeSinceMidnight_s>=sunset_s
        solarFactor=0;
        timeOfDay_State=2;
        
    elseif sunrise_s<=timeSinceMidnight_s && timeSinceMidnight_s<sunrise_s+transition_s
        solarFactor = sin( pi * (timeSinceMidnight_s - sunrise_s) / (sunset_s - sunrise_s) );
        timeOfDay_State=1;

    elseif sunrise_s+transition_s<=timeSinceMidnight_s && timeSinceMidnight_s<sunset_s-transition_s
        solarFactor = sin( pi * (timeSinceMidnight_s - sunrise_s) / (sunset_s - sunrise_s) );        
        timeOfDay_State=0;

    elseif sunset_s-transition_s<=timeSinceMidnight_s && timeSinceMidnight_s<sunset_s
        solarFactor = sin( pi * (timeSinceMidnight_s - sunrise_s) / (sunset_s - sunrise_s) );
        timeOfDay_State=1;
    end    

end