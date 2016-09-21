function [ scores, scores2, degrees ] = actor_char_all_unnormalized( A )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

N = size(A,1);
n_comb = 27;
scores = zeros(N, n_comb);
scores2 = zeros(N,9);
degrees = zeros(N,3);

for i=1:N
%display(i)
    t1_denominator = 0;
    t2_denominator = 0;
    t3_denominator = 0;
    t4_denominator = 0;
    t5_denominator = 0;
    t6_denominator = 0;
    t7_denominator = 0;
    t8_denominator = 0;
    t9_denominator = 0;    
    
%     disp(i)
    s_i_out = find(A(i, :));
    s_i_in  = find(A(:, i));
    s_i_c   = intersect(s_i_out, s_i_in);
    s_i_p   = setdiff(s_i_out, s_i_c);
    s_i_m   = setdiff(s_i_in, s_i_c);
    degrees(i,:) = [length(s_i_p) length(s_i_m) length(s_i_c)];
    for j=1:N
        if (i == j)
            continue
        end
        s_j_beta_out = find(A(j,:));
        s_j_beta_in = find(A(:,j));
        s_j_c   = intersect(s_j_beta_out, s_j_beta_in);
        s_j_p   = setdiff(s_j_beta_out, s_j_c);
        s_j_m   = setdiff(s_j_beta_in, s_j_c);
        
        % all sets calculated lets intersect
        % alpha = + beta = +
        t123_intersect = intersect(s_i_p, s_j_p);
        t123_len = length(t123_intersect);
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,1) = scores(i,1) + t123_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,2) = scores(i,2) + t123_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,3) = scores(i,3) + t123_len;
        end
        % alpha = + beta = -
        t456_intersect = intersect(s_i_p, s_j_m);
        t456_len = length(t456_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,4) = scores(i,4) + t456_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,5) = scores(i,5) + t456_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,6) = scores(i,6) + t456_len;
        end
        
        % alpha = + beta = o
        t789_intersect = intersect(s_i_p, s_j_c);
        t789_len = length(t789_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,7) = scores(i,7) + t789_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,8) = scores(i,8) + t789_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,9) = scores(i,9) + t789_len;
        end
        
        % alpha = - beta = +
        t101112_intersect = intersect(s_i_m, s_j_p);
        t101112_len = length(t101112_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,10) = scores(i,10) + t101112_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,11) = scores(i,11) + t101112_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,12) = scores(i,12) + t101112_len;
        end
        
        % alpha = - beta = -
        t131415_intersect = intersect(s_i_m, s_j_m);
        t131415_len = length(t131415_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,13) = scores(i,13) + t131415_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,14) = scores(i,14) + t131415_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,15) = scores(i,15) + t131415_len;
        end
        
        % alpha = - beta = o
        t161718_intersect = intersect(s_i_m, s_j_c);
        t161718_len = length(t161718_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,16) = scores(i,16) + t161718_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,17) = scores(i,17) + t161718_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,18) = scores(i,18) + t161718_len;
        end
        
        % alpha = o beta = +
        t192021_intersect = intersect(s_i_c, s_j_p);
        t192021_len = length(t192021_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,19) = scores(i,19) + t192021_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,20) = scores(i,20) + t192021_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,21) = scores(i,21) + t192021_len;
        end
        
                % alpha = o beta = -
        t222324_intersect = intersect(s_i_c, s_j_m);
        t222324_len = length(t222324_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,22) = scores(i,22) + t222324_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,23) = scores(i,23) + t222324_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,24) = scores(i,24) + t222324_len;
        end
        
        
                % alpha = o beta = o
        t252627_intersect = intersect(s_i_c, s_j_c);
        t252627_len = length(t252627_intersect);
        
        % if gama = +
        if (~isempty(find(s_i_p==j, 1)))
            scores(i,25) = scores(i,25) + t252627_len;
        end
        % if gama = -
        if (~isempty(find(s_i_m==j, 1)))
            scores(i,26) = scores(i,26) + t252627_len;
        end
        % if gama = o
        if (~isempty(find(s_i_c==j, 1)))
            scores(i,27) = scores(i,27) + t252627_len;
        end
        
        if(isempty(intersect(s_i_in, j)) && isempty(intersect(s_i_out, j)))
            t1_denominator = t1_denominator + t123_len;
            t2_denominator = t2_denominator + t456_len;
            t3_denominator = t3_denominator + t789_len;
            t4_denominator = t4_denominator + t101112_len;
            t5_denominator = t5_denominator + t131415_len;
            t6_denominator = t6_denominator + t161718_len;
            t7_denominator = t7_denominator + t192021_len;
            t8_denominator = t8_denominator + t222324_len;
            t9_denominator = t9_denominator + t252627_len;
        end
        
        
    end
%     scores(i,1:3) = scores(i,1:3) / t1_denominator;
%     scores(i,4:6) = scores(i,4:6) / t2_denominator;
%     scores(i,7:9) = scores(i,7:9) / t3_denominator;
%     scores(i,10:12) = scores(i,10:12) / t4_denominator;
%     scores(i,13:15) = scores(i,13:15) / t5_denominator;
%     scores(i,16:18) = scores(i,16:18) / t6_denominator;
%     scores(i,19:21) = scores(i,19:21) / t7_denominator;
%     scores(i,22:24) = scores(i,22:24) / t8_denominator;
%     scores(i,25:27) = scores(i,25:27) / t9_denominator;
    
    scores2(i,1) = t1_denominator;
    scores2(i,2) = t2_denominator;
    scores2(i,3) = t3_denominator;
    scores2(i,4) = t4_denominator;
    scores2(i,5) = t5_denominator;
    scores2(i,6) = t6_denominator;
    scores2(i,7) = t7_denominator;
    scores2(i,8) = t8_denominator;
    scores2(i,9) = t9_denominator;

end

% scores(isnan(scores)) = 0;
% scores2(isnan(scores2)) = 0;
% scores2(:,1) = scores2(:,1)./sum(scores2(:,1));
% scores2(:,2) = scores2(:,2)./sum(scores2(:,2));
% scores2(:,3) = scores2(:,3)./sum(scores2(:,3));
% scores2(:,4) = scores2(:,4)./sum(scores2(:,4));
% scores2(:,5) = scores2(:,5)./sum(scores2(:,5));
% scores2(:,6) = scores2(:,6)./sum(scores2(:,6));   
% scores2(:,7) = scores2(:,7)./sum(scores2(:,7));
% scores2(:,8) = scores2(:,8)./sum(scores2(:,8));
% scores2(:,9) = scores2(:,9)./sum(scores2(:,9));
% scores2(isnan(scores2)) = 0;
end

