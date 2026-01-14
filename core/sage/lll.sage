def row_degree(M):
    row_degree = Matrix(ZZ, 1, M.nrows())

    for i in range(r):
        row_degree[0, i] = max(M[i, j].degree() for j in range(M.nrows()))

    return row_degree

def shifted_row_degree(M, s):
    r = M.nrows()
    c = M.ncols()
    
    shifted_row_degree = Matrix(ZZ, 1, r)

    for i in range(r):
        shifted_row_degree[0, i] = max((M[i, j].degree()+s[j]) for j in range(c))

    return shifted_row_degree



def Gram_Schmidt(B):
    n = B.nrows()
    
    B_star = Matrix(QQ, n, n)
    U = identity_matrix(QQ, n)

    B_star[0] = B[0]
    
    for k in range(1, n):
        B_star[k] = B[k]
        for j in range(k):
            U[k, j] = (B[k] * B_star[j]) / (B_star[j] * B_star[j])
            B_star[k] -= U[k, j]*B_star[j]
    return U, B_star

def diagonal_matrix_from_vector(s):
    # Définir l'anneau des polynômes en x sur les rationnels (ou un autre corps si nécessaire)
    R.<x> = QQ[]
    
    # Créer la matrice diagonale
    n = len(s)
    M = Matrix(R, n, n, lambda i, j: x^s[i] if i == j else 0)
    
    return M

# Exemple d'utilisation :
s = [2, 3, 5]  # Vecteur d'exposants
M = diagonal_matrix_from_vector(s)
print(M)
R.<x> = PolynomialRing(GF(2))  # Anneau des polynômes sur F_2


M = Matrix(R, [[1, 0, 1, 1],
                       [x, 1, x+1, 0],
                       [1, x^3+x^2, x, 0],
                       [x^2, 0, x^4 + x^3, 0]])

print(row_degree(M))
print(shifted_row_degree(M, [1, 0, 0, 1]))


def gram_schmidt_orthogonalization(B):
    """
    Effectue l'orthogonalisation de Gram-Schmidt sur la base B.
    Retourne B* (base orthogonale) et U (matrice des coefficients de transformation).
    """
    n = len(B)
    B_star = [vector(B[0])]  # Initialisation avec le premier vecteur
    U = [[0] * n for _ in range(n)]
    
    for i in range(n):
        U[i][i] = 1  # Coefficients diagonaux de U
        
    for i in range(1, n):
        proj = sum((B[i] * B_star[j]) / (B_star[j] * B_star[j]) * B_star[j] for j in range(i))
        B_star.append(B[i] - proj)
        
        for j in range(i):
            U[i][j] = (B[i] * B_star[j]) / (B_star[j] * B_star[j])
    
    return B_star, U


def draw_2D_lattice(L, show_basis=False, save=False, name="graphic", show_GS=False):
    graphic = Graphics()

    N=7

    #dessin du grillage derriere
    for x in range(-N, N+1):
        graphic += line([(x, -N), (x, N)], color='black', thickness=0.4)
        graphic += line([(-N, x), (N, x)], color='black', thickness=0.4)

    graphic += points([(L[0][0] * i + L[1][0]*j,
                        L[0][1] * i + L[1][1]*j) 
                       for i in range(-2*N-2, 2*N+2)
                       for j in range(-2*N-2, 2*N+2) 
                       if N>=L[0][0]*i+L[1][0]*j>=-N and -N<=L[0][1]*i+L[1][1]*j<=N],
                      color='red', size=30)

    if(show_basis):
        graphic += arrow((0, 0), (L[0][0], L[0][1]), color='blue', width=1)
        graphic += arrow((0, 0), (L[1][0], L[1][1]), color='blue', width=1)

    if(show_GS):
        
        (U, L_star) = Gram_Schmidt(L)
        graphic += arrow((0, 0), (L_star[0][0], L_star[0][1]), color='green', width=1)
        graphic += arrow((0, 0), (L_star[1][0], L_star[1][1]), color='green', width=1)
        
    
    p = plot(graphic)
    p.show(axes=False, aspect_ratio=1)
    if(save):
        p.save(name+".png", dpi=300, axes=False, aspect_ratio=1)

        L=Matrix(ZZ, [[1, -1, 0],
              [1, 0, -1],
              [0, 0, 0]])

