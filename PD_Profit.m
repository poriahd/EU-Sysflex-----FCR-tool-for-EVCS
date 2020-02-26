function [AvProfit] = PD_Profit(DailyFCR,OptProfile,Price)
    
Lastday = size(DailyFCR.Date,1);
LastMonth = Lastday - 30 : Lastday - 1;   % last year events 

Profit.Title = {'Daily Profit' 'Average per EV' 'Average Per Eenrggy'};

for Cnt = 1:size(LastMonth,2)
   
% Real Profit

    temp = OptProfile.n - DailyFCR.n(LastMonth(1,Cnt),:);
    Profit.n(Cnt,1) = sum(OptProfile.n*Price(1,1) - min(temp,0)...
        *Price(1,2));
    Profit.n(Cnt,2) = Profit.n(Cnt,1)/...
        DailyFCR.Events(LastMonth(1,Cnt),:);
    Profit.n(Cnt,3) = Profit.n(Cnt,1)/...
        DailyFCR.Energy(LastMonth(1,Cnt),:);
    
    temp = OptProfile.dn - DailyFCR.dn(LastMonth(1,Cnt),:);
    Profit.dn(Cnt,1) = sum(OptProfile.dn*Price(1,3) - min(temp,0)...
        *Price(1,4)) + Profit.n(Cnt,1);
    Profit.dn(Cnt,2) = Profit.dn(Cnt,1)/...
        DailyFCR.Events(LastMonth(1,Cnt),:);
    Profit.dn(Cnt,3) = Profit.dn(Cnt,1)/...
        DailyFCR.Energy(LastMonth(1,Cnt),:);
    
    temp = OptProfile.d - DailyFCR.d(LastMonth(1,Cnt),:);
    Profit.d(Cnt,1) = sum(OptProfile.d*Price(1,3) - min(temp,0)...
        *Price(1,4));
    Profit.d(Cnt,2) = Profit.d(Cnt,1)/...
        DailyFCR.Events(LastMonth(1,Cnt),:);
    Profit.d(Cnt,3) = Profit.d(Cnt,1)/...
        DailyFCR.Energy(LastMonth(1,Cnt),:);
    
    
end
AvProfit = Profit
% AvProfit{1,1}='Total';
% AvProfit{1,2}=mean(Profit.n(:,1));
% AvProfit{3,1}=mean(Profit.n(:,2));
% AvProfit{4,1}=mean(Profit.n(:,3));
% 
% AvProfit{1,2}='Per Events';
% AvProfit{2,2}=mean(Profit.d(:,1));
% AvProfit{3,2}=mean(Profit.d(:,2));
% AvProfit{4,2}=mean(Profit.d(:,3));
% 
% AvProfit{1,3}='Per kWh';
% AvProfit{2,3}=mean(Profit.dn(:,1));
% AvProfit{3,3}=mean(Profit.dn(:,2));
% AvProfit{4,3}=mean(Profit.dn(:,3));



