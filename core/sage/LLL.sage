
#cette version ?
def LLL(B, delta=0.9, shift=None, plot=False):
    
    G = copy(B)
    n = G.nrows()
    m = G.ncols()
    
    if shift is not None:
        return nint(LLL(G*shift)*shift.inverse()).change_ring(ZZ)
    
    total_steps = 0
    total_exchanges = 0
    
    Q,U = G.gram_schmidt()
    norms_squared= [Q[i].dot_product(Q[i]) for i in range(n)]
    
    #print(U)
    #print("")
    i = 1
    
    
    
    while i < n:
        total_steps += 1
        #SIZE-REDUCTION
         
        for j in range(i-1, -1, -1):
            if i == 0: break
                
            c = nint(U[i, j])
                
            if(c != 0):
                G.add_multiple_of_row(i, j, -c)
                U.add_multiple_of_row(i, j, -c)
        
        #CONDITION DE LOVASZ
        if i>0 and (delta - U[i, i-1]**2) * norms_squared[i-1] > norms_squared[i]:
        #if i>0 and norms_squared[i-1]>2*norms_squared[i]:
            total_exchanges += 1
                    
            G.swap_rows(i-1, i)
            
            Q,U = G.gram_schmidt()
            norms_squared= [Q[i].dot_product(Q[i]) for i in range(n)]
            
            if plot:
                sandpile(G, str(number_exchange)+'_LLL', save=True, show_=False)
                
            #print(i-1, i)
            #print(U)
            #print("")
            i -= 1 
            
        else:
            i += 1
    
    print("Total exchange:", total_exchanges)
    print("Total steps:", total_steps)
    return G