function Cki=first_ind(S_all,K);
%INPUTS: K number of naive states and S_all the set of all compound states
% the output Cki has K rows and K^w column
% in each column there is only one element that is one and others are zero
% if element (k,i) of the C_ki is 1 that means for i'th compound state, the
% most recent naive state is k; else 0

% initialization
Cki=zeros(K,size(S_all,2));

for i=1:size(S_all,2)
    k=S_all(1,i);
    Cki(k,i)=1;
end;

