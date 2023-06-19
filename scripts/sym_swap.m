% Symmetric swap:
% swap A(k:end, i1) with A(k:end, i2) and then
% swap A(i1, k:end) with A(i2, k:end)

function A = sym_swap(A, i1, i2, k)
    A([i1, i2], k:end) = A([i2, i1], k:end);
    A(k:end, [i1, i2]) = A(k:end, [i2, i1]);
end