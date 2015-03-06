
# The Analytic Edge Lecture code in Python
## With pandas, numpy

# VIDEO 2
## Basic Calculations


    8*6




    48



Python use ** for power


    2**16




    65536



type '\' and line break will allow you to continuetyping in code in new line


    2**\
    6




    64



## Functions
You can take square root without using a function...


    2**0.5




    1.4142135623730951



You can also use libraies like math, numpy or scipy for sqrt function


    from numpy import sqrt
    sqrt(2)




    1.4142135623730951



The absoluate value function


    abs(-65)




    65



to see help on function or object in python:


    help(sqrt)

    Help on ufunc object:
    
    sqrt = class ufunc(__builtin__.object)
     |  Functions that operate element by element on whole arrays.
     |  
     |  To see the documentation for a specific ufunc, use np.info().  For
     |  example, np.info(np.sin).  Because ufuncs are written in C
     |  (for speed) and linked into Python with NumPy's ufunc facility,
     |  Python's help() function finds this page whenever help() is called
     |  on a ufunc.
     |  
     |  A detailed explanation of ufuncs can be found in the "ufuncs.rst"
     |  file in the NumPy reference guide.
     |  
     |  Unary ufuncs:
     |  =============
     |  
     |  op(X, out=None)
     |  Apply op to X elementwise
     |  
     |  Parameters
     |  ----------
     |  X : array_like
     |      Input array.
     |  out : array_like
     |      An array to store the output. Must be the same shape as `X`.
     |  
     |  Returns
     |  -------
     |  r : array_like
     |      `r` will have the same shape as `X`; if out is provided, `r`
     |      will be equal to out.
     |  
     |  Binary ufuncs:
     |  ==============
     |  
     |  op(X, Y, out=None)
     |  Apply `op` to `X` and `Y` elementwise. May "broadcast" to make
     |  the shapes of `X` and `Y` congruent.
     |  
     |  The broadcasting rules are:
     |  
     |  * Dimensions of length 1 may be prepended to either array.
     |  * Arrays may be repeated along dimensions of length 1.
     |  
     |  Parameters
     |  ----------
     |  X : array_like
     |      First input array.
     |  Y : array_like
     |      Second input array.
     |  out : array_like
     |      An array to store the output. Must be the same shape as the
     |      output would have.
     |  
     |  Returns
     |  -------
     |  r : array_like
     |      The return value; if out is provided, `r` will be equal to out.
     |  
     |  Methods defined here:
     |  
     |  __call__(...)
     |      x.__call__(...) <==> x(...)
     |  
     |  __repr__(...)
     |      x.__repr__() <==> repr(x)
     |  
     |  __str__(...)
     |      x.__str__() <==> str(x)
     |  
     |  accumulate(...)
     |      accumulate(array, axis=0, dtype=None, out=None)
     |      
     |      Accumulate the result of applying the operator to all elements.
     |      
     |      For a one-dimensional array, accumulate produces results equivalent to::
     |      
     |        r = np.empty(len(A))
     |        t = op.identity        # op = the ufunc being applied to A's  elements
     |        for i in range(len(A)):
     |            t = op(t, A[i])
     |            r[i] = t
     |        return r
     |      
     |      For example, add.accumulate() is equivalent to np.cumsum().
     |      
     |      For a multi-dimensional array, accumulate is applied along only one
     |      axis (axis zero by default; see Examples below) so repeated use is
     |      necessary if one wants to accumulate over multiple axes.
     |      
     |      Parameters
     |      ----------
     |      array : array_like
     |          The array to act on.
     |      axis : int, optional
     |          The axis along which to apply the accumulation; default is zero.
     |      dtype : data-type code, optional
     |          The data-type used to represent the intermediate results. Defaults
     |          to the data-type of the output array if such is provided, or the
     |          the data-type of the input array if no output array is provided.
     |      out : ndarray, optional
     |          A location into which the result is stored. If not provided a
     |          freshly-allocated array is returned.
     |      
     |      Returns
     |      -------
     |      r : ndarray
     |          The accumulated values. If `out` was supplied, `r` is a reference to
     |          `out`.
     |      
     |      Examples
     |      --------
     |      1-D array examples:
     |      
     |      >>> np.add.accumulate([2, 3, 5])
     |      array([ 2,  5, 10])
     |      >>> np.multiply.accumulate([2, 3, 5])
     |      array([ 2,  6, 30])
     |      
     |      2-D array examples:
     |      
     |      >>> I = np.eye(2)
     |      >>> I
     |      array([[ 1.,  0.],
     |             [ 0.,  1.]])
     |      
     |      Accumulate along axis 0 (rows), down columns:
     |      
     |      >>> np.add.accumulate(I, 0)
     |      array([[ 1.,  0.],
     |             [ 1.,  1.]])
     |      >>> np.add.accumulate(I) # no axis specified = axis zero
     |      array([[ 1.,  0.],
     |             [ 1.,  1.]])
     |      
     |      Accumulate along axis 1 (columns), through rows:
     |      
     |      >>> np.add.accumulate(I, 1)
     |      array([[ 1.,  1.],
     |             [ 0.,  1.]])
     |  
     |  at(...)
     |      at(a, indices, b=None)
     |      
     |      Performs unbuffered in place operation on operand 'a' for elements
     |      specified by 'indices'. For addition ufunc, this method is equivalent to
     |      `a[indices] += b`, except that results are accumulated for elements that
     |      are indexed more than once. For example, `a[[0,0]] += 1` will only
     |      increment the first element once because of buffering, whereas
     |      `add.at(a, [0,0], 1)` will increment the first element twice.
     |      
     |      .. versionadded:: 1.8.0
     |      
     |      Parameters
     |      ----------
     |      a : array_like
     |          The array to perform in place operation on.
     |      indices : array_like or tuple
     |          Array like index object or slice object for indexing into first
     |          operand. If first operand has multiple dimensions, indices can be a
     |          tuple of array like index objects or slice objects.
     |      b : array_like
     |          Second operand for ufuncs requiring two operands. Operand must be
     |          broadcastable over first operand after indexing or slicing.
     |      
     |      Examples
     |      --------
     |      Set items 0 and 1 to their negative values:
     |      
     |      >>> a = np.array([1, 2, 3, 4])
     |      >>> np.negative.at(a, [0, 1])
     |      >>> print(a)
     |      array([-1, -2, 3, 4])
     |      
     |      ::
     |      
     |      Increment items 0 and 1, and increment item 2 twice:
     |      
     |      >>> a = np.array([1, 2, 3, 4])
     |      >>> np.add.at(a, [0, 1, 2, 2], 1)
     |      >>> print(a)
     |      array([2, 3, 5, 4])
     |      
     |      ::
     |      
     |      Add items 0 and 1 in first array to second array,
     |      and store results in first array:
     |      
     |      >>> a = np.array([1, 2, 3, 4])
     |      >>> b = np.array([1, 2])
     |      >>> np.add.at(a, [0, 1], b)
     |      >>> print(a)
     |      array([2, 4, 3, 4])
     |  
     |  outer(...)
     |      outer(A, B)
     |      
     |      Apply the ufunc `op` to all pairs (a, b) with a in `A` and b in `B`.
     |      
     |      Let ``M = A.ndim``, ``N = B.ndim``. Then the result, `C`, of
     |      ``op.outer(A, B)`` is an array of dimension M + N such that:
     |      
     |      .. math:: C[i_0, ..., i_{M-1}, j_0, ..., j_{N-1}] =
     |         op(A[i_0, ..., i_{M-1}], B[j_0, ..., j_{N-1}])
     |      
     |      For `A` and `B` one-dimensional, this is equivalent to::
     |      
     |        r = empty(len(A),len(B))
     |        for i in range(len(A)):
     |            for j in range(len(B)):
     |                r[i,j] = op(A[i], B[j]) # op = ufunc in question
     |      
     |      Parameters
     |      ----------
     |      A : array_like
     |          First array
     |      B : array_like
     |          Second array
     |      
     |      Returns
     |      -------
     |      r : ndarray
     |          Output array
     |      
     |      See Also
     |      --------
     |      numpy.outer
     |      
     |      Examples
     |      --------
     |      >>> np.multiply.outer([1, 2, 3], [4, 5, 6])
     |      array([[ 4,  5,  6],
     |             [ 8, 10, 12],
     |             [12, 15, 18]])
     |      
     |      A multi-dimensional example:
     |      
     |      >>> A = np.array([[1, 2, 3], [4, 5, 6]])
     |      >>> A.shape
     |      (2, 3)
     |      >>> B = np.array([[1, 2, 3, 4]])
     |      >>> B.shape
     |      (1, 4)
     |      >>> C = np.multiply.outer(A, B)
     |      >>> C.shape; C
     |      (2, 3, 1, 4)
     |      array([[[[ 1,  2,  3,  4]],
     |              [[ 2,  4,  6,  8]],
     |              [[ 3,  6,  9, 12]]],
     |             [[[ 4,  8, 12, 16]],
     |              [[ 5, 10, 15, 20]],
     |              [[ 6, 12, 18, 24]]]])
     |  
     |  reduce(...)
     |      reduce(a, axis=0, dtype=None, out=None, keepdims=False)
     |      
     |      Reduces `a`'s dimension by one, by applying ufunc along one axis.
     |      
     |      Let :math:`a.shape = (N_0, ..., N_i, ..., N_{M-1})`.  Then
     |      :math:`ufunc.reduce(a, axis=i)[k_0, ..,k_{i-1}, k_{i+1}, .., k_{M-1}]` =
     |      the result of iterating `j` over :math:`range(N_i)`, cumulatively applying
     |      ufunc to each :math:`a[k_0, ..,k_{i-1}, j, k_{i+1}, .., k_{M-1}]`.
     |      For a one-dimensional array, reduce produces results equivalent to:
     |      ::
     |      
     |       r = op.identity # op = ufunc
     |       for i in range(len(A)):
     |         r = op(r, A[i])
     |       return r
     |      
     |      For example, add.reduce() is equivalent to sum().
     |      
     |      Parameters
     |      ----------
     |      a : array_like
     |          The array to act on.
     |      axis : None or int or tuple of ints, optional
     |          Axis or axes along which a reduction is performed.
     |          The default (`axis` = 0) is perform a reduction over the first
     |          dimension of the input array. `axis` may be negative, in
     |          which case it counts from the last to the first axis.
     |      
     |          .. versionadded:: 1.7.0
     |      
     |          If this is `None`, a reduction is performed over all the axes.
     |          If this is a tuple of ints, a reduction is performed on multiple
     |          axes, instead of a single axis or all the axes as before.
     |      
     |          For operations which are either not commutative or not associative,
     |          doing a reduction over multiple axes is not well-defined. The
     |          ufuncs do not currently raise an exception in this case, but will
     |          likely do so in the future.
     |      dtype : data-type code, optional
     |          The type used to represent the intermediate results. Defaults
     |          to the data-type of the output array if this is provided, or
     |          the data-type of the input array if no output array is provided.
     |      out : ndarray, optional
     |          A location into which the result is stored. If not provided, a
     |          freshly-allocated array is returned.
     |      keepdims : bool, optional
     |          If this is set to True, the axes which are reduced are left
     |          in the result as dimensions with size one. With this option,
     |          the result will broadcast correctly against the original `arr`.
     |      
     |      Returns
     |      -------
     |      r : ndarray
     |          The reduced array. If `out` was supplied, `r` is a reference to it.
     |      
     |      Examples
     |      --------
     |      >>> np.multiply.reduce([2,3,5])
     |      30
     |      
     |      A multi-dimensional array example:
     |      
     |      >>> X = np.arange(8).reshape((2,2,2))
     |      >>> X
     |      array([[[0, 1],
     |              [2, 3]],
     |             [[4, 5],
     |              [6, 7]]])
     |      >>> np.add.reduce(X, 0)
     |      array([[ 4,  6],
     |             [ 8, 10]])
     |      >>> np.add.reduce(X) # confirm: default axis value is 0
     |      array([[ 4,  6],
     |             [ 8, 10]])
     |      >>> np.add.reduce(X, 1)
     |      array([[ 2,  4],
     |             [10, 12]])
     |      >>> np.add.reduce(X, 2)
     |      array([[ 1,  5],
     |             [ 9, 13]])
     |  
     |  reduceat(...)
     |      reduceat(a, indices, axis=0, dtype=None, out=None)
     |      
     |      Performs a (local) reduce with specified slices over a single axis.
     |      
     |      For i in ``range(len(indices))``, `reduceat` computes
     |      ``ufunc.reduce(a[indices[i]:indices[i+1]])``, which becomes the i-th
     |      generalized "row" parallel to `axis` in the final result (i.e., in a
     |      2-D array, for example, if `axis = 0`, it becomes the i-th row, but if
     |      `axis = 1`, it becomes the i-th column).  There are two exceptions to this:
     |      
     |        * when ``i = len(indices) - 1`` (so for the last index),
     |          ``indices[i+1] = a.shape[axis]``.
     |        * if ``indices[i] >= indices[i + 1]``, the i-th generalized "row" is
     |          simply ``a[indices[i]]``.
     |      
     |      The shape of the output depends on the size of `indices`, and may be
     |      larger than `a` (this happens if ``len(indices) > a.shape[axis]``).
     |      
     |      Parameters
     |      ----------
     |      a : array_like
     |          The array to act on.
     |      indices : array_like
     |          Paired indices, comma separated (not colon), specifying slices to
     |          reduce.
     |      axis : int, optional
     |          The axis along which to apply the reduceat.
     |      dtype : data-type code, optional
     |          The type used to represent the intermediate results. Defaults
     |          to the data type of the output array if this is provided, or
     |          the data type of the input array if no output array is provided.
     |      out : ndarray, optional
     |          A location into which the result is stored. If not provided a
     |          freshly-allocated array is returned.
     |      
     |      Returns
     |      -------
     |      r : ndarray
     |          The reduced values. If `out` was supplied, `r` is a reference to
     |          `out`.
     |      
     |      Notes
     |      -----
     |      A descriptive example:
     |      
     |      If `a` is 1-D, the function `ufunc.accumulate(a)` is the same as
     |      ``ufunc.reduceat(a, indices)[::2]`` where `indices` is
     |      ``range(len(array) - 1)`` with a zero placed
     |      in every other element:
     |      ``indices = zeros(2 * len(a) - 1)``, ``indices[1::2] = range(1, len(a))``.
     |      
     |      Don't be fooled by this attribute's name: `reduceat(a)` is not
     |      necessarily smaller than `a`.
     |      
     |      Examples
     |      --------
     |      To take the running sum of four successive values:
     |      
     |      >>> np.add.reduceat(np.arange(8),[0,4, 1,5, 2,6, 3,7])[::2]
     |      array([ 6, 10, 14, 18])
     |      
     |      A 2-D example:
     |      
     |      >>> x = np.linspace(0, 15, 16).reshape(4,4)
     |      >>> x
     |      array([[  0.,   1.,   2.,   3.],
     |             [  4.,   5.,   6.,   7.],
     |             [  8.,   9.,  10.,  11.],
     |             [ 12.,  13.,  14.,  15.]])
     |      
     |      ::
     |      
     |       # reduce such that the result has the following five rows:
     |       # [row1 + row2 + row3]
     |       # [row4]
     |       # [row2]
     |       # [row3]
     |       # [row1 + row2 + row3 + row4]
     |      
     |      >>> np.add.reduceat(x, [0, 3, 1, 2, 0])
     |      array([[ 12.,  15.,  18.,  21.],
     |             [ 12.,  13.,  14.,  15.],
     |             [  4.,   5.,   6.,   7.],
     |             [  8.,   9.,  10.,  11.],
     |             [ 24.,  28.,  32.,  36.]])
     |      
     |      ::
     |      
     |       # reduce such that result has the following two columns:
     |       # [col1 * col2 * col3, col4]
     |      
     |      >>> np.multiply.reduceat(x, [0, 3], 1)
     |      array([[    0.,     3.],
     |             [  120.,     7.],
     |             [  720.,    11.],
     |             [ 2184.,    15.]])
     |  
     |  ----------------------------------------------------------------------
     |  Data descriptors defined here:
     |  
     |  identity
     |      The identity value.
     |      
     |      Data attribute containing the identity element for the ufunc, if it has one.
     |      If it does not, the attribute value is None.
     |      
     |      Examples
     |      --------
     |      >>> np.add.identity
     |      0
     |      >>> np.multiply.identity
     |      1
     |      >>> np.power.identity
     |      1
     |      >>> print np.exp.identity
     |      None
     |  
     |  nargs
     |      The number of arguments.
     |      
     |      Data attribute containing the number of arguments the ufunc takes, including
     |      optional ones.
     |      
     |      Notes
     |      -----
     |      Typically this value will be one more than what you might expect because all
     |      ufuncs take  the optional "out" argument.
     |      
     |      Examples
     |      --------
     |      >>> np.add.nargs
     |      3
     |      >>> np.multiply.nargs
     |      3
     |      >>> np.power.nargs
     |      3
     |      >>> np.exp.nargs
     |      2
     |  
     |  nin
     |      The number of inputs.
     |      
     |      Data attribute containing the number of arguments the ufunc treats as input.
     |      
     |      Examples
     |      --------
     |      >>> np.add.nin
     |      2
     |      >>> np.multiply.nin
     |      2
     |      >>> np.power.nin
     |      2
     |      >>> np.exp.nin
     |      1
     |  
     |  nout
     |      The number of outputs.
     |      
     |      Data attribute containing the number of arguments the ufunc treats as output.
     |      
     |      Notes
     |      -----
     |      Since all ufuncs can take output arguments, this will always be (at least) 1.
     |      
     |      Examples
     |      --------
     |      >>> np.add.nout
     |      1
     |      >>> np.multiply.nout
     |      1
     |      >>> np.power.nout
     |      1
     |      >>> np.exp.nout
     |      1
     |  
     |  ntypes
     |      The number of types.
     |      
     |      The number of numerical NumPy types - of which there are 18 total - on which
     |      the ufunc can operate.
     |      
     |      See Also
     |      --------
     |      numpy.ufunc.types
     |      
     |      Examples
     |      --------
     |      >>> np.add.ntypes
     |      18
     |      >>> np.multiply.ntypes
     |      18
     |      >>> np.power.ntypes
     |      17
     |      >>> np.exp.ntypes
     |      7
     |      >>> np.remainder.ntypes
     |      14
     |  
     |  signature
     |  
     |  types
     |      Returns a list with types grouped input->output.
     |      
     |      Data attribute listing the data-type "Domain-Range" groupings the ufunc can
     |      deliver. The data-types are given using the character codes.
     |      
     |      See Also
     |      --------
     |      numpy.ufunc.ntypes
     |      
     |      Examples
     |      --------
     |      >>> np.add.types
     |      ['??->?', 'bb->b', 'BB->B', 'hh->h', 'HH->H', 'ii->i', 'II->I', 'll->l',
     |      'LL->L', 'qq->q', 'QQ->Q', 'ff->f', 'dd->d', 'gg->g', 'FF->F', 'DD->D',
     |      'GG->G', 'OO->O']
     |      
     |      >>> np.multiply.types
     |      ['??->?', 'bb->b', 'BB->B', 'hh->h', 'HH->H', 'ii->i', 'II->I', 'll->l',
     |      'LL->L', 'qq->q', 'QQ->Q', 'ff->f', 'dd->d', 'gg->g', 'FF->F', 'DD->D',
     |      'GG->G', 'OO->O']
     |      
     |      >>> np.power.types
     |      ['bb->b', 'BB->B', 'hh->h', 'HH->H', 'ii->i', 'II->I', 'll->l', 'LL->L',
     |      'qq->q', 'QQ->Q', 'ff->f', 'dd->d', 'gg->g', 'FF->F', 'DD->D', 'GG->G',
     |      'OO->O']
     |      
     |      >>> np.exp.types
     |      ['f->f', 'd->d', 'g->g', 'F->F', 'D->D', 'G->G', 'O->O']
     |      
     |      >>> np.remainder.types
     |      ['bb->b', 'BB->B', 'hh->h', 'HH->H', 'ii->i', 'II->I', 'll->l', 'LL->L',
     |      'qq->q', 'QQ->Q', 'ff->f', 'dd->d', 'gg->g', 'OO->O']
    
    

