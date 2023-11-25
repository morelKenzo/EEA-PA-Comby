    def calcul_acc_cercles(img_s, rad_min=5, rad_max=100):
    #init acc :
    [c_max, r_max] = img_s.shape
    r_min=1
    delta_r = 1
    N_r =  int((r_max-r_min+delta_r)/delta_r)
    delta_c = 1
    c_min = 1
    N_c =  int((c_max-c_min+delta_c)/delta_c)
    delta_rad = 1
    N_rad =  int((rad_max-rad_min+delta_rad)/delta_rad)
    acc = np.zeros((N_rad,N_r,N_c))
    print("Taille de l'accumulateur" + str(acc.shape))
    x,y = np.nonzero(img_s)
    for i in range(len(x)):
        for r in range(r_min, r_max+1, delta_r):
            for c in range(c_min, c_max+1, delta_c):
                if (x[i],y[i]) != (r,c):
                    rad = np.sqrt((r-x[i])**2 + (c-y[i])**2)
                    if rad < rad_max and rad > rad_min:
                        i_id = int((r-r_min)/delta_r)
                        j_id = int((c-c_min)/delta_c)
                        k_id = int((rad-rad_min)/delta_rad)
                        acc[k_id,i_id,j_id] += 1 /rad
    return acc
def cherche_N_maxima_cercles(accumulateur, exclusion_xy,
exclusion_rayon, N):
    accu2 = np.copy(accumulateur)
    [rad_max0, c_max0, r_max0] = accumulateur.shape
    liste_max = []
    for cercle in range(N):
        [rayon, w_0, h_0] = np.unravel_index(np.argmax(accu2),accu2.shape)
        rayon += 5
        w_0 += 1
        h_0 += 1
        accu2[rayon - exclusion_rayon : rayon + exclusion_rayon,
              w_0 -exclusion_xy : w_0 + exclusion_xy,
              h_0 - exclusion_xy : h_0 + exclusion_xy] =0
        liste_max.append([rayon, w_0, h_0])
    return liste_max
