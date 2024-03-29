% RUNS ON mzn_fd
% RUNS ON mzn_mer_fd
% RUNS ON mzn_cd_fd
% RUNS ON zinc_mip_hl
% RUNS ON zinc_fdic_mznlib
% RUNS ON minizinc_fd

%-----------------------------------------------------------------------------%
% Timetabling problem
%
% Serge Kruk
% 04/2007
%
% This is a subset of a real timetabling problem.  The job is to assign
% students to a section of each of the courses they have chosen and assign a
% timeslot for all sections of all courses so that students can attend their
% assigned sections.
%-----------------------------------------------------------------------------%

include "globals.mzn";

%-----------------------------------------------------------------------------%

int: nS;				% Number of students
int: nC;				% Number of course
int: nSC;				% Number of sections per course
int: nCS;				% Number of courses per student
int: nT;				% Number of timeslots

array[1..nS, 1..nCS] of 1..nC: Cs;	% Courses of each student

	% Decision variables
array[1..nS, 1..nCS] of var 1..nSC: x;	% Sections assigned
array[1..nC, 1..nSC] of var 1..nT: z;	% Times of each section

	% All the course-sections of a student must have different times
constraint
	forall (i in 1..nS) (
		alldifferent (j in 1..nCS) (z[Cs[i,j], x[i,j]])
	);

solve satisfy;

%-----------------------------------------------------------------------------%

output [ "timetabling:\n",
    "course sections assigned (1 row per student, 1 col per course):\n" ]
    ++
    [ show(x[i,j]) ++ if j = nCS then "\n" else " " endif
      | i in 1..nS, j in 1..nCS ]
    ++
    [ "times of each section (1 row per course, 1 col per section):\n" ]
    ++
    [ show(z[i,j]) ++ if j = nSC then "\n" else " " endif
      | i in 1..nC, j in 1..nSC ];

%-----------------------------------------------------------------------------%
% Small data set.

nS=20;
nC=6;
nCS=4;
nSC=3;
%nT=5;	% To make the problem real
nT=6;

Cs= [|
	  2,  5,  4,  3 |
	  4,  6,  3,  1 |
	  3,  1,  6,  2 |
	  2,  3,  6,  1 |
	  6,  4,  3,  1 |
	  6,  4,  2,  5 |
	  6,  2,  4,  1 |
	  6,  1,  4,  3 |
	  6,  4,  5,  3 |
	  5,  4,  6,  2 |
	  4,  2,  1,  5 |
	  6,  2,  3,  1 |
	  4,  3,  5,  6 |
	  6,  3,  2,  4 |
	  4,  6,  5,  1 |
	  3,  2,  6,  4 |
	  3,  6,  5,  1 |
	  3,  5,  2,  6 |
	  4,  3,  5,  2 |
	  5,  4,  6,  2 |
	|];

%-----------------------------------------------------------------------------%
%-----------------------------------------------------------------------------%
