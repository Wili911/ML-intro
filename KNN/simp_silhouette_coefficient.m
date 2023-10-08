function [coeff] = simp_silhouette_coefficient(points, clusters, cluster_means)
    N = length(points);
    K = length(cluster_means);
    %C_count = sum(clusters==1:max(clusters));
    S = zeros(K,1);
    ncluster = 1:K;
    for k=1:K
        cluster_points = points(clusters==k,:);
        Nk = length(cluster_points);
        Sk = zeros(Nk,1);
        for j=1:Nk
            A = vecnorm(cluster_points(j,:)-cluster_means(k,:),2,2);
            B = min(vecnorm(cluster_points(j,:)-cluster_means(ncluster(ncluster ~= k),:),2,2));
            Sk(j) = (B-A)/max(A,B);
        end
        S(k) = mean(Sk);
    end
    coeff = mean(S);