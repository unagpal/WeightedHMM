function [ S_all ] = all_compound(K,w )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
S_all = zeros(w, K^w);
K = round(K);
w = round(w);
for num = 1:K^w
            for d = 1:w
                        col = num-1;
                        x = mod(col, K^(w-d+1));
                        S_all(d, num) = 1 + floor (x/K^(w-d));
            end;
end;



end

