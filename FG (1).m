function [ F,G ] = FG( S_all , weights, v)
%This function creates F_i and G_i for all compound states
% measurement=F*v=G*weights

% F has as many rows as the number of compound states and K columns
% G has as many rows as the number of compound states and K columns
% i'th row of F is =weights'*H_Si (F corresponding to i'th compound state)
% i'th row of G is =v'*H_Si'

w=max(size(weights));
K=max(size(v));

for i=1:size(S_all,2)
    H=zeros(w,K);
    for j=1:size(S_all,1)
        x=S_all(j,i);
        H(j,x)=1;
    end;
    F(i,:)=weights'*H;
    G(i,:)=v'*H';
end;



end

