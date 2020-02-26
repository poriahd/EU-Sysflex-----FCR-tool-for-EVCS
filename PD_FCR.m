function DailyFCR = PD_FCR(NewData,Etta)
% Build agregated power 
% Event = [0 0 0 8 30 0 0 0 0 12 30 0 1 1 10000 22 4 2.5 10];

DailyFCR.n = zeros(1,96);
DailyFCR.d = zeros(1,96);
DailyFCR.dn = zeros(1,96);
DailyFCR.nUp = zeros(1,96);
DailyFCR.nDown = zeros(1,96);
DailyFCR.Date = NewData(1,1:3);
DailyFCR.Events = 0;
DailyFCR.Energy = 0;

DayCount = 1;

for EventCount = 1:size(NewData,1)
     
    Event = NewData(EventCount,:);
    if  Event(1,16) > 30   % if the charger has DC charging, pmax is bypassed
        Pmax = Event(1,16);
    else
        Pmax = Event(1,19);
    end
    
    P0OptN = fminbnd(@OBJ_FCRN,Event(1,18),Pmax);
    [~,~,FCRN] = PD_FCR_1EV(Event,Etta,P0OptN);
    FCRdn = max(0,FCRN.Up - FCRN.n);
    
    
    P0OptD = fminbnd(@OBJ_FCRD,Event(1,18),Pmax);
    [~,~,FCRD] = PD_FCR_1EV(Event,Etta,P0OptD);
    
    if Pmax - P0OptD > 0.05* Pmax
        disp([' (Pmax - P0OptD)/Pmax %   = ' num2str((Pmax - P0OptD)*100/Pmax) ]);
    end
    
    if NewData(EventCount,1:3) == DailyFCR.Date(DayCount,1:3)
        DailyFCR.n(DayCount,:) = DailyFCR.n(DayCount,:) + FCRN.n;
        DailyFCR.dn(DayCount,:) = DailyFCR.dn(DayCount,:)...
            + FCRdn;
        DailyFCR.nUp(DayCount,:) = DailyFCR.nUp(DayCount,:) + FCRN.Up;
        DailyFCR.nDown(DayCount,:) = DailyFCR.nDown(DayCount,:) + FCRN.Down;
        DailyFCR.d(DayCount,:) = DailyFCR.d(DayCount,:) + FCRD.Up; 
        DailyFCR.Events(DayCount,1) = DailyFCR.Events(DayCount,1) + 1;
        DailyFCR.Energy(DayCount,1) = DailyFCR.Energy(DayCount,1) + ...
            Event(1,15)/1000;

    else
        DayCount = DayCount + 1;
        DailyFCR.Events(DayCount,1) = 1;
        DailyFCR.Date(DayCount,:) = NewData(EventCount,1:3);
        DailyFCR.n(DayCount,:) = FCRN.n;
        DailyFCR.dn(DayCount,:) = FCRdn;
        DailyFCR.nUp(DayCount,:) = FCRN.Up;
        DailyFCR.nDown(DayCount,:) = FCRN.Down;
        DailyFCR.d(DayCount,:) =  FCRD.Up;
        DailyFCR.Energy(DayCount,1) = Event(1,15)/1000;
    end
    
end



function Objn = OBJ_FCRN(P0)
    [temp,~,~] = PD_FCR_1EV(Event,Etta,P0);
    Objn = -1*temp;
end

function Objd = OBJ_FCRD(P0)
    [~,temp,~] = PD_FCR_1EV(Event,Etta,P0);
    Objd = -1*temp;
end

end