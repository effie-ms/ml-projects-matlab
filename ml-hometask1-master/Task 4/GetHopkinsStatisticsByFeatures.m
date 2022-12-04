function hopkStatTable = GetHopkinsStatisticsByFeatures(D,D1,D2,D3)
    hv11 = GetHopkinsStats(3,D,D1,1);
    hv21 = GetHopkinsStats(3,D,D2,1);
    hv31 = GetHopkinsStats(3,D,D3,1);
 
    hv12 = GetHopkinsStats(3,D,D1,2);
    hv22 = GetHopkinsStats(3,D,D2,2);
    hv32 = GetHopkinsStats(3,D,D3,2);
 
    hv13 = GetHopkinsStats(3,D,D1,3);
    hv23 = GetHopkinsStats(3,D,D2,3);
    hv33 = GetHopkinsStats(3,D,D3,3);
 
    hvD1 = [hv11' hv12' hv13];
    hvD2 = [hv21' hv22' hv23];
    hvD3 = [hv31' hv32' hv33];
 
    headerCols = [ "dim1", "dim2", "dim3", "dims1,2","dims1,3","dims2,3","dims1,2,3"];
    headerRows = [ "Cluster\features"; "Cluster1"; "Cluster2"; "Cluster3" ];
 
    hopkStatTable = [headerCols; hvD1; hvD2; hvD3];
    hopkStatTable = [headerRows, hopkStatTable];
end
 
 function hv = GetHopkinsStats(d,D,S,l)
    c = combnk(1:d,l);
    ll = size(c,1);
    hv = zeros(ll,1);
    for k = 1:ll
        hv(k) = MyHopkinsStatistic(D(:,c(k,:)),S(:,c(k,:)));
    end
 end

