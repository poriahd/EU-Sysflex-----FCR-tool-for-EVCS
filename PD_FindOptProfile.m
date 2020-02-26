function [OptProfile] = PD_FindOptProfile(FCRDis,Price)
% This Function finds the optimum profile

nEdges = FCRDis.nEdges;
nCDF = FCRDis.nCDF;
PiFCRnOpt = Price(1,1)/(Price(1,1) + Price(1,2));
FCRnOpt = zeros(1,96);

dnEdges = FCRDis.dnEdges;
dnCDF = FCRDis.dnCDF;
FCRDafterNOpt = zeros(1,96);

Edgesd = FCRDis.dEdges;
CDFd = FCRDis.dCDF;
PiFCRdOpt = Price(1,3)/(Price(1,3) + Price(1,4));
FCRdOpt = zeros(1,96);

for CntTime = 1:96
    
    % find FCRN optimum 
    for CntEdge = 1:size(nEdges,2) - 1
        Temp = (nCDF(CntEdge,CntTime) - PiFCRnOpt)* ...
           (nCDF(CntEdge + 1,CntTime) - PiFCRnOpt);
        if Temp <= 0
            FCRnOpt(1,CntTime) = nEdges(CntEdge) + ...
               (nCDF(CntEdge + 1,CntTime) - nCDF(CntEdge,CntTime))/ ...
               (PiFCRnOpt - nCDF(CntEdge,CntTime))*...
               (nEdges(CntEdge + 1) - nEdges(CntEdge));
           break
        end
    end
    
     % find FCRDafterN optimum 
    for CntEdge = 1:size(dnEdges,2) - 1
        Temp = (dnCDF(CntEdge,CntTime) - PiFCRdOpt)* ...
           (dnCDF(CntEdge + 1,CntTime) - PiFCRdOpt);
        if Temp <= 0
            FCRDafterNOpt(1,CntTime) = dnEdges(CntEdge) + ...
               (dnCDF(CntEdge + 1,CntTime) - dnCDF(CntEdge,CntTime))/ ...
               (PiFCRdOpt - dnCDF(CntEdge,CntTime))*...
               (dnEdges(CntEdge + 1) - dnEdges(CntEdge));
           break
        end
    end
    
    % find FCRD optimum 
    for CntEdge = 1:size(Edgesd,2) - 1
        Temp = (CDFd(CntEdge,CntTime) - PiFCRdOpt)* ...
           (CDFd(CntEdge + 1,CntTime) - PiFCRdOpt);
        if Temp <= 0
            FCRdOpt(1,CntTime) = Edgesd(CntEdge) + ...
               (CDFd(CntEdge + 1,CntTime) - CDFd(CntEdge,CntTime))/ ...
               (PiFCRdOpt - CDFd(CntEdge,CntTime))*...
               (Edgesd(CntEdge + 1) - Edgesd(CntEdge));
           break
        end
    end
    
end

OptProfile.n = FCRnOpt;
OptProfile.dn = FCRDafterNOpt;
OptProfile.d = FCRdOpt;