## Variables
Store the values in variables using assignment '=' , '<-' will not work in
Python


    SquareRoot2 = sqrt(2)
    SquareRoot2




    1.4142135623730951




    HoursYear = 365*24
    HoursYear




    8760



see names in current scope
You will see a much shorter list if you are using the basic python prompt
You can use 'name' in dir() to test if a object by that name existed in the
scope or not


    dir()[:5]




    ['ALLOW_THREADS', 'Annotation', 'Arrow', 'Artist', 'AutoLocator']




    'HoursYear' in dir()




    True



Similarily you can use locals().keys()


    locals().keys()[:5]




    ['disp', 'union1d', 'all', 'dist', 'issubsctype']




    'HoursYear' in locals().keys()




    True



# VIDEO 3

## Vectors
use numpy array to store a vector


    import numpy as np
    np.array([2,3,5,8,13])




    array([ 2,  3,  5,  8, 13])




    Country = np.array(["Brazil", "China", "India","Switzerland","USA"])
    LifeExpectancy = np.array([74,76,65,83,79])
    Country




    array(['Brazil', 'China', 'India', 'Switzerland', 'USA'], 
          dtype='|S11')



use print to see the output in a nicer way


    print Country

    ['Brazil' 'China' 'India' 'Switzerland' 'USA']
    


    print LifeExpectancy

    [74 76 65 83 79]
    

