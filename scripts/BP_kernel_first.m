% Computes a single vector of the kernel of a matrix from it's partial 
% Bunch-Parlett decomposition
%
% @param L: [m x m] first part of lower triangular real matrix
% with ones on the main diagonal
% @param D: [m x m] first part of block diagonal real matrix, with 1x1 and
% 2x2 blocks, last element is zero
% @param P: [n x n] permutation matrix
%
% @return N: [n x 1] real vector, the first kernel vector of the factorized
% matrix
function N = BP_kernel_first(L, D, P)
    m = size(D, 1);
    n = size(P, 1);
    B = zeros(m, 1);
    B(end) = 1;
    Nr = backward_sub(L', B);
    N = zeros(n, 1);
    N(1:m) = Nr;
    N = P'*N;
end