function [systemState, battery_State, rateOfCharge_State] = runFSM(solarInput_W, batterySoC_pct, discharge_W, timeOfDay_State)
    load('StateTable.mat','keys','values')
    map = containers.Map(keys, values);

    % Determine Rate of Charge State
    if solarInput_W >= discharge_W
        rateOfCharge_State = 0;
    elseif solarInput_W < discharge_W
        rateOfCharge_State = 1;
    end

    % Determine Battery State
    if batterySoC_pct >= 75
        battery_State = 0;
    elseif batterySoC_pct >=50
        battery_State = 1;
    elseif batterySoC_pct >=25
        battery_State = 2;
    else
        battery_State = 3;
    end

    key = sprintf('%d_%d_%d', timeOfDay_State, battery_State, rateOfCharge_State);
    
    % Get the system state
    if isKey(map, key)
        systemState = map(key);
    else
        systemState = 'Unknown';
    end

end