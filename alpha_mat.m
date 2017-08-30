function [ alpha_mat ] = alpha_mat( init_prob, meas, noise_var, F, v, A, S_all , B_ij)
%alpha_mat(t,i) is the probability of all the observations upto time t and
%state at time t is the i'th compound state
% INPUTS : init_prob is the probability of being in each naive state at initial time
% it is a vector of dimension K where all elements add up to 1

%meas are the measurements

%noise_var is the noise variance

% F has K^w rows - one for each compound state
% v are thhe emissions
% A is the transition probability
%B_ij is the indicator matrix of whether transition from i to j is possible

% initialize alpha
alpha_mat=zeros(max(size(meas)),size(F,1));

% set the initial prob equal to all compound states where the naive state
% is consistent
for i=1:max(size(init_prob))
    I=find(S_all(1,:)==i);
    alpha_mat(1,min(I))=init_prob(i)*normpdf(meas(1),F(min(I),:)*v,sqrt(noise_var));
end;

% do the recursive implementation for alpha_mat(t,i)
for t=2:max(size(meas)) % loop over all times
    for j=1:size(S_all,2) % compute the probability of all compound states
        n=round(S_all(1,j)); %the naive state at time t for the compound state j
        for i=1:size(S_all,2) % loop over all compound states at time t-1
            m=round(S_all(1,i)); % the naive state at time t for the compound state i
            alpha_mat(t,j)=alpha_mat(t,j)+alpha_mat(t-1,i)*A(m,n)*B_ij(i,j)*normpdf(meas(t),F(j,:)*v,sqrt(noise_var));
        end;
    end;
end;
        

end

