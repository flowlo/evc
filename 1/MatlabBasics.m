%
% Copyright 2016 Vienna University of Technology.
% Institute of Computer Graphics and Algorithms.
%

function[v1, v2, v3, M, M_9x15, v_M_Product, M_v_Product, M_M_Product, M_M_componentwise, crossP, dotP] = MatlabBasics()
%% General Hints:
% If you want to check your implementation you can:
% -) Set a breakpoint to access variables at a certain point in the 
% script. You can inspect their contents in the 'Workspace' window
% (The 'Workspace' window is usually on the right side of Matlab. 
%  If it is hidden, you can open it in the menu: Home/Environment/Layout/Show/Workspace).
% -) Leave out the ';' at the end of a statement/line so the result will be
% printed out in the command window.
% -) Do not rename the predefined variables, or else our test-system won't
% work (which is bad for both parties ;) )
%% I. create basic data structures:
% 1) create a Row Vector 'v1' and a Column Vector 'v2' with 3 Elements and a 3by3 Matrix 'M' 
% containing digits of your matriculation number in the following order:
% matriculation number: 'ABCDEFG'
% Vector: 
% v1 =
%      F     B     E  
% v2 = 
%      G
%      C
%      D
% Matrix:
% M = 
%      C     B     G
%      F     D     B
%      E     C     A

A = 1;
B = 1;
C = 2;
D = 7;
E = 8;
F = 4;
G = 2;

v1 = [ F B E ];
v2 = [ G ; C ; D ];
M = [ C B G ; F D B ; E C A ];

% 2) create a sequence: create a Vector 'v3' with elements starting at the
% largest digit of M to the smallest, each element 0.5 less than the one
% before. Use the sequence operator ':' and Matlab's
% min/max functions to accomplish this.
% !Use the matrix M for this task and not the same numbers as in M!
% Example: The matriculation number 1210233 should give you the following vector:
% v3 =
%       3  2.5  2  1.5  1  0.5  0
% for more information on how to use the sequence operator ':' (as well as 
% all other Matlab functions), type (in the matlab commandline):
% help :

v3 = max(M(:)):0.5:min(M(:));

% 3) create a 9-by-15 Matrix 'M_9x15' containing a checkerboard pattern of 
% tiles where each black tile contains the contents of matrix M and 
% every white tile contains zeros. Each tile, black or white, has the size 3x3.
% The corners must be black (i.e. contain M).
% ( You have to accomplish this task using a maximum of 7
% assignment-commands.
% Commands that use the = operator for assignment (not comparison) are
% counted as assignment-commands.
% You have to reuse M and you must not use loops.
% For more information see 
% http://de.mathworks.com/help/matlab/matrices-and-arrays.html
% and
% http://de.mathworks.com/help/matlab/math/matrix-indexing.html
% and have a look at the zeros-command:
% help zeros

Z3 = zeros(3, 3);

CODD = horzcat(M, Z3, M, Z3, M);
CEVEN = horzcat(Z3, M, Z3, M, Z3);

M_9x15 = vertcat(CODD, CEVEN, CODD);

%% II. implement your own versions of the following built-in Matlab functions:
% *, .*, cross, dot

% ATTENTION: of course you are not allowed to use the function 'cross' or
% 'dot' as well as '.*' for this task. Furthermore you may only use 
% the '*' operator on single components (-> multiply one element of a 
% matrix or a vector with one other element). You may (and will probably)
% use loops.

% Hint: In order to check your solution, you can compare your results with
% the results you get by using the built-in Matlab functions.

% 1) Vector-Matrix-Multiplication (use v1 and M)
v_M_Product = vector_X_Matrix(v1, M);

% 2) Matrix-Vector-Multiplication (use M and v2)
M_v_Product = Matrix_X_vector(M, v2);

% 3) Matrix-Matrix-Multiplication 
% (use M and the transposed Matrix M2) 
M2 = M';
M_M_Product = Matrix_X_Matrix(M, M2);

% 4) Matrix-Matrix-Multiplication component wise
% (use M and M2 and implement component wise matrix multiplication)
M_M_componentwise = Matrix_Xc_Matrix(M, M2);

% 5) cross product of 2 vectors (use v1 and v2)
crossP = crossProduct(v1,v2);

% 6) dot product (use v1 and v2)
dotP = dotProduct(v1,v2);

end

function[result] = vector_X_Matrix(v1, M)

% precondition: size(M, 2) == size(v1)

    result = zeros(1, size(M, 2));

    for i = 1:size(M, 2)
        for j = 1:size(M, 1)
            result(i) = result(i) + M(j, i) * v1(j);
        end
    end
end

function[result] = Matrix_X_vector(M, v2)

% precondition: size(M, 2) == size(v2)

    result = zeros(size(M, 1), 1);

    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            result(i) = result(i) + M(i, j) * v2(j);
        end
    end
end

function[result] = Matrix_X_Matrix(M, M2)

% precondition: size(M) == size(M2)
% precondition: size(M, 1) == size(M, 2)

    result = zeros(size(M));

    for i = 1:size(M, 2)
        for j = 1:size(M, 1)
            for k = 1:size(M, 2)
                result(i, j) = result(i, j) + M(i, k) * M2(k, j);
            end
        end
    end
end

function[result] = Matrix_Xc_Matrix(M, M2)

% precondition: size(M) == size(M2)

    result = zeros(size(M));

    for i = 1:size(M, 1)
        for j = 1:size(M, 2)
            result(i, j) = M(i, j) * M2(i, j);
        end
    end
end

function[result] = crossProduct(v1, v2)

% precondition: length(v1) == 3
% precondition: length(v2) == 3

    result = reshape([
        v1(2) * v2(3) - v1(3) * v2(2)
        v1(3) * v2(1) - v1(1) * v2(3)
        v1(1) * v2(2) - v1(2) * v2(1)
    ], 1, []);
end

function[result] = dotProduct(v1, v2)

% precondition: length(v1) == length(v2)

    result = 0;
    for i = 1:length(v1)
        result = result + v1(i) * v2(i);
    end
end
