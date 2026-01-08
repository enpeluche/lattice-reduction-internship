def is_orthogonal(B):
    r"""
    Checks if the rows of matrix ``B`` form an orthogonal basis.

    Mathematically, this verifies that the Gram matrix $G = B \cdot B^T$ is diagonal.
    Note that this function checks for **orthogonality** (pairwise perpendicular rows), 
    not **orthonormality** (vectors do not need to have unit norm).

    INPUT:
        - ``B`` -- a matrix (usually square).

    OUTPUT:
        - ``True`` if the rows are pairwise orthogonal, ``False`` otherwise.

    EXAMPLES::

        sage: # Standard orthogonal matrix (diagonal)
        sage: B_ortho = matrix(ZZ, [[2, 0], [0, 5]])
        sage: is_orthogonal(B_ortho)
        True
        sage: # Non-orthogonal matrix
        sage: B_skew = matrix(ZZ, [[1, 1], [0, 1]])
        sage: is_orthogonal(B_skew)
        False
    """
    # B * B.T calcule tous les produits scalaires <bi, bj>
    # Si c'est diagonal, alors <bi, bj> = 0 pour tout i != j.
    return (B * B.transpose()).is_diagonal()