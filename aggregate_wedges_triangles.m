function [ agg_scores, agg_scores2 ] = aggregate_wedges_triangles( scores, scores2 )
N = size(scores,1);
agg_scores = zeros(N,7);
agg_scores2 = zeros(N,6);

agg_scores(:,1) = sum(scores(:,[1,2,4,11,13,14]),2);
agg_scores(:,2) = sum(scores(:,[5,10]),2);
agg_scores(:,3) = sum(scores(:,[7,15,20]),2);
agg_scores(:,4) = sum(scores(:,[6,8,12,1,19,23]),2);
agg_scores(:,5) = sum(scores(:,[3,17,22]),2);
agg_scores(:,6) = sum(scores(:,[9,18,21,24,25,26]),2);
agg_scores(:,7) = scores(:,27);

agg_scores2(:,1) = sum(scores2(:,[2,4]),2);
agg_scores2(:,2) = scores2(:,1);
agg_scores2(:,3) = scores2(:,5);
agg_scores2(:,4) = sum(scores2(:,[3,7]),2);
agg_scores2(:,5) = sum(scores2(:,[6,8]),2);
agg_scores2(:,6) = scores2(:,9);

end

