% Inverse of a 2x2 non-singular matrix
%
% @param A: [2 x 2] real non-singular matrix
% @return A_i: [2 x 2] real matrix, the inverse of A
function A_i = mini_inv(A)
    A_i = 1/(A(1, 1)*A(2,2) - A(1,2)*A(2,1))*[A(2,2) -A(1,2); -A(2,1) A(1,1)];
end