function [ noise_var ] = max_noise_wknown(Prob_state, meas, G, weights )
%OUTPUT : output of the function is the measurement variance estimate
%INPUTS : Prob_state is the probability of being in each compoind state
% Prob_state has the dimension T (number of observations) times K^w
% Prob_state(t,i) is the probability of being in compound state i at time t

% meas is the sequence of measuremenst. It is a row or column vector of
% dimension T

% weights are the weights. It is a vector of dimension w. the first element
% is the weight of the most recent emission

% v is the vector of emissions for each state. it is a vector of dimension
% K

% F(i,:)*v is the estimated measurement without noise given compound state
% i

% G(i,:)*weights is the estimated measurement without noise given compound state
% i

sum_state_prob=0;
error_sqr=0;

for t=1:max(size(meas)) % sum over all times
    for i=1:size(Prob_state,1) % sum over all compound states
        sum_state_prob=sum_state_prob+Prob_state(t,i);
        error_sqr=error_sqr+Prob_state(t,i)*(meas(t)-G(i,:)*weights)^2;
    end;
end;

noise_var=error_sqr/sum_state_prob;

end