Getting the element from numpy arrary using index ( starts from 0 rahter than 1
in R)


    Country[0]




    'Brazil'




    LifeExpectancy[2]




    65



Create a array of fixed step integers using arange(), notice the end point is
excluded, so you need +1


    Sequence = np.arange(0,100+1,2)
    Sequence




    array([  0,   2,   4,   6,   8,  10,  12,  14,  16,  18,  20,  22,  24,
            26,  28,  30,  32,  34,  36,  38,  40,  42,  44,  46,  48,  50,
            52,  54,  56,  58,  60,  62,  64,  66,  68,  70,  72,  74,  76,
            78,  80,  82,  84,  86,  88,  90,  92,  94,  96,  98, 100])



## Data Frames
a DataFrame is a table-like data structure
there are many ways to create a dataframe, I prefer to pass in data as a
dictionary.
This way, which vector becomes which column will be very clear


    from pandas import DataFrame
    CountryData = DataFrame({'Country':Country, 'LifeExpectancy':LifeExpectancy})
    print CountryData

           Country  LifeExpectancy
    0       Brazil              74
    1        China              76
    2        India              65
    3  Switzerland              83
    4          USA              79
    

Use dataframeName['columnName'] to access column in the dataframe
Add a new column named 'Population'


    CountryData['Population'] = np.array([199000,1390000,1240000,7997,318000])
    print CountryData

           Country  LifeExpectancy  Population
    0       Brazil              74      199000
    1        China              76     1390000
    2        India              65     1240000
    3  Switzerland              83        7997
    4          USA              79      318000
    

