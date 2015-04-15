% working_directory(_,'Users/andrewho/Documents/Programming/MSc/Paradigms/Prolog/prolog').

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
					
freeSpace([X,Y]) :- not(barrier(X,Y)),
	 				mazeSize(BoardX,BoardY),
					X=<BoardX, 
					Y=<BoardY.								
					
% checks whether a step from point A to point B is possible.  Returns true if possible and false otherwise.
					
possibleStep([Xa,Ya],[Xb,Yb]) :- Xb is Xa+1,	% should i change Yb variable to Ya and remove next line?
					  	 Yb==Ya,
					  	 freeSpace([Xa,Ya]),
					  	 freeSpace([Xb,Yb]).

possibleStep([Xa,Ya],[Xb,Yb]) :- Xb is Xa-1,
					  	 Yb==Ya,
					  	 freeSpace([Xa,Ya]),
					  	 freeSpace([Xb,Yb]).


possibleStep([Xa,Ya],[Xb,Yb]) :- Xb==Xa,
					  	 Yb is Ya+1,
					  	 freeSpace([Xa,Ya]),
					  	 freeSpace([Xb,Yb]).

possibleStep([Xa,Ya],[Xb,Yb]) :- Xb==Xa,
					  	 Yb is Ya-1,
					  	 freeSpace([Xa,Ya]),
					  	 freeSpace([Xb,Yb]).						 
						 	
% finds a Path going from From to To avoiding barriers and staying within the board limits

solve([FromX,FromY],[ToX,ToY],Path) :-  solve([FromX,FromY],[ToX,ToY],[],Path).
							
solve([X,Y],[X,Y],Route,[Route]).				% should i keep the [] around Route?

% solve([FromX,FromY],[ToX,ToY],AccRoute,Path) :- possibleStep([FromX,FromY],[ToX,ToY]).

solve([FromX,FromY],[ToX,ToY],AccRoute,Path) :- possibleStep([FromX,FromY],[ViaX,ViaY]),
					  						 	not(member([ViaX,ViaY],AccRoute)),
					  					   	 	solve([ViaX,ViaY],[ToX,ToY],[[ViaX,ViaY]|AccRoute],Path).
	



/* ******************************************************************************** */
/*   Rough Working Notes                               						   		*/
/* ******************************************************************************** */

% Returns a list with containing the co-ordinates of all possible moves from a cell. 

% moveUp([X,Y],[Xup,Y]) :- Xup is X-1.
% moveDown([X,Y],[Xdown,Y]) :- Xdown is X+1.
% moveLeft([X,Y],[X,Yleft]) :- Yleft is Y-1.
% moveRight([X,Y],[X,Yright]) :- Yright is Y+1.

% filterMoves(A,In,Out) :- exclude(not(freeSpace(A)),In,Out).

% possMoves([X,Y],M) :- moveUp([X,Y],Up),
%					  moveDown([X,Y],Down),
%					  moveLeft([X,Y],Left),
%					  moveRight([X,Y],Right),					  					  
%					  filterMoves(A,[Up,Down,Left,Right],M).
