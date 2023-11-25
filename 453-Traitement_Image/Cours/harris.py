def harris(image, sigma=10, kappa=0.04):
    derivees = gradient(image)
    d_x = derivees[0]
    d_y = derivees[1]
    noyau = noyau_gaussien3(sigma)
    #TODO: convol DoG
    d_xx_lissee = ndimage.convolve(d_x * d_x,noyau , mode = 'nearest')
    d_yx_lissee = ndimage.convolve(d_x * d_y,noyau , mode = 'nearest')
    d_yy_lissee = ndimage.convolve(d_y * d_y,noyau , mode = 'nearest')

    determinant = d_xx_lissee * d_yy_lissee -d_yx_lissee * d_yx_lissee
    trace = d_xx_lissee + d_yy_lissee

    image_harris = determinant - kappa * trace * trace
    return image_harris

def maxlocal(image_harris, seuil,size_patch=10):
    """ Array*float -> Array """
    output = np.zeros(image_harris.shape)
    voisinage = np.zeros((3,3))
    for ligne in range(size_patch,image_harris.shape[0]-size_patch):
        for colonne in range(size_patch,image_harris.shape[1]-size_patch):
            current_val = image_harris[ligne, colonne]
            voisinage = image_harris[ligne - 1: ligne + 2, colonne - 1:colonne + 2].copy()
            voisinage[(1,1)] = 0
            output[ligne, colonne] = np.logical_and(current_val > seuil,
                                                    current_val > np.amax(voisinage))
    print(output)
    return(output)

def coord_maxlocal(image,seuil,size_patch=3):
    #seuil=np.mean(image_extrema)
    """ Array -> Array """
    x,y = np.nonzero(maxlocal(image,seuil))
    return np.array((y,x)).T

def get_corners(pict):
    image_harris = harris(pict,sigma=3,kappa=0.06)
    corners = coord_maxlocal(image_harris,np.mean(image_harris))
    return corners

pict1 = np.array(Image.open("set1-1.png").convert('L'),dtype='float')
pict2 = np.array(Image.open("set1-2.png").convert('L'),dtype='float')
corners1=get_corners(pict1)
corners2=get_corners(pict2)
