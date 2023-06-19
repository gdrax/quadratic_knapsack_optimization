% Swap A(i1, k:end) with A(i2, k:end)

function A = swap_rows(A, i1, i2, k)
    A([i1, i2], k:end) = A([i2, i1], k:end);
end