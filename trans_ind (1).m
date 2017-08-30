function B_ij=trans_ind(S_all);
% trnasition feasibility indicator function
% this function has output B_ij of K^w by K^w matrix
% each element of the 1 or 0
% the (i,j) element of output is 1 if transtion from i to j compound state is feasible and zero
% otherwise

% the input S_all is a w row and K^w column matrix.
% the i'th column of the matrix is the i'th compound state
% each column has w rows. first row is the most recent naive state


w=size(S_all,1);

if w==1
    % this means w=1 and so all transitions are possible
    B_ij=ones(size(S_all,2));
end;

if w>1
    for i=1:size(S_all,2)
        for j=1:size(S_all,2)
            if S_all(1:w-1,i)==S_all(2:w,j)
                B_ij(i,j)=1;
            else
                B_ij(i,j)=0;
            end;
        end;
    end;
end;
    
