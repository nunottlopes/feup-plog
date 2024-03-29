% RUNS ON mzn_fd
% RUNS ON mzn_mer_fd
% RUNS ON mzn_mer_lazyfd
% RUNS ON mzn_mer_lp
% RUNS ON mzn_cd_fd
% RUNS ON zinc_fdic_mznlib
% RUNS ON zinc_mip_hl
% RUNS ON minizinc_fd
% n-queens example in Zinc using IP techniques
% By Ralph Becket

% MiniZinc version
% Peter Stuckey September 30 2006

int: n = 8;

set of int: rg = 0 .. n-1;

array [rg, rg] of var 0 .. 1: q;

%
% Every row and column has exactly one queen.
% Every diagonal has at most one queen.
%

constraint forall (i in rg) (
	( sum (j in rg)                        (q[i, j])         =  1 )
/\	( sum (j in rg)                        (q[j, i])         =  1 )
/\	( sum (j, k in rg where j - k = i)     (q[j, k])         <= 1 )
/\	( sum (j, k in rg where j - k = - i)   (q[j, k])         <= 1 )
/\	( sum (j, k in rg where j - k = i)     (q[n - 1 - j, k]) <= 1 )
/\	( sum (j, k in rg where j - k = - i)   (q[n - 1 - j, k]) <= 1 )
);

%
% Find the first solution.
%

solve ::
	int_search(
		array1d(0..n*n - 1, q),
		first_fail,
		indomain_min,
		complete
	)
	satisfy;

output ["8 queens, IP version:"] ++
	[	if j = 0 then "\n" else "" endif ++
		if fix(q[i, j]) = 1 then "Q " else ". " endif
	|	i, j in rg
	] ++
	[ "\n" ];
