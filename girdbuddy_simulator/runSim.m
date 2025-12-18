function [newBatterySoC_pct, loadShedded_W, newRefBatterySoC_pct] = runSim(systemState, solarInput_W, batterySoC_pct, discharge_W, loopPeriod_s, simulationSpeed, refBatterySoC_pct)
    
    wattPerOutlet = discharge_W/16;
    batteryCapacity_Ah = 800;
    batteryVoltage_V = 48;

     
    switch systemState
        case 'NORMAL'
            loadShedded_W=0;
        case 'ALERT1'
            loadShedded_W=wattPerOutlet;
        case 'ALERT2'
            loadShedded_W=2*wattPerOutlet;
        case 'CRITICAL'
            loadShedded_W=4*wattPerOutlet;
    end

    newBatterySoC_pct = batterySoC_pct - ((((discharge_W-loadShedded_W-solarInput_W)/batteryVoltage_V)*((loopPeriod_s*simulationSpeed)/3600))/batteryCapacity_Ah)*100;
    newRefBatterySoC_pct = refBatterySoC_pct - ((((discharge_W-solarInput_W)/batteryVoltage_V)*((loopPeriod_s*simulationSpeed)/3600))/batteryCapacity_Ah)*100;
    if newBatterySoC_pct>100
        newBatterySoC_pct=100;
    elseif newBatterySoC_pct<0
        newBatterySoC_pct=0;
    end

    if newRefBatterySoC_pct>100
        newRefBatterySoC_pct=100;
    elseif newRefBatterySoC_pct<0
        newRefBatterySoC_pct=0;
    end

end