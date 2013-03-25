import numpy as np
import pylab as P
from matplotlib import mpl, cm

def check_sum(n):
    op1, op2 = np.meshgrid(range(n),range(n))
    @np.vectorize
    def has_carry(o1,o2):
        res = o1+o2
        #return int(res.bit_length()>max([o1.bit_length(),o2.bit_length()]))
        return res.bit_length()
    return has_carry(op1,op2)

def check_sub(n):
    op1, op2 = np.meshgrid(range(n),range(n))
    @np.vectorize
    def has_carry(o1,o2):
        res = o1-o2
        #return int(res.bit_length()>max([o1.bit_length(),o2.bit_length()]))
        return res.bit_length()
    return has_carry(op1,op2)

def check_mul(n):
    op1, op2 = np.meshgrid(range(n),range(n))
    @np.vectorize
    def has_carry(o1,o2):
        res = o1*o2
        #return int(res.bit_length()>max([o1.bit_length(),o2.bit_length()]))
        return res.bit_length()
    return has_carry(op1,op2)

def check_div(n):
    op1, op2 = np.meshgrid(range(1,n),range(1,n))
    @np.vectorize
    def has_carry(o1,o2):
        res = o1/o2
        #return int(res.bit_length()>max([o1.bit_length(),o2.bit_length()]))
        return res.bit_length()
    return has_carry(op1,op2)

def main():
    #P.set_cmap('Paired')
    tam = 256
    #ncm = np.array([i.bit_length() for i in range(tam)])
    #ncm *= 4
    #lcm = mpl.colors.ListedColormap(np.squeeze(cm.Paired(ncm))[:,:3])
    lcm = cm.Paired
    summat = check_sum(tam)
    submat = check_sub(tam)
    mulmat = check_mul(tam)
    divmat = check_div(tam)
    fig = P.figure()
    fig.add_subplot(221)
    P.pcolor(summat, cmap=lcm)
    P.axis([0,tam,0,tam])
    P.colorbar()
    P.title('Addition')
    fig.add_subplot(222)
    P.pcolor(submat, cmap=lcm)
    P.axis([0,tam,0,tam])
    P.colorbar()
    P.title('Subtraction')
    fig.add_subplot(223)
    P.pcolor(mulmat, cmap=lcm)
    P.axis([0,tam,0,tam])
    P.colorbar()
    P.title('Multiplication')
    fig.add_subplot(224)
    P.pcolor(divmat, cmap=lcm)
    P.axis([0,tam,0,tam])
    P.title('Division')
    P.colorbar()
    P.savefig('bitlength.png',dpi=200)
    P.show()

if __name__=="__main__":
    main()