Example of creating a new 'shorter' dateframe and append to the above one by row


    Country = np.array(['Australia','Greece'])
    LifeExpectancy = np.array([82, 81])
    Population = np.array([23050, 11125])
    
    NewCountryData = DataFrame({'Country':Country, 'LifeExpectancy':LifeExpectancy,
            'Population':Population})
    
    print NewCountryData

         Country  LifeExpectancy  Population
    0  Australia              82       23050
    1     Greece              81       11125
    


    AllCountryData = CountryData.append(NewCountryData)
    print AllCountryData

           Country  LifeExpectancy  Population
    0       Brazil              74      199000
    1        China              76     1390000
    2        India              65     1240000
    3  Switzerland              83        7997
    4          USA              79      318000
    0    Australia              82       23050
    1       Greece              81       11125
    

notice the index is not correctly updated, need a quick fix


    AllCountryData.index = range(len(AllCountryData))
    print AllCountryData

           Country  LifeExpectancy  Population
    0       Brazil              74      199000
    1        China              76     1390000
    2        India              65     1240000
    3  Switzerland              83        7997
    4          USA              79      318000
    5    Australia              82       23050
    6       Greece              81       11125
    

or we can add a second parameter when calling the



    print CountryData.append(NewCountryData, True)

           Country  LifeExpectancy  Population
    0       Brazil              74      199000
    1        China              76     1390000
    2        India              65     1240000
    3  Switzerland              83        7997
    4          USA              79      318000
    5    Australia              82       23050
    6       Greece              81       11125
    

