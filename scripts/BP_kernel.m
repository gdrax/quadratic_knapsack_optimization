% Computes kernel of a matrix from it's Bunch-Parlett decomposition
% @param L: [n x n] lower triangular real matrix with ones on the main
% diagonal
% @param D: [n x x] block diagonal real matrix, with 1x1 and 2x2 blocks
% @param P: [n x n] permutation matrix
%
% @return N: [n x r] real matrix, the kernel of the factorized matrix if it
%            was singular
%            [n x 1] zeros vector, if the matrix was invertible

function N = BP_kernel(L, D, P)
    toll = 1e-8;
    b = 0;
    i = size(D, 1);
    % count the elements on the main diagonal that are close to machine
    % precision
    while i > 0
        if i > 1
            % skip block pivots that may contain zeros
            if abs(D(i-1, i)) > toll || abs(D(i, i-1)) > toll
                if abs(D(i, i)) < toll && abs(D(i-1, i-1)) < toll
                    b = b + 2;
                    i = i - 2;
                else
                    i = i - 2;
                end
            else
                if abs(D(i, i)) < toll
                    b = b + 1;
                end
            end
        end
        i = i - 1;
    end
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