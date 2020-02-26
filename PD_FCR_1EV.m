function [Objn,Objd,FCR] = PD_FCR_1EV(Data,Etta,P0)

ta = Data(1,4:5);
td = Data(1,10:11);
E = Data(1,15)/1000;
Pmax = Data(1,19);
Up = CreateProfile(ta,td);
Down = Up;
n = Up;

ta_h = ta(1,1) + ta(1,2)/60;
td_h = td(1,1) + td(1,2)/60;

for TimeCount = 1:96
    t = TimeCount/4 - 0.125;
    Up(1,TimeCount) = max(0,min(P0,(Pmax*Etta*(td_h-t-0.5)+...
        P0*Etta*(t+0.5-ta_h)-E)/(0.5*Etta)))*Up(1,TimeCount);
    Down(1,TimeCount) = max(0,min(Pmax - P0,(E - P0*Etta*(t+0.5-ta_h))/...
        (0.5*Etta)))*Down(1,TimeCount);
    n(1,TimeCount) = min(Up(1,TimeCount),Down(1,TimeCount));
end

FCR.Up = Up;
FCR.Down = Down;
FCR.n = n;
Objn = sum(n)/4;
Objd= sum(Up)/4;

end

function Profiles = CreateProfile(ta,td)
%     ta and td are a vector of [hour minute]
%     Profiles: vector showing 15 mintues profile which the elements will be
%                 1 if that time is between ta and td
%                 0 if that time is out of (ta,td)
%                 0<<1 if partly in (ta,td)
                    
    Profiles = zeros(1,96);    
    if ta(1,1) + ta(1,2)/60 <= td(1,1) + td(1,2)/60
        Ind_a = ta(1,1)*4 + ceil((ta(1,2) + 1)/15);
        Profiles(1,Ind_a) = 1 - mod(ta(1,2),15)/15;
        Ind_d = td(1,1)*4 + ceil((td(1,2) + 1)/15);
        Profiles(1,Ind_d) = mod(td(1,2),15)/15;
        Profiles(1,Ind_a+1:Ind_d-1) = 1;
    end    
end
