% Computes the kernel of a matrix given it's LU factorization

% @param L: [n x n] lower triangular matrix
% @param U: [n x n] upper triangular matrix

% @returns N: [n x z] matrix, the kernel of the matrix if if was singular
%             [n x 1] zero vector, if the matrix was non-singular

function N = LU_kernel(L, U)
    b = sum(abs(diag(U)) < 10e-10);
    U(end-b+1:end, end-b+1:end) = eye(b);
    n = size(L, 1);
    if b ~= 0
        N = zeros(n, b);
        for i = 1:b
            B = zeros(n, 1);
            B(n - b + i) = 1;
            N(1:end, i) = backward_sub(U, B);
        end
    else
        N = zeros(n, 1);
    end
end