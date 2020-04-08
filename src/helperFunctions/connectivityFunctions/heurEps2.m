function epsilon = heurEps2(Pts)
    tic
    mean_d = 0;
    mean_n = 0;
    min_d = inf;
    max_d = -inf;
    max_n = -inf;

    n = length(Pts);

    for i=1:n
        nearest_dist = inf;
        for j=1:n
            if i == j, continue; end
            dist = norm(Pts(j,:) - Pts(i,:));
            mean_d = mean_d + dist;
            if min_d > dist, min_d = dist; end
            if max_d < dist, max_d = dist; end
            if nearest_dist > dist, nearest_dist = dist; end
        end
        mean_n = mean_n + nearest_dist;
        if max_n < nearest_dist, max_n = nearest_dist; end
    end

    mean_d = mean_d/(n*(n-1));
    mean_n = mean_n/n;

    epsilon = 20 * mean_d + 65 * min_d + 13 * max_n - 6 * max_d - 65 * mean_n;
    
    elapsedtime = toc
end