def draw_3D_lattice(L):
    graphic = Graphics()

    for i in range(10):
        graphic += points([(L[0][0] * i + L[0][1] * j + L[0][2] * k, 
                            L[1][0] * i + L[1][1] * j + L[1][2] * k,  
                            L[2][0] * i + L[2][1] * j + L[2][2] * k) 
                           for i in range(-13, 13) 
                           for j in range(-13, 13) 
                           for k in range(-13, 13) 
                           if 13>=L[0][0] * i + L[0][1] * j + L[0][2] * k>=0 and 0<=L[1][0] * i + L[1][1] * j + L[1][2] * k<=13 and 0<=L[2][0] * i + L[2][1] * j + L[2][2] * k<=13], color='red', size=30)

    p = plot(graphic)

    p.show(axes=False, aspect_ratio=1)

draw_3D_lattice(L)


import random

def random_lattice(d, coeff_range=(-10, 10)):
    while True:
        L = Matrix(ZZ, [[random.randint(coeff_range[0], coeff_range[1]) for _ in range(d)] for _ in range(d)])
        if L.det() != 0:  # Vérifie que la matrice est inversible
            return L
        
        import time
import matplotlib.pyplot as plt
import numpy as np

# Fonction pour générer une matrice aléatoire et mesurer le temps de multiplication
def mesure_temps_multiplication(n):
    A = random_matrix(QQ, n, n)  # Matrice aléatoire dans les rationnels
    B = random_matrix(QQ, n, n)
    
    start_time = time.time()
    C = A * B  # Multiplication des matrices
    end_time = time.time()
    
    return end_time - start_time  # Temps d'exécution en secondes

# Tester plusieurs tailles de matrices
tailles = [5, 10, 20, 50, 100, 200, 500, 1500]  # Tailles de matrices à tester
temps = [mesure_temps_multiplication(n) for n in tailles]

# Normalisation pour la courbe de référence (éviter des valeurs trop grandes)
facteur_norm = temps[-1] / (tailles[-1] ** 3)  # On normalise pour faire coller à la dernière valeur

# Courbe théorique (O(n^3))
temps_theorique = [facteur_norm * (n ** 3) for n in tailles]

# Affichage des résultats
plt.plot(tailles, temps, marker='o', linestyle='-', label="Temps mesuré")
plt.plot(tailles, temps_theorique, linestyle='--', color='red', label="O(n^3) normalisé")

plt.xlabel("Taille de la matrice (n)")
plt.ylabel("Temps d'exécution (s)")
plt.title("Comparaison du temps mesuré et de O(n^3)")
plt.legend()
plt.grid(True)
plt.show()


#L=random_lattice(2, (-5, 5))

print(L)

draw_2D_lattice(L, show_basis=True, save=True, name="L")

draw_2D_lattice(L, show_GS=True, save=True, name="L*")

draw_2D_lattice(L.LLL(), show_basis=True, save=True, name="L_reduced")


import time
import matplotlib.pyplot as plt
import numpy as np
import random

execution_times = []

dimensions = list(range(100, 130))

for i in dimensions:
    R = random_lattice(i, (-5, 5))
    
    start_time = time.time()
    R_reduced = R.LLL()
    end_time = time.time()

    execution_times.append(end_time - start_time)

# Afficher le graphique
plt.plot(dimensions, execution_times, marker='o', linestyle='-', color='b')
plt.xlabel('Dimension du réseau')
plt.ylabel('Temps d\'exécution (secondes)')
plt.title('Temps d\'exécution de l\'algorithme LLL en fonction de la dimension')
plt.grid(True)
plt.show()