# VIDEO 4
## change the working directory to where the data file loacted...


    import os
    path = 'C:\\Users\\iris\\documents\\github\\edX\\The Analytic Edge\\week1'
    os.chdir(path)

## Loading csv files


    import pandas as pd
    WHO = pd.read_csv("WHO.csv")

see the first 5 rows in the dataframe


    WHO.head()




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>Region</th>
      <th>Population</th>
      <th>Under15</th>
      <th>Over60</th>
      <th>FertilityRate</th>
      <th>LifeExpectancy</th>
      <th>ChildMortality</th>
      <th>CellularSubscribers</th>
      <th>LiteracyRate</th>
      <th>GNI</th>
      <th>PrimarySchoolEnrollmentMale</th>
      <th>PrimarySchoolEnrollmentFemale</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td> Afghanistan</td>
      <td> Eastern Mediterranean</td>
      <td> 29825</td>
      <td> 47.42</td>
      <td>  3.82</td>
      <td> 5.40</td>
      <td> 60</td>
      <td>  98.5</td>
      <td> 54.26</td>
      <td>  NaN</td>
      <td> 1140</td>
      <td>  NaN</td>
      <td>  NaN</td>
    </tr>
    <tr>
      <th>1</th>
      <td>     Albania</td>
      <td>                Europe</td>
      <td>  3162</td>
      <td> 21.33</td>
      <td> 14.93</td>
      <td> 1.75</td>
      <td> 74</td>
      <td>  16.7</td>
      <td> 96.39</td>
      <td>  NaN</td>
      <td> 8820</td>
      <td>  NaN</td>
      <td>  NaN</td>
    </tr>
    <tr>
      <th>2</th>
      <td>     Algeria</td>
      <td>                Africa</td>
      <td> 38482</td>
      <td> 27.42</td>
      <td>  7.17</td>
      <td> 2.83</td>
      <td> 73</td>
      <td>  20.0</td>
      <td> 98.99</td>
      <td>  NaN</td>
      <td> 8310</td>
      <td> 98.2</td>
      <td> 96.4</td>
    </tr>
    <tr>
      <th>3</th>
      <td>     Andorra</td>
      <td>                Europe</td>
      <td>    78</td>
      <td> 15.20</td>
      <td> 22.86</td>
      <td>  NaN</td>
      <td> 82</td>
      <td>   3.2</td>
      <td> 75.49</td>
      <td>  NaN</td>
      <td>  NaN</td>
      <td> 78.4</td>
      <td> 79.4</td>
    </tr>
    <tr>
      <th>4</th>
      <td>      Angola</td>
      <td>                Africa</td>
      <td> 20821</td>
      <td> 47.58</td>
      <td>  3.84</td>
      <td> 6.10</td>
      <td> 51</td>
      <td> 163.5</td>
      <td> 48.38</td>
      <td> 70.1</td>
      <td> 5230</td>
      <td> 93.1</td>
      <td> 78.2</td>
    </tr>
  </tbody>
