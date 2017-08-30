function [ v_est ] = max_v( Prob_state, F, meas )
% This is the least squares estimator for v 
% Prob_state(t,i) is the prob of compound state i at time t
% meas are the measurements of dimension T
% F is the matrix of K^w rows and K columns

M=zeros(size(F,2),size(F,2)); % this will be a K by K matrix
b=zeros(size(F,2),1); % this will be a K by 1 matrix

for i=1:size(F,2)
    for j=1:size(F,2)
        for t=1:size(Prob_state,1) % all times
            for q=1:size(F,1) % loop over all compound states
                M(i,j)=M(i,j)+Prob_state(t,q)*F(q,i)*F(q,j);
            end;
        end;
    end;
end;
        
for i=1:size(F,2)
    for t=1:size(Prob_state,1) % over all times
        for q=1:size(F,1) % over all compound states
            b(i)=b(i)+Prob_state(t,q)*F(q,i)*meas(t);
        end;
    end;
end;

v_est=M^-1*b;

end

