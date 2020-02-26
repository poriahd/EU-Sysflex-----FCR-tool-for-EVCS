function [FCRDistribution] = PD_FCRDis(DailyFCR,BinNumber)
% This function analyses the FCR Data and creates the distribution


%% FCRn Distribution

% The distribution for FCR_N
BinMax = max(max(DailyFCR.n));
nPDF = zeros(BinNumber,96);
for Count = 1:96
    [temp,nEdges] = histcounts(DailyFCR.n(:,Count),...
        0:BinMax/BinNumber:BinMax);
    nPDF(:,Count) = temp/sum(temp);
end
% make CDF
nCDF (BinNumber+1,:) = zeros(1,96);
for Count = BinNumber:-1:1
    nCDF (Count,:) = nCDF (Count+1,:) + nPDF(Count,:);
end
% calculate the expected value
nExpect = nEdges(1,2:end)*nPDF; 

FCRDistribution.nPDF = nPDF;
FCRDistribution.nEdges = nEdges;
FCRDistribution.nCDF = nCDF;
FCRDistribution.nExpect = nExpect;


% The distribution for FCR_DafterN
BinMax = max(max(DailyFCR.dn));
dnPDF = zeros(BinNumber,96);
for Count = 1:96
    [temp,dnEdges] = histcounts(DailyFCR.dn(:,Count),...
        0:BinMax/BinNumber:BinMax);
    dnPDF(:,Count) = temp/sum(temp);
end
% make CDF
dnCDF (BinNumber+1,:) = zeros(1,96);
for Count = BinNumber:-1:1
    dnCDF (Count,:) = dnCDF (Count+1,:) + dnPDF(Count,:);
end
% calculate the expected value
dnExpect = dnEdges(1,2:end)*dnPDF; 

FCRDistribution.dnPDF = dnPDF;
FCRDistribution.dnEdges = dnEdges;
FCRDistribution.dnCDF = dnCDF;
FCRDistribution.dnExpect = dnExpect;


%% FCRD Distribution

BinMax = max(max(DailyFCR.d));
dPDF = zeros(BinNumber,96);
for Count = 1:96
    [temp,dEdges] = histcounts(DailyFCR.d(:,Count),...
        0:BinMax/BinNumber:BinMax);
    dPDF(:,Count) = temp/sum(temp);
end

% make CDF
dCDF (BinNumber+1,:) = zeros(1,96);
for Count = BinNumber:-1:1
    dCDF (Count,:) = dCDF (Count+1,:) + dPDF(Count,:);
end

% calculate the expected value
dExpect = dEdges(1,2:end)*dPDF; 



FCRDistribution.dPDF = dPDF;
FCRDistribution.dEdges = dEdges;
FCRDistribution.dCDF = dCDF;
FCRDistribution.dExpect = dExpect;