</table>
</div>



# to see the structure of the data frame
Can't find a exact equalvalent function to str() in R


    print WHO.shape

    (194, 13)
    


    print WHO.dtypes

    Country                           object
    Region                            object
    Population                         int64
    Under15                          float64
    Over60                           float64
    FertilityRate                    float64
    LifeExpectancy                     int64
    ChildMortality                   float64
    CellularSubscribers              float64
    LiteracyRate                     float64
    GNI                              float64
    PrimarySchoolEnrollmentMale      float64
    PrimarySchoolEnrollmentFemale    float64
    dtype: object
    


    print WHO.values.T[:,:5]

    [['Afghanistan' 'Albania' 'Algeria' 'Andorra' 'Angola']
     ['Eastern Mediterranean' 'Europe' 'Africa' 'Europe' 'Africa']
     [29825L 3162L 38482L 78L 20821L]
     [47.42 21.33 27.42 15.2 47.58]
     [3.82 14.93 7.17 22.86 3.84]
     [5.4 1.75 2.83 nan 6.1]
     [60L 74L 73L 82L 51L]
     [98.5 16.7 20.0 3.2 163.5]
     [54.26 96.39 98.99 75.49 48.38]
     [nan nan nan nan 70.1]
     [1140.0 8820.0 8310.0 nan 5230.0]
     [nan nan 98.2 78.4 93.1]
     [nan nan 96.4 79.4 78.2]]
    

