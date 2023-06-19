% Swap A(k:end, i1) with A(k:end, i2)

function A = swap_cols(A, i1, i2, k)
    A(k:end, [i1, i2]) = A(k:end, [i2, i1]);
end