function Data = PD_MaxPower(Data)

[~,Index]=sort(Data(:,13));

TempIn = 1;
if Data(Index(TempIn),16) < 30
    TempMax = Data(Index(TempIn),18);
else
    TempMax = 0;
end

for CountIn = 2:size(Index,1)
    if Data(Index(CountIn),13) == Data(Index(TempIn),13)
        if Data(Index(CountIn),16) < 30 % the AC charger 
            TempMax = max(TempMax,Data(Index(CountIn),18));
        end
    else
        Data(Index(TempIn:CountIn - 1),19) = TempMax*ones(CountIn-TempIn,1);
        TempIn = CountIn;
        if Data(Index(TempIn),16) < 30
            TempMax = Data(Index(TempIn),18);
        else
            TempMax = 0;
        end
    end
end
% for updating Pmax in the last group.
Data(Index(TempIn:CountIn),19) = TempMax*ones(CountIn-TempIn+1,1);