## Print out a summary of variables in the dataframe
The outputed infomation is slightly different


    WHO.describe(include = 'all')




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>Region</th>
      <th>Population</th>
      <th>Under15</th>
      <th>Over60</th>
      <th>FertilityRate</th>
      <th>LifeExpectancy</th>
      <th>ChildMortality</th>
      <th>CellularSubscribers</th>
      <th>LiteracyRate</th>
      <th>GNI</th>
      <th>PrimarySchoolEnrollmentMale</th>
      <th>PrimarySchoolEnrollmentFemale</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>                194</td>
      <td>    194</td>
      <td>     194.000000</td>
      <td> 194.000000</td>
      <td> 194.000000</td>
      <td> 183.000000</td>
      <td> 194.000000</td>
      <td> 194.000000</td>
      <td> 184.000000</td>
      <td> 103.000000</td>
      <td>   162.000000</td>
      <td> 101.000000</td>
      <td> 101.000000</td>
    </tr>
    <tr>
      <th>unique</th>
      <td>                194</td>
      <td>      6</td>
      <td>            NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>          NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
    </tr>
    <tr>
      <th>top</th>
      <td> Russian Federation</td>
      <td> Europe</td>
      <td>            NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>          NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
    </tr>
    <tr>
      <th>freq</th>
      <td>                  1</td>
      <td>     53</td>
      <td>            NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
      <td>          NaN</td>
      <td>        NaN</td>
      <td>        NaN</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>   36359.974227</td>
      <td>  28.732423</td>
      <td>  11.163660</td>
      <td>   2.940656</td>
      <td>  70.010309</td>
      <td>  36.148969</td>
      <td>  93.641522</td>
      <td>  83.710680</td>
      <td> 13320.925926</td>
      <td>  90.850495</td>
      <td>  89.632673</td>
    </tr>
    <tr>
      <th>std</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>  137903.141241</td>
      <td>  10.534573</td>
      <td>   7.149331</td>
      <td>   1.480984</td>
      <td>   9.259075</td>
      <td>  37.992935</td>
      <td>  41.400447</td>
      <td>  17.530645</td>
      <td> 15192.988650</td>
      <td>  11.017147</td>
      <td>  12.817614</td>
    </tr>
    <tr>
      <th>min</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>       1.000000</td>
      <td>  13.120000</td>
      <td>   0.810000</td>
      <td>   1.260000</td>
      <td>  47.000000</td>
      <td>   2.200000</td>
      <td>   2.570000</td>
      <td>  31.100000</td>
      <td>   340.000000</td>
      <td>  37.200000</td>
      <td>  32.500000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>    1695.750000</td>
      <td>  18.717500</td>
      <td>   5.200000</td>
      <td>   1.835000</td>
      <td>  64.000000</td>
      <td>   8.425000</td>
      <td>  63.567500</td>
      <td>  71.600000</td>
      <td>  2335.000000</td>
      <td>  87.700000</td>
      <td>  87.300000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>    7790.000000</td>
      <td>  28.650000</td>
      <td>   8.530000</td>
      <td>   2.400000</td>
      <td>  72.500000</td>
      <td>  18.600000</td>
      <td>  97.745000</td>
      <td>  91.800000</td>
      <td>  7870.000000</td>
      <td>  94.700000</td>
      <td>  95.100000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td>   24535.250000</td>
      <td>  37.752500</td>
      <td>  16.687500</td>
      <td>   3.905000</td>
      <td>  76.000000</td>
      <td>  55.975000</td>
      <td> 120.805000</td>
      <td>  97.850000</td>
      <td> 17557.500000</td>
      <td>  98.100000</td>
      <td>  97.900000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>                NaN</td>
      <td>    NaN</td>
      <td> 1390000.000000</td>
      <td>  49.990000</td>
      <td>  31.920000</td>
      <td>   7.580000</td>
      <td>  83.000000</td>
      <td> 181.600000</td>
      <td> 196.410000</td>
      <td>  99.800000</td>
      <td> 86440.000000</td>
      <td> 100.000000</td>
      <td> 100.000000</td>
    </tr>
  </tbody>
