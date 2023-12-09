function [coeff] = silhouette_coefficient(points, clusters, dist)
    N = length(points);
    K = length(clusters);
    %C_count = sum(clusters==1:max(clusters));
    S = zeros(N,1);
    npoints = 1:N;
    for i=1:N
        cluster = clusters(i);
        pci = clusters==cluster;
        %points_cluster = points(pci,:);
        A = mean(dist(i,pci));
        %A = mean(vecnorm(points(i,:)-points_cluster,2,2));
        ncluster = 1:K;
        other_clusters = ncluster(ncluster ~= cluster);
        Bl = zeros(K-1,1);
        for j=1:K-1
            %points_notcluster = points(clusters==k,:);        
            %Bl(k) = mean(vecnorm(points(i,:)-points_notcluster,2,2));            
            Bl(j) = mean(dist(i,npoints(clusters==other_clusters(j))));
        end
        B = min(Bl);
        S(i) = (B-A)/max(A,B);
    end
    coeff = mean(S);