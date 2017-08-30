% this model runs the HMM algorithm by calling various functions

% Input "meas" which is the measurements for all times

% initialization of inputs
w=2; %memory size
K=2; % number of states
init_prob=[0.5 ; 0.5]; 
weights=[0.5 ; 0.5];
v=[1 ; 3];
A=[0.5 0.5; 0.5 0.5]; %transition prob; eaach row adds up to 1
noise_var=1; % variance of measurement noise

% compute the parameters that do not change
% all compound states
S_all=all_compound(K,w );
% indicator function of first Naive state
Cki=first_ind(S_all,K);
%indicator of all transitions that are possible
B_ij=trans_ind(S_all);

%%%%%
% MAIN PROGRAM
for counter=1:3 % outer loop for the number of times 
    
    % Weights known v unknown
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute F and G for all compound state; measurement=F*v=G*weights
    % each row of F and G corresponds to one compound row
    % i'th row of F and G are the rows corresponding to i'th column of
    % S_all
    [ F,G ] = FG( S_all , weights, v);
    
    %EXPECTATION STEP
    % compute the alpha
    alpha_mat1 = alpha_mat( init_prob, meas, noise_var, F, v, A, S_all , B_ij);
    % compute the beta
    beta_mat1 = beta_mat(  meas, noise_var, F, v, A, S_all , B_ij);
    % compute probability of states
    Prob_state  = Prob_states( alpha_mat1, beta_mat1 );
    % compute probability of all transitions
    Prob_trans = Prob_transtn( alpha_mat1, beta_mat1, meas, F, v, noise_var, A, S_all , B_ij );
    
    %%MAXIMIZATION
    % max initial prob of states
    init_prob=max_init_prob( S_all,K,Prob_state(1,:), Cki );
    % max transition prob A(i,j) is transition from i yo j; all rows add up
    % to 1
    A = max_trans_prob(Prob_trans,B_ij,Cki );
    %maximize the noise var
    noise_var = max_noise_wknown(Prob_state, meas, F, v );
    % update v
    v= max_v( Prob_state, F, meas );
    
    %%%%%%%%%%%%
    %%%%%%%%%%%%
    % v known, weights unknown
    % the only change is in maximization step, update of v is replaced with
    % update of weights

    [ F,G ] = FG( S_all , weights, v);
    
    %EXPECTATION STEP
    % compute the alpha
    alpha_mat1 = alpha_mat( init_prob, meas, noise_var, F, v, A, S_all , B_ij);
    % compute the beta
    beta_mat1 = beta_mat(  meas, noise_var, F, v, A, S_all , B_ij);
    % compute probability of states
    Prob_state  = Prob_states( alpha_mat1, beta_mat1 );
    % compute probability of all transitions
    Prob_trans = Prob_transtn( alpha_mat1, beta_mat1, meas, F, v, noise_var, A, S_all , B_ij );
    
    %%MAXIMIZATION
    % max initial prob of states
    init_prob=max_init_prob( S_all,K,Prob_state(1,:), Cki );
    % max transition prob A(i,j) is transition from i yo j; all rows add up
    % to 1
    A = max_trans_prob(Prob_trans,B_ij,Cki );
    %maximize the noise var
    noise_var = max_noise_wknown(Prob_state, meas, F, v );
    % update weights
    weights= max_v( Prob_state, G, meas );
    
    %%%%%%%
    % normalize the weights and v so that weights add up to 1
    % this does not change the predicted values
    x=sum(weights);
    weights=weights/x;
    v=x*v;
    
    
end;
    