#|	ASSIGNMENT ONE
	NAME: SONOLA SOWEMIMO
	CLASS: CMPUT 325
	ID: 1293430
|#

;QUESTION ONE
#| 
 The function returns T if argument X is a member of the argument list Y and NIL otherwise. This should
 also test for lists being members of lists. Both the argument X and the list Y may be NIL or lists containing NIL.
	Examples: 
	(xmember '1 '(1)) --> T
	(xmember '1 '( (1) 2 3)) --> NIL
	(xmember '(1) '((1) 2 3)) --> NIL
	(xmember nil nil) --> NIL 

	If (null Y) checking base argument, base case of if list Y is empty
		returns nil
	else if (equal X (first argument of list Y)) else if the first argument in the list Y, to see if its equals X, returns true 
		returns true
	else xmember (x (2nd to last arguments of list Y)) else remove the first argument in list Y, and send it into the function (recursion)

|#

	(defun xmember (X Y)
		(cond
			((null Y) nil)
			((equal X (car Y)) T)
			(t(xmember X (cdr Y)))
		)
	)

; QUESTION TWO
 #|
 Where the arugment x is a list with sublists nested to any depth, such that the resuly of (flatten x) is just a list of atoms with the property
 all the atoms appearing in the x also appear in (flatten x) and in the same order. Make assumption: NIL & () will not appear in list x
	Examples:
	(flatten '(a (b c) d)) --> (a b c d)
	(flatten '((((a))))) --> (a)
	(flatten '(a (b c) (d ((e)) f))) --> (a b c d e f)

	if (null X) checking base argument, base case is empty return nil
		returns nil
	else if (oftypeatom(x))	checking argument of if first element is a single argument, not a nested list, and send rest to be flattened
		return add to output list + flatten(send rest of list, excluding first element X
	else
		return (append (flatten(first element) + flatten(rest of elements))) if the whole list is a nested list send it all to be broken down
|#

	(defun flatten (X)
		(cond 
			((null X) nil)

			((atom (car X))
					(append
					(list (car X))
					(flatten (cdr X)))
			)

			(t(append 
				(flatten (car x)) 
				(flatten (cdr x)))
			)
		)
	)

;QUESTION THREE
#| 
 Mixes the elements of L1 and L2 into a single list, by choosing elements from L1 and L2 alternatingly. If one list is shorter than the
 other, then append all elements from the longer list at the end.
	Exmaples:
	(mix '(a b c) '(d e f)) --> (a d b e c f)
	(mix '(1 2 3') '(a)) --> (1 a 2 3)
	(mix '((a) (b c)) '(d e f g h)) --> ((a) d (b c) e f g h)

	if ( L2 is empty)	checks to see if second list is empty then return first list
		return L1
	else if ( L1 is empty)	checks to see if first list is empty then return second list
		return L2
	else 
		append (first element in L1 & first element in L2)	combine first element in L1 and first element in L2
		mix (rest element in L1 & rest element in l2)	send the rest of element in L1 and rest of elements in L2 in recursion
|#

	(defun mix (L1 L2)
		(cond
			((null L2) L1)

			((null L1) L2)

			(t(append 
				(list (car L1) (car L2)) 
				(mix (cdr L1) (cdr L2))
				)
			)
		)
	)

;QUESTION FOUR
#|
 Splits elements  of L into a list of two sublists (L1 L2), by putting elements from L into L1 and L2 alternatingly
	Example:
	(split '(1 2 3 4 5 6)) --> ((1 3 5) (2 4 6))
	(split '((a) (b c) (d e f) g h)) --> ((a) (d e f) f) ((b c) g))
	(split '()) --> (nil nil) 

|#

	(defun split (L)
		(cond 
			((null L) '(nil nil))

			((null (cdr L)) 
				(cons 
					(cons 
						(car L)
						(car (split (cddr L)))
					)
					(list (cdr L))
				)
			)

			(t (cons 
				(cons 
					(car L)
					(car (split (cddr L)))
				)
				(list 
					(cons
						(car (cdr L))
							(car (cdr (split (cddr L))))
						)
					)
				)
			)
		)
	)

;QUESTION FIVE
#|
	5.1 Let L1 and L2 be lists. Is it always true that (split (mix L1 L2)) returns the list (L1 L2).

	ANSWER: FALSE, it is not always true you will get the same (L1 L2) list. A perfect example to 
	disprove this will be simply making one of the list null. Odds are you'll receive the same list
	if neither are null. If one of the list is null you are bound to receive a seperate list where the
	list that isn't null is split between both lists evenly.

	Also the condition of having one list longer than the other with two items, will also provide us with the case of 
	both lists not being the same as initial started.
|#

#|
	5.2 Let L be a list. Is it always true that (mix (car (split L))(cadr (split L))) returns L.

	ANSWER: TRUE, 
	L = (A B C D)
	(mix (car (split L)) (cadr (split L)))

	(split L) --> ((A C) (B D))
	
	(car (split L)) --> (A C)
	(cadr (split L)) --> (B D)

	(mix (A C) (B D)) --> (A B C D)
	qed

	Breaking this down you realize we simply take a list, split it up into two and take the first
	list and second list and mix it back together so no doubt we are bound to get the same list back.
|#



#| QUESTION SIX
 Write a lisp function to solve the subset sum problem: given a list of numbers L and a sum S, find a subset of the numbers
 n1 ... nk should be in the same order as they appear in L. The resuly should be nil if the problem has no solution. Just pick 
 one valid solution. 
	Examples:
	(subsetsum '(1 2 3) 5) --> (2 3)
	(subsetsum '(1 5 3) 2) --> nil
	(subsetsum '(1 16 2 8 4) 29) --> (1 16 8 4)
	(subsetsum '(1 1 5 6 8) 10) --> (1 1 8)
	(subsetsum '(1 10 100 1000 10000) 5) --> nil 

	if (list empty)
		return nil
	else if (first item in list > sum)
		return (subsetsum(rest of list) sum)
	else if (first item in list == sum)

	else if (first item in list < sum)
		if (subsetsum(rest item in list) && (sum - first item in list) == null)
			return (subsetsum(rest of list) sum)
			return (subsetsum(rest of list) (sum - first item in list))
|#

	(defun subsetsum (L S)
		(cond 
			((null L) nil)

			((> (car L) S)
				(subsetsum (cdr L) S)
			)

			((= (car L) S)
				(cons (car L) ()))
				;(cons (car L))

			((< (car L) S)
				(if (null (subsetsum (cdr L) (- S (car L))))
					(subsetsum (cdr L) S)
					(cons (car L) (subsetsum (cdr L) (- S (car L))))
				)

			)
		)
	)
