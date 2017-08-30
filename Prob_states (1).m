function [ Prob_state ] = Prob_states( alpha_mat, beta_mat )
%Prob_state(t,i) is the probability of being in state i at time t


for t=1:size(alpha_mat,1)
    for i=1:size(alpha_mat,2)
        Prob_state(t,i)=alpha_mat(t,i)*beta_mat(t,i)/sum(alpha_mat(size(alpha_mat,1),:));
    end;
end;


end

