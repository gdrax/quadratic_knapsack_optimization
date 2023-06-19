# Project NON-ML 33
Active-set algorithm to solve convex quadratic non-separable knapsack problems.
## Optimization
- **ASKP.m**: Implementation of the active-set algorithm for knapsack problems.
- **gen_knapsack.m**: Generator of instances of non-separable knapsack problems.
- **quad_func_value.m**: Computes value and gradient of the quadratic function in a specific point.
- **gen_K.m**: Generates a random indefinite matrix K. 

## Optimization experiments
- **plot_actv_iteration.m**: Show number of iter. to solve problems with different % of active box constraint at the optimum.
- **plot_askp_converence.m**: Converence plot of ASKP algorithm.
- **plot_ecc_iteration.m**: Show number of iter. to solve problems with different eccentrivity of the quadartic matrix.
- **plot_singular_iteration.m**: Show number of iter. to solve problem with singular matrix with different number of 0 eigenvalues.
- **table_ecc.m**: Computing time and number of iter. to solve problems with different eccentricity and size.
- **table_knapsack.m**: Computing time and number of iter. to solve problems with large or tight knapsack constraints.
- **table_knapsack.m**: Computing time and number of iter. to solve problems with different % of active box constraints a the optimum.

## Linear algebra
### Matrix factorization
- **BP_fact.m**: Bunch-Parlett algorithm.
- **LDL_fact.m**: LDL factorization of a symmetric matrix.
- **LDL_pivot.m**: LDL factorization of a symmetric matrix with pivoting.
- **LU_fact.m**: LU factorization of a matrix.
- **LU_pivot.m**: LU factorization of a matrix using pivotng.
- **BP_fact_stop.m**: Bunch-Parlett factorization algorithm, returns partial factorization if the matrix is singular.

### Kernel of a matrix
- **BP_kernel.m**: Kernel of a matrix from symetric BP factorization.
- **BP_kernel_first.m**: Single kernel vector of a singular matrix from BP factorization computed with **BP_fact_stop.m**.
- **LDL_kernel.m**: Kernel of a symmetric matrix, from LDL factorization.
- **LU_kernel.m**: Kernel of a matrix from it's LU factorization.

### Solution of linear system
- **backward_sub.m**: Backward substitution for upper triangular system.
- **forward_sub.m**: Forward substitution for lower triangular system.
- **solve_block_diag.m**: Solution of a block diagonal system.
- **solve_BP.m**: Solution of symmetric system from BP factorization.
- **solve_LDL.m**: Solution of symmetric system from LDL factorization.
- **solve_LDL_pivot.m**: Solution of symmetric system from LDL factorization with pivoting.
- **solve_LU.m**: Solution of system from LU factorization.
- **solve_LU_pivoting.m**: Solution of system from LU factorization with pivoting.

### Utils
- **gen_posdef.m**: Generator for symmetric positive definite matrices.
- **gen_possemidef.m**:Generator for symmetric positive semidefinite matrices.
- **mini_inv.m**: Inverse of a 2x2 matrix.
- **swap_col.m**: Swap columns of a matrix.
- **swap_rows.m**: Swap rows of a matrix.
- **sym_swap.m**: Symmetric swap of rows and columns.

## Linear algebra experiments
- **compare_factorization.m**: Compare different factorization methods.
- **compare_kernel.m**: Compare precision of kernel vector computed from different factorizations.
- **plot_accuracy.m**: Show precision of linear system solution computed from different factorizations.
- **plot_fact_accuracy.m**: Show precision of factorizatios computed from different methods.
- **plot_kernel_accuracy.m**: Show precision of kernel vector computed from different factorizations.
- **plot_time.m**: Show total computation times for solving linear system with different factorization alorithms.
