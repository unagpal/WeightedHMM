function [ A_new ] = max_trans_prob(Prob_trans,B_ij,Cki )
%INPUTS : Prob_trans(t,i,j) is the transition probability of going from
%state i at time t to state j and time t+1
% B_ij is the indicator function of whether transition from compound state
% i to compound state j is feasible
% Cki is the indicator function of whether the most recent naive state for
% compound state i is k

%OUTPUT : A_new(i,j) is the probability of transition from state i to state
%j

% initialization of K by K transition matrix
A_new=zeros(size(Cki,1),size(Cki,1));

for t=1:size(Prob_trans,1) % loop over all times for which transition is possible
    for i=1:size(Prob_trans,2) % loop over all possible starting states
        for j=1:size(Prob_trans,2) % loop over all possible ending states
            for m=1:size(Cki,1)
                for n=1:size(Cki,1)
                    A_new(m,n)=A_new(m,n)+Prob_trans(t,i,j)*B_ij(i,j)*Cki(m,i)*Cki(n,j);
                end;
            end;
        end;
    end;
end;

for m=1:size(Cki,1)
    % sum of transition out of this state
    x=sum(A_new(m,:));
    for n=1:size(Cki,1)
        A_new(m,n)=A_new(m,n)/x;
    end;
end;


end

