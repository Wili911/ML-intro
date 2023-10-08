function [coeff] = silhouette_coefficient(points, clusters, dist)
    N = length(points);
    K = length(clusters);
    %C_count = sum(clusters==1:max(clusters));
    S = zeros(N,1);
    for i=1:N
        cluster = clusters(i);
        pci = clusters==cluster;
        pci(i) = 0;
        %points_cluster = points(pci,:);
        A = mean(dist(i,pci));
        %A = mean(vecnorm(points(i,:)-points_cluster,2,2));
        ncluster = 1:K;
        Bl = zeros(K-1,1);
        for k=ncluster(ncluster ~= cluster)
            %points_notcluster = points(clusters==k,:);        
            %Bl(k) = mean(vecnorm(points(i,:)-points_notcluster,2,2));
            Bl(k) = mean(dist(i,clusters==k));
        end
        B = min(Bl);
        S(i) = (B-A)/max(A,B);
    end
    coeff = mean(S);