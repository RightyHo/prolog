/* ******************************************************************************** */
/*                                                  						   		*/
/*   Your task is to write a predicate:             								*/
/*                                                  						   		*/
/*      solve(From,To,Path)                         						   		*/
/*                                                  						   		*/
/*   which, given locations From and To, finds a Path going from From to To.   		*/
/*   From and To are given as two element lists, and Path should be a list   		*/
/*   of two-element lists. The first element of Path should be From, and the   	    */
/*   last element should be To. Moves can be made horizontally or vertically,  		*/
/*   but not diagonally.													   		*/
/*                                                  						   		*/
/*   For example,                                      						   		*/
/*                                                  						   		*/
/*   solve([3,2], [2,6], [[3,2], [3,3], [2,3], [1,3], [1,4], [1,5], [1,6], [2,6]]). */
/*                                                  						   		*/
/*   should print the solution as a list, and also as a text drawing.   	 	    */
/*   You do not have to find the shortest path.          				   		    */
/*                                                  						   		*/
/*   Author: Andrew Ho							                               		*/
/*   Date: 12 April 2015							                           		*/
/*                                                  						   		*/
/* ******************************************************************************** */
		
% Checks if a cell with co-ordinates (X,Y) falls within the maze boundary and confirms
% whether or not the cell is occupied by a barrier.		
					
freeSpace([X,Y]) :- not(barrier(X,Y)),				% would moving this goal to the end make a difference?
	 				mazeSize(BoardX,BoardY),
					X=<BoardX, 
					Y=<BoardY.								
					
% checks whether a step from point A to point B is possible.  Returns true if possible and false otherwise.
					
possibleStep([X,Y],[Xnew,Y]) :- Xnew is X+1,	
					  			freeSpace([X,Y]),
								freeSpace([Xnew,Y]).

possibleStep([X,Y],[Xnew,Y]) :- Xnew is X-1,
					  		 	freeSpace([X,Y]),
								freeSpace([Xnew,Y]).


possibleStep([X,Y],[X,Ynew]) :- Ynew is Y+1,
							 	freeSpace([X,Y]),
								freeSpace([X,Ynew]).

possibleStep([X,Y],[X,Ynew]) :- Ynew is Y-1,
					  	 		freeSpace([X,Y]),
					  	 	   	freeSpace([X,Ynew]).						 
						 	
% finds a Path going from From to To avoiding barriers and staying within the board limits

solve([FromX,FromY],[ToX,ToY],ThePath) :-  solve([FromX,FromY],[ToX,ToY],[[FromX,FromY]|[]],Path),
										   reverse(Path,[],ThePath),
										   printPath(ThePath),
										   printGrid([ThePath|[]]).
							
solve([X,Y],[X,Y],Route,Route).		

solve([FromX,FromY],[ToX,ToY],AccRoute,Path) :- possibleStep([FromX,FromY],[ViaX,ViaY]),
					  						 	not(member([ViaX,ViaY],AccRoute)), 
					  					   	 	solve([ViaX,ViaY],[ToX,ToY],[[ViaX,ViaY]|AccRoute],Path), !.
	
% standard reverse/3 predicate

reverse([],X,X).

reverse([H|T],Acc,Output) :- reverse(T,[H|Acc],Output). 

% loop to print out the various step members of the path list

printPath([]).

printPath([H|T]) :- write(H), nl,
					printPath(T).

% code for printing out the grid

printGrid([]).
printGrid(L) :- nl,
   divider,
   printBlock(L,L1),
   divider,
   printBlock(L1,L2),
   divider,
   printBlock(L2,_),
   divider.

printBlock(L,L3) :- 
   printRow(L,L1), nl,
   blankLine, 
   printRow(L1,L2), nl,
   blankLine, 
   printRow(L2,L3), nl.
 
printRow(L,L3) :-
   write('+ '),
   printTriplet(L,L1), write(' | '),
   printTriplet(L1,L2), write(' | '),
   printTriplet(L2,L3),
   write(' +').


blankLine :- 
   write('+         |         |         +'), nl.


% blankLine.

divider :-
   write('+---------+---------+---------+'), nl.

printTriplet(L,L3) :-
   printElement(L,L1), write('  '),
   printElement(L1,L2), write('  '),
   printElement(L2,L3).

printElement([X|L],L) :- var(X), !, write('.').
printElement([X|L],L) :- write(X).



