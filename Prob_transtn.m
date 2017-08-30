function [ Prob_trans ] = Prob_transtn( alpha_mat, beta_mat, meas, F, v, noise_var, A, S_all , B_ij )
%Prob_trans(t,i,j) is the probability of being in state i at time t and
%state j at time t+1

% initiaization
Prob_trans=zeros(max(size(meas))-1,size(S_all,2), size(S_all,2));

for t=1:max(size(meas))-1
    for i=1:size(alpha_mat,2) % loop over all possible states at time t (from states)
        m=S_all(1,i); % the most recent naive state
        for j=1:size(beta_mat,2) % loop over all t+1 states (to state)
            n=S_all(1,j); % the most recent naive state
            Prob_trans(t,i,j)=alpha_mat(t,i)*normpdf(meas(t+1),F(j,:)*v, sqrt(noise_var))*A(m,n)*B_ij(i,j);
            Prob_trans(t,i,j)=Prob_trans(t,i,j)*beta_mat(t+1,j)/sum(alpha_mat(size(alpha_mat,1),:));
        end;
    end;
end;


end

