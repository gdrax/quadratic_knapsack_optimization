% Computes the kernel of a symmetrix matrix given it's LDL
% factorization

% @param L: [n x n] lower triangular matrix with ones on the main diagonal
% @param D: [n x n] diagonal matrix
% @param P: [n x n] permutation matrix

% @returns N: [n x z] matrix, the kernel of the matrix of it was singular
%             [n x 1] zero vector if the matrix was non-singular

function N = LDL_kernel(L, D, P)
    b = sum(abs(diag(D)) < 10e-10);
    n = size(L, 1);
    if b ~= 0
        N = zeros(n, b);
        for i = 1:b
            B = zeros(n, 1);
            B(n - b + i) = 1;
            N(1:end, i) = backward_sub(L', B);
        end
        N = P'*N;
    else
        N = zeros(n, 1);
    end
end