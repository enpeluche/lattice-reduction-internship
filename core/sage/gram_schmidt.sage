def gram_schmidt(B, transformation=True, norms=True):
    r"""
    Computes the Gram-Schmidt orthogonalization of the rows of a matrix.

    Given a matrix $B$ of size $n \times m$, this function computes a lower 
    triangular matrix $U$ with unit diagonal and a matrix $Q$ with orthogonal 
    rows such that $B = U \times Q$.

    INPUT:
        - ``B`` -- a matrix with coefficients in a ring (e.g., $\mathbb{Z}[x]$ or $\mathbb{ZZ}$).
        - ``transformation`` -- boolean (default: ``True``); if set to ``True``, 
          the function returns the transformation matrix $U$.
        - ``norms`` -- boolean (default: ``True``); if set to ``True``, the function 
          also returns the list of the squared norms of the vectors of $Q$.

    OUTPUT:
        The output depends on the flags:
        - If ``transformation`` is ``False``: returns the matrix $Q$.
        - If ``transformation`` is ``True`` and ``norms`` is ``False``: returns the pair $(U, Q)$.
        - If both are ``True`` (default): returns the triplet $(U, Q, \text{norms})$.

    EXAMPLES::

        sage: B = matrix(ZZ, [[1, 1], [1, 2]])
        sage: U, Q, n = gram_schmidt(B)
        sage: U * Q == B
        True
        sage: Q[0].dot_product(Q[1]) == 0
        True
    """
    n = B.nrows()
    m = B.ncols()
    
    if(n==0):
        raise ValueError("Le rang de la famille doit être non nul.")
            
    fractionField = FractionField(B.base_ring())
    
    U = Matrix.identity(fractionField, n)
    Q = Matrix.zero(fractionField, n, m)
    norms_squared = [fractionField(0)]*n
    
    Q[0] = B[0]
    norms_squared[0] = Q[0].dot_product(Q[0])
    
    for i in range(1, n):
        Q[i] = B[i]
        
        for j in range(i):
            
            if (norms_squared[j] != 0):
                U[i, j] = B[i].dot_product(Q[j]) / norms_squared[j]
            
            Q[i] -= U[i, j] * Q[j]
        
        norms_squared[i] = Q[i].dot_product(Q[i])
        
    if not transformation:
        return Q
    
    if not norms:
        return U, Q
    
    return U, Q, norms_squared
    