</table>
</div>



## Subsetting


    WHO_Europe =  WHO[WHO.Region == "Europe"]
    WHO_Europe.shape




    (53, 13)



## Writing csv files


    WHO_Europe.to_csv("WHO_Europe.csv")

## Removing variables


    del(WHO_Europe)

# VIDEO 5
## Basic data analysis


    WHO['Under15'].mean()




    28.732422680412363




    WHO['Under15'].std()




    10.534573319923823




    WHO['Under15'].describe()




    count    194.000000
    mean      28.732423
    std       10.534573
    min       13.120000
    25%       18.717500
    50%       28.650000
    75%       37.752500
    max       49.990000
    Name: Under15, dtype: float64




    WHO['Under15'].idxmin()




    85




    WHO['Country'][85]




    'Japan'




    WHO['Under15'].idxmax()




    123



equvalent way to setting the value:


    WHO.at[123,'Country']




    'Niger'



## Scatterplot


    WHO.plot('GNI', 'FertilityRate', kind = 'scatter')




    <matplotlib.axes._subplots.AxesSubplot at 0xd5ca048>




![png](IntroducitonPython_files/IntroducitonPython_73_1.png)


## Subsetting


    Outliers = WHO[(WHO.GNI > 10000) & (WHO.FertilityRate > 2.5)]
    Outliers.shape[0]




    7




    Outliers[['Country','GNI','FertilityRate']]




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>Country</th>
      <th>GNI</th>
      <th>FertilityRate</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>22 </th>
      <td>          Botswana</td>
      <td> 14550</td>
      <td> 2.71</td>
    </tr>
    <tr>
      <th>55 </th>
      <td> Equatorial Guinea</td>
      <td> 25620</td>
      <td> 5.04</td>
    </tr>
    <tr>
      <th>62 </th>
      <td>             Gabon</td>
      <td> 13740</td>
      <td> 4.18</td>
    </tr>
    <tr>
      <th>82 </th>
      <td>            Israel</td>
      <td> 27110</td>
      <td> 2.92</td>
    </tr>
    <tr>
      <th>87 </th>
      <td>        Kazakhstan</td>
      <td> 11250</td>
      <td> 2.52</td>
    </tr>
    <tr>
      <th>130</th>
      <td>            Panama</td>
      <td> 14510</td>
      <td> 2.52</td>
    </tr>
    <tr>
      <th>149</th>
      <td>      Saudi Arabia</td>
      <td> 24700</td>
      <td> 2.76</td>
    </tr>
  </tbody>
</table>
</div>



# VIDEO 6
## Histograms


    WHO.plot(y = 'CellularSubscribers', kind = 'hist', legend = False)




    <matplotlib.axes._subplots.AxesSubplot at 0xe3990b8>




![png](IntroducitonPython_files/IntroducitonPython_78_1.png)


## Boxplot
Using default settings


    WHO.boxplot('LifeExpectancy', by = 'Region')




    <matplotlib.axes._subplots.AxesSubplot at 0xe41b080>




![png](IntroducitonPython_files/IntroducitonPython_80_1.png)


tweaking the params a little bit to get a nicer plot
The code is a bit messy....


    fig = plt.figure()
    WHO.boxplot('LifeExpectancy', by = 'Region', rot = 60)
    plt.title("Life Expectancy of Countries by Region")
    plt.suptitle("")
    plt.ylabel("Life Expectancy")




    <matplotlib.text.Text at 0x11674240>




    <matplotlib.figure.Figure at 0x10946b70>



![png](IntroducitonPython_files/IntroducitonPython_82_2.png)


## Summary Tables
A bit more complicated than in R


    WHO.groupby('Region').size()




    Region
    Africa                   46
    Americas                 35
    Eastern Mediterranean    22
    Europe                   53
    South-East Asia          11
    Western Pacific          27
    dtype: int64




    WHO.groupby('Region')['Over60'].mean()




    Region
    Africa                    5.220652
    Americas                 10.943714
    Eastern Mediterranean     5.620000
    Europe                   19.774906
    South-East Asia           8.769091
    Western Pacific          10.162963
    Name: Over60, dtype: float64




    WHO.groupby('Region')['LiteracyRate'].min()




    Region
    Africa                   31.1
    Americas                 75.2
    Eastern Mediterranean    63.9
    Europe                   95.2
    South-East Asia          56.8
    Western Pacific          60.6
    Name: LiteracyRate, dtype: float64


