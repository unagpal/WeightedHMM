function [ beta_mat ] = beta_mat(  meas, noise_var, F, v, A, S_all , B_ij)
%beta_mat(t,i) is the probability of all the future observations given that
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
beta_mat=zeros(max(size(meas)),size(S_all,2));

% set the final state to 1
for i=1:size(S_all,2)
    beta_mat(max(size(meas)),i)=1;
end;

% do the recursive implementation for beta_mat(t,i)
for k=1:max(size(meas))-1
    t=max(size(meas))-k;% loop over all times
    for i=1:size(F,1) % compute the probability of all compound states
        m=S_all(1,i); % the naive state at time t for the compound state i
        for j=1:size(F,1) % loop over all compound states at time t-1
            n=S_all(1,j); % the naive state at time t for the compound state i
            beta_mat(t,i)=beta_mat(t,i)+beta_mat(t+1,j)*A(m,n)*B_ij(i,j)*normpdf(meas(t+1),F(j,:)*v,sqrt(noise_var));
        end;
    end;
end;
        

end

