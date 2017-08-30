function [ init_prob ] = max_init_prob( S_all,K,prob_t0, Cki )
% maximization step of initial probability
% init_prob, the output is of dimension K and the i'th element 
% is that naive state at initial time is in i'th state

% INPUTS : 
% K is the number of naive states possible 
%S_all is the set of all compound states possible
%S_all has w rows and K^w columns; each column is one compound state

% prob_t0 is the probability of all compound states at t=1; 
% it is a row or column vector of dimension K^w that adds up to 1

%Cki is indicatot function : 1 if ist state of i'th compound state is k

% initialization
init_prob=zeros(K,1);

for i=1:K % loop over K 
    for j=1:size(S_all,2)
       init_prob(i)= init_prob(i)+prob_t0(j)*Cki(i,j);%first_ind(S_all(:,j),i);
    end;
end;

%normalize to 1
x=sum(init_prob(:));

for i=1:K
    init_prob(i)=init_prob(i)/x;
end;



end

