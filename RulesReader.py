from Expression import Expression
from Rule import Rule


# Reads a set of rules from a .txt file
# Returns a list of rules
def readdtrules(path):
    src = open(path, 'r')
    res = []

    for l in src:
        newa = [] 
        ac = l.split("/")  
        cns = ac[1].strip('\n') 
        cns = cns.strip(' ')
        atkns = ac[0].split("&") 

        for c in atkns:
            ctkns = c.strip(' ').split(" ")
            exp = Expression(ctkns[0], ctkns[1], float(ctkns[2]))
            newa.append(exp) 

        newrl = Rule(newa, cns)
        res.append(newrl)

    